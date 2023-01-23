""" Dieses Modul beinhaltet zahlreiche Funktionalitäten
zum Parsen und Konvertieren von Studentendaten."""


import csv
from itertools import groupby
from .models import Assignment, Student
from .exceptions import CSVStudentParserException

# stores key map for students for solution writeback to database
# like so: {pk_of_student_in_database:index_of_student_in_algo}
studkey_db2algo = {}
# {index_of_student_in_algo:pk_of_student_in_database}
studkey_algo2db = {}

# project key map
# {pk_of_project_in_database:index_of_project_in_algo}
pjkey_db2algo = {}
# {index_of_project_in_algo:pk_of_project_in_database}
pjkey_algo2db = {}

# role key map
# (db) 1 Teamleiter         -> (algo) 4 Teamleiter
# (db) 2 Analyse            -> (algo) 0 Analyse
# (db) 3 Entwurf            -> (algo) 1 Entwurf
# (db) 4 Implementierung    -> (algo) 2 Implementierung
# (db) 5 Test               -> (algo) 3 Test
rolekey_db2algo = {1: 4, 2: 0, 3: 1, 4: 2, 5: 3}
rolekey_algo2db = {4: 1, 0: 2, 1: 3, 2: 4, 3: 5}


def queryset2algo(q_polls: list, q_projects: list, q_project_answers: list, q_role_answers: list):

    def student_key(x): return x[0]

    wings = []
    project_answers = {}
    role_answers = {}

    # update student_keys keymap
    studkey_db2algo.clear()
    studkey_algo2db.clear()
    for i in range(len(q_polls)):
        studkey_db2algo[q_polls[i][0]] = i
        studkey_algo2db[i] = q_polls[i][0]
        wings.append(int(q_polls[i][1]))

    # update project_keys keymap
    pjkey_db2algo.clear()
    pjkey_algo2db.clear()
    for i in range(len(q_projects)):
        pjkey_db2algo[q_projects[i][0]] = i
        pjkey_algo2db[i] = q_projects[i][0]

    project_answers = {}
    for key, g in groupby(q_project_answers, student_key):
        group = list(g)
        d = {}
        for i in range(len(group)):
            d[pjkey_db2algo.get(group[i][1])] = group[i][2]
        project_answers[studkey_db2algo.get(key)] = d

    for key, g in groupby(q_role_answers, student_key):
        group = list(g)
        d = {}
        for i in range(len(group)):
            d[rolekey_db2algo.get(group[i][1])] = group[i][2]
        role_answers[studkey_db2algo.get(key)] = d

    result = {"project_answers": project_answers, "role_answers": role_answers,
              "wing": wings}
    return result


# write algo result back to database
def save_result(algo_result):
    assignments = []
    for a in algo_result:
        assignment = Assignment(
            student_id=studkey_algo2db.get(a[1]),
            project_id=pjkey_algo2db.get(a[0]),
            role_id=rolekey_algo2db.get(a[2]))
        assignments.append(assignment)
    Assignment.objects.bulk_create(assignments)

# write data from a given file object to /tmp/students.csv


def save_csv(file):
    with open("/tmp/students.csv", "wb+") as destination:
        for chunk in file.chunks():
            destination.write(chunk)

# reads csv file from filepath and parses models.Student objects


class CSVStudentParser:
    """Ermöglicht das Lesen von Studentendaten aus einer CSV-
    Datei. Aus den gelesenen Daten können Student Objekte erstellt
    und in der Datenbank gespeichert werden.

    Eine CSV-Datei muss folgende Spalten mit entsprechenden
    Spalten-Headern beinhalten:
    Anrede, Vorname, Nachname, E-Mail-Adresse, Studiengruppe.
    Die Reihenfolge ist dabei egal.

    :param filepath: absoluter Pfad zur CSV Datei
    :type filepath: str
    """

    def __init__(self, filepath):
        self.filepath = filepath
        self.students = []  # stores parsed Student objects
        # csv column headers
        self.titles = []
        self.first_names = []
        self.last_names = []
        self.emails = []
        self.faculties = []
        self.headers = {
            "Anrede": self.titles,
            "Vorname": self.first_names,
            "Nachname": self.last_names,
            "E-Mail-Adresse": self.emails,
            "Studiengruppe": self.faculties
        }

    def get_students(self):
        """:return: self.students
        :rtype: list(models.Student)"""

        return self.students

    def check_validity(self, head_row: list):
        """Prüft die Anzahl der Spalten und die Namen der Spalten
        Header auf Korrektheit

        :param head_row: Liste der Spalten Header
        :type head_row: list(str)
        :raises: CSVStudentParserException wenn die Anzahl der Spalten oder
            die Namen der Spalten-Header inkorrekt sind.
        :return: None"""

        valid = any(item in self.headers.keys() for item in head_row)
        if not valid or len(head_row) != len(self.headers):
            raise CSVStudentParserException("invalid column headers")

    # parse s-number from email
    def parse_snum(self, email: str):
        """Parst die s-Nummer aus den ersten 6 Zeichen der Email

        :param email: Email mit dem Aufbau s12345@htw-dresden.de
        :type email: str
        :return: s-Nummer mit dem Aufbau "s12345"
        :rtype: str"""
        return email[:6]

    def parse_title(self, title: str):
        """Parst die Anrede aus den ersten 6 Zeichen der Email

        :param title: Anrede des Studenten
        :type title: str
        :raises: CSVStudentParserException wenn title nicht "Herr"
            oder "Frau"
        :return: 
            * h - für Anrede "Herr"
            * f - für Anrede "Frau"
        :rtype: str"""

        if title == "Herr":
            return "h"
        elif title == "Frau":
            return "f"
        else:
            raise CSVStudentParserException("unknown title")

    def parse_faculty(self, faculty: str):
        """Parst die Fakultät anhand der Studiengangsnummer

        :param faculty: Studiengangsnummer, z.B. 041
        :type faculty: str
        :raises: CSVStudentParserException wenn Studiengangnummer
            inkorrekt ist.
        :return:
            * ia - für Stdg.-Nr 041
            * iv - für Stdg.-Nr 048
            * iw - für Stdg.-Nr 042
            * wi - für Stdg.-Nr 072
        :rtype: str"""
        if faculty[3:6] == "041":
            return "ia"  # Allgemeine Informatik
        elif faculty[3:6] == "048":
            return "iv"  # Verwaltungsinformatik
        elif faculty[3:6] == "042":
            return"iw"  # Wirtschaftsinformatik
        elif faculty[3:6] == "072":
            return "wi"  # Wirtschaftsingenieurwesen
        else:
            raise CSVStudentParserException("unknown faculty number")

    def create_students(self):
        """Erstellt Student Objekte und hängt sie an die
        self.students Liste an.

        :return: None"""

        for i in range(len(self.last_names)):
            student = Student(
                title=self.titles[i],
                first_name=self.first_names[i],
                last_name=self.last_names[i],
                s_num=self.parse_snum(self.emails[i]),
                faculty=self.faculties[i]
            )
            self.students.append(student)

    def parse(self):
        """Startet das Parsen der CSV-Datei. Die Datei wird
        geöffnet, geprüft und mithilfe der anderen parse_ Funktionen
        geparst. Anschließend werden die Studenten Objekte erzeugt und
        in die self.students Liste geschrieben.
        
        :return: None"""

        with open(self.filepath, "r") as file:
            reader = csv.reader(file)
            head_row = next(reader)
            self.check_validity(head_row)

            for row in reader:
                for i, item in enumerate(row):
                    l = self.headers.get(head_row[i])
                    l.append(item)

        for i in range(len(self.faculties)):
            self.faculties[i] = self.parse_faculty(self.faculties[i])

        for i in range(len(self.titles)):
            self.titles[i] = self.parse_title(self.titles[i])

        self.create_students()
