"""
"Eine View-Funktion, oder kurz View, ist eine Python-Funktion,
die einen Web Request entgegennimmt und einen Web Response zurückgibt.
Dieser Response kann HTML, Inhalte einer Seite, ein XML oder JSON Objekt
... oder im Prinzip alles sein" (vgl. Django Dokumentation)

In diesem Fall geben die View Funktionen entweder ein HTML Response
oder ein JSON Objekt bei Ajax Anfragen zurück.
Beim Aufruf dieser View Funktionen können gewisse Logiken wie z.B. das
Ausführen des Zuordnungsalgorithmus getriggert werden.

Eine detaillierte Beschreibung zum Schreiben von View Funktionen ist
in der Django Dokumentation zu finden:
https://docs.djangoproject.com/en/4.0/topics/http/views/
"""

import logging
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import View, ListView, DetailView, CreateView, UpdateView, DeleteView
from django.http import HttpResponseBadRequest, JsonResponse, QueryDict, HttpResponseForbidden
from numpy import true_divide
from .models import *
from .parse import CSVStudentParser, save_csv, save_result, queryset2algo
from .algo import AssignmentAlgo
import json


# Create your views here.

def is_ajax(request):
    """ Gibt zurück, ob ein Request ein Ajax Request ist.
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :return:
        * `True` - wenn Ajax Request
        * `False` - wenn kein Ajax Request
    :rtype: bool"""
    return request.META.get("HTTP_X_REQUESTED_WITH") == "XMLHttpRequest"


def isUserDozent(user):
    """ Gibt zurück, ob ein User der Nutzergruppe `Dozent`
    angehört.
    
    :param user: Django Nutzer
    :type user: django.contrib.auth.User
    :return:
        * `True` - wenn Nutzer in Gruppe `Dozent`
        * `False` - wenn Nutzer nicht in Gruppe `Dozent`
    :rtype: bool"""
    if user.is_authenticated and user.groups.filter(name="Dozent").exists():
        return True
    else:
        return False


def hasUserQuestionnaire(user):  # existiert bereits fragebogen für student
    """Prüft ob ein Nutzer bereits seinen Fragebogen
    ausgefüllt hat.
    
    :param user: Django Nutzer 
    :type user: django.contrib.auth.User
    :return:
        * `True` - wenn Nutzer den Fragebogen ausgefüllt hat
        * `False` - wenn Nutzer den Fragebogen nicht ausgefüllt hat
    :rtype: bool"""
    try:
        snum = user.username
        stud = Student.objects.get(s_num=snum)
        if Poll.objects.filter(student=stud).exists():
            return True
        else:
            return False
    except (Poll.DoesNotExist, Student.DoesNotExist):
        return False


def deleteAllStudentData():
    """Löscht sämtliche Daten, die in Zusammenhang mit Studenten
    stehen. Dies ist bspw. nützlich, wenn der Dozent am Beginn des
    Semesters alle Daten aus den vorherigen Semestern entfernen möchte.
    
    Folgende Daten werden gelöscht:
    
        * alle `models.ProjectAnswer` Objekte
        * alle `models.RoleAnswer` Objekte
        * alle `models.SkillAnswer` Objekte
        * alle `models.Student` Objekte
        * alle `models.Poll` Objekte
        * alle `models.Assignment` Objekte
    
    :return: None
        """
    classes = [Assignment, SkillAnswer,
               RoleAnswer, ProjectAnswer, Poll, Student]
    for c in classes:
        c.objects.all().delete()


def AppHome(request):
    """Implementiert den View der Homepage. In diesem View können
    die Abschitte Projekte, Fragebogen und Teams angezeigt werden.
    Die Sichtbarkeit dieser Abschnitte kann mithilfe der
    `teamverwaltung_main.views.VerwaltungSectionControl` Funktion
    vom Dozenten gesteuert werden.

    Wenn der Nutzer als Student angemeldet ist und den Fragebogen
    bereits ausgefüllt hat, so werden seine bereits getätigten
    Antworten für den Nutzer ersichtlich in den Fragbeogen
    geladen.

    :return: gerendertes HTML Template index.html
    :rtype: django.http.HttpResponse
    """

    projects = Project.objects.all()
    sec_themen = SectionControl.objects.get(section="themen")
    sec_fragebogen = SectionControl.objects.get(section="fragebogen")
    sec_fragebogen_readonly = SectionControl.objects.get(section="fragebogen_readonly")
    sec_teams = SectionControl.objects.get(section="teams")

    poll_projects = {}
    poll_roles = {}
    poll_skills = {}

    teams = ""

    if hasUserQuestionnaire(request.user):
        stud = Student.objects.get(s_num=request.user.username)
        p = Poll.objects.get(student=stud)
        pa = ProjectAnswer.objects.all().filter(poll=p)
        ra = RoleAnswer.objects.all().filter(poll=p)
        sa = SkillAnswer.objects.all().filter(poll=p)

        for panswer in pa:
            poll_projects[str(panswer.project.pk)] = panswer.score

        for ranswer in ra:
            poll_roles[str(ranswer.role.role)] = ranswer.score

        for sanswer in sa:
            print("gefunden: " + str(sanswer.skill.abbreviation) + " - " + str(sanswer.score))
            poll_skills[str(sanswer.skill.abbreviation)] = sanswer.score

    if(sec_themen.activated == True):
        teams =  list(Assignment.objects.all().prefetch_related(
            "project", "student").order_by("project_id"))


    return render(
        request,
        "teamverwaltung_main/index.html",
        {
            "projects": projects,
            'teams': teams,
            "sec_themen": sec_themen,
            "sec_fragebogen": sec_fragebogen,
            "sec_fragebogen_readonly": sec_fragebogen_readonly,
            "sec_teams": sec_teams,
            "poll_projects": json.dumps(poll_projects),
            "poll_roles": json.dumps(poll_roles),
            "poll_skills": json.dumps(poll_skills)
        }
    )


def VerwaltungSectionControl(request):
    """Erlaubt das Abfragen und Setzen des Status für die Toggle
    Buttons im Dozentenbereich, um die Sichtbarkeit für die
    Projekte, den Fragebogens, die Teams sowie
    den Schreibschutz für den Fragebogen auf der Homepage zu
    aktivieren oder zu deaktivieren.
    
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:
        * Nutzer ist als Dozent angemeldet
        * `request` ist ein Ajax Request
    :return:
        .. code-block::

            {
                # Visibilität für Abschnitt Themen
                "themen": bool,
                # Visibilität für Abschnitt Fragebogen
                "fragebogen": bool,
                # Visibilität für Abschnitt Teams
                "teams": bool,
                # Schreibschutz für Fragebogen
                "fragebogen_readonly": bool
            }

        Beispiel für sichtbaren Themenabschnitt, sichtbaren
        Fragebogenabschnitt, nicht sichtbaren Teamabschnitt
        und deaktivierten Schreibschutz für den Fragebogen.
        
        .. code-block::

            {
                "themen": true,
                "fragebogen": true,
                "teams": false,
                "fragebogen_readonly": false
            }

    """

    if not isUserDozent(request.user):
        return

    if request.method == "POST" and is_ajax(request):
        sec = request.POST.get("section")
        state = True if request.POST.get("activated") == 'true' else False
        print(sec + ": " + str(state))
        section_obj = SectionControl.objects.get(section=sec)
        section_obj.activated = state
        section_obj.save()

        return JsonResponse({"success": 1}, status=200)
    elif request.method == "GET" and is_ajax(request):
        sections = {}

        for sec in SectionControl.objects.all().iterator():
            sections[sec.section] = sec.activated

        return JsonResponse({"sections": json.dumps(sections)}, status=200)


class VerwaltungThemenOverview(View):
    def get(self, request):  # wenn get anfrage
        if not isUserDozent(request.user):  # nuter angemeldet?
            return
        if is_ajax(request):  # wenn ajax anfrage
            topickey = request.GET.get("topickey")
            # themenspezifische informationen
            topic = Project.objects.get(pk=topickey)
            return JsonResponse(
                {
                    "name": topic.name,
                    "description": topic.description,
                    "responsible": topic.responsible,
                    "pdf": topic.documentfile_url
                },
                status=200
            )

        projects = Project.objects.all()

        # wenn keine ajax anfrage, sende alle themen
        return render(
            request,
            "teamverwaltung_main/verwaltung/themen.html",
            {
                "projects": projects
            }
        )

    def post(self, request):  # wenn post anfrage
        if not isUserDozent(request.user):  # nutzer angemeldet?
            return
        if is_ajax(request):  # wenn ajax anfrage
            topickey = request.POST.get("topickey")
            topic = Project.objects.get(pk=topickey)  # hole themenobjekt
            if request.POST.get("delete"):  # wenn delete anfrage
                topic.delete()
                # sende success
                return JsonResponse({"success": 1}, status=200)

            # wenn update anfrage
            topic.name = request.POST.get("name")  # aktualisiere informationen
            topic.description = request.POST.get("description")
            topic.responsible = request.POST.get("responsible")
            topic.documentfile_url = request.POST.get("pdf")
            topic.save()  # objekt speichern
            return JsonResponse({"success": 1}, status=200)  # sende success

    def delete(self, request):  # wenn delete anfrage
        if not isUserDozent(request.user):
            return
        if is_ajax(request):  # wenn ajax anfrage
            # HTTP DELETE Body serialisieren
            deletebody = QueryDict(request.body)
            topickey = deletebody.get("topickey")
            topic = Project.objects.get(pk=topickey)  # hole themenobjekt
            topic.delete()
            return JsonResponse({"success": 1}, status=200)  # sende success

    def put(self, request):  # wenn put anfrage
        if not isUserDozent(request.user):  # nutzer angemeldet?
            return
        if is_ajax(request):  # wenn ajax anfrage
            putbody = QueryDict(request.body)  # HTTP PUT Body serialisieren
            # neues Themenobjekt anlegen
            newtopic = Project.objects.create(name=putbody.get("name"), description=putbody.get(
                "description"), responsible=putbody.get("responsible"), documentfile_url=putbody.get("pdf"))
            newtopic.save()
            return JsonResponse({"success": 1}, status=200)


def VerwaltungFragebogen(request):
    """Implementiert den Reiter Fragebogen im Dozentenbereich.
    Dieser ermöglicht die Auflistung aller bereits beantworteten
    Fragebögen der Studenten mit Name, s-Nummer und Fakultät.

    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:
        * Nutzer ist als Dozent angemeldet
        * `request`-Methode ist `GET`
    :return: gerendertes Template /verwaltung/fragebogen.html
    :rtype: django.http.HttpResponse"""

    if request.method == "GET":
        if not isUserDozent(request.user):
            return

        polls = Poll.objects.prefetch_related("student").all()

        return render(request, "teamverwaltung_main/verwaltung/fragebogen.html", {"polls": list(polls)})


def VerwaltungFragebogenDetails(request):
    """Ermöglicht das Abfragen von Details aus dem Fragebogen
    eines bestimmten Studenten. Diese Funktion wird bspw. im
    Dozentenbereich im Abschnitt Fragebogen genutzt. Wenn dort
    der Nutzer auf einen bestimmten Studenten klickt, erscheint
    ein Fenster, in dem eingesehen werden kann, welche Projekte,
    Rolle und Skills/ Fähigkeiten wie gut bewertet wurden
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:

        * Nutzer ist als Dozent angemeldet
        * `request` ist ein Ajax Request
        * `request`-Methode ist `GET`
        * s-Nummer wird als GET Parameter mit folgendem Aufbau
          gesendet `s_num=s12345`
          
          Bsp.:
          https://yourdomain.com/verwaltung/fragebogen/details?s_num=s12345

    :return:

        .. code-block::

            {
                "name": string,  # Name des Studenten
                "poll_projects":
                {
                    "<project1>": int, # Score für Projekt 1
                    "<project2>": int  # Score für Projekt 2
                    ...
                },
                "poll_roles":
                {
                    "<role1>": int, # Score für Rolle 1
                    "<role2>": int  # Score für Rolle 2
                    ...
                },
                "poll_skills":
                {
                    "<skill1>": int, # Score für Skill 1
                    "<skill2>": int  # Score für Skill 2
                    ...
                }
            }

     Beispiel:

        .. code-block::
            
            {
                "name": "Peter Lustig"
                "poll_projects":
                {
                    "I7_Teamverwaltung": 5,
                    "E1_Ressourcenverwaltung": 1,
                    "E3_FutureCityProjects": 4
                },
                "poll_roles":
                {
                    "Teamleiter":1
                    "Analyse":2
                    "Entwurf":2
                    "Implementierung":5
                    "Test":4
                },
                "poll_skills":
                {
                    "Softwareentwicklung in Projektarbeit": 1,
                    "Softwareentwicklung in Einzelarbeit": 1,
                    "Versionsverwaltung mit Git": 1,
                }
            }

    :rtype: JsonResponse"""

    if request.method == "GET" and is_ajax(request):
        if not isUserDozent(request.user):
            return

        snum = request.GET.get("s_num")
        stud = Student.objects.get(s_num=snum)
        p = Poll.objects.get(student=stud)

        pa = ProjectAnswer.objects.all().filter(poll=p)
        ra = RoleAnswer.objects.all().filter(poll=p)
        sa = SkillAnswer.objects.all().filter(poll=p)

        poll_projects = {}
        poll_roles = {}
        poll_skills = {}

        for panswer in pa:
            poll_projects[panswer.project.name] = panswer.score

        for ranswer in ra:
            poll_roles[ranswer.role.role] = ranswer.score

        for sanswer in sa:
            poll_skills[sanswer.skill.skill] = sanswer.score

        name = stud.first_name + " " + stud.last_name

    return JsonResponse(
        {
            "name": name,
            "poll_projects": json.dumps(poll_projects),
            "poll_roles": json.dumps(poll_roles),
            "poll_skills": json.dumps(poll_skills)
        },
        status=200)


def VerwaltungTeams(request):
    """Implementiert den Reiter Teams im Dozentenbereich zum Anzeigen
    der vom Algorithmus erzeugten Teams.
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :return: gerendertes HTML Template verwaltung/teams.html
    :rtype: django.http.HttpResponse"""

    if isUserDozent(request.user):
        assignments = Assignment.objects.all().prefetch_related(
            "project", "student").order_by("project_id")
        return render(request, "teamverwaltung_main/verwaltung/teams.html", {"assignments": list(assignments)})


def VerwaltungTeamerstellung(request):
    """Ermöglicht das Erstellen oder Löschen von Teams unter
    dem Reiter Teams des Dozentenbereiches.

    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:
        * Nutzer ist als Dozent angemeldet
        * `request`-Methode ist `POST`
        
    Wenn ``"run_algo"`` im `request` enthalten ist, dann wird
    der Zuordnungsalgorithmus gestartet. Dabei werden alle
    bisherigen Zuordnungen überschrieben. Es werden nur
    Projekte in die Lösungsmenge aufgenommen, wenn alle Studenten
    zu diesem Projekt eine Bewertung in ihrem Fragebogen dazu
    abgegeben haben.

    Wenn ``"delete_assignments"`` im `request` enthalten ist,
    werden alle bisherigen `models.Assignment` Objekte aus der
    Datenbank gelöscht.

    :return: gerendertes HTML Template verwaltung/teams.html
    :rtype: django.http.HtppResponse
    """

    if isUserDozent(request.user):
        if request.method == "POST" and "run_algo" in request.POST:
            polls = list(Poll.objects.values_list("pk", "is_wing"))
            projects = list(Project.objects.values_list("pk"))
            project_answers = list(ProjectAnswer.objects.order_by(
                "poll").values_list("poll", "project", "score"))
            role_answers = list(RoleAnswer.objects.order_by(
                "poll").values_list("poll", "role", "score"))
            data = queryset2algo(
                polls, projects, project_answers, role_answers)

            algo = AssignmentAlgo(
                data.get("project_answers"),
                data.get("role_answers"),
                data.get("wing")
            )
            algo.run()
            result = algo.get_result()
            # result = solve_assignments(data.get("project_answers"), data.get(
            #     "role_answers"), data.get("wing"))
            Assignment.objects.all().delete()
            save_result(result)
        elif request.method == "POST" and "delete_assignments" in request.POST:
            Assignment.objects.all().delete()

        assignments = Assignment.objects.all().prefetch_related(
            "project", "student").order_by("project_id")
        return render(request, "teamverwaltung_main/verwaltung/teams.html", {"assignments": list(assignments)})


def VerwaltungTeamerstellung_Changes(request):
    if not isUserDozent(request.user):
        return
    if request.method == "POST" and is_ajax(request):
        changes_str = request.POST.get("changes")
        changes = json.loads(changes_str)
        for student in changes:
            student_assign = Assignment.objects.get(pk=student)
            new_project = Project.objects.get(pk=changes[student])
            student_assign.project = new_project
            student_assign.save()

        return JsonResponse({"success": 1}, status=200)


def VerwaltungStudent(request):
    """Ermöglicht den Upload von neuen Studenten mittels
    CSV Datei. Der Nutzer wählt in einem HTML Form
    zwischen dem Modus `append` und `overwrite`. Im
    `append` Modus werden die neuen Studenten aus der CSV Datei
    dem bestehenden Datensatz angehangen. Im `overwrite`
    Modus werden alle bestehenden Daten mithilfe der
    `deleteAllStudentData()` Funktion gelöscht und anschließend
    die neuen Studenten aus der CSV Datei hochgeladen.
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:
        * Nutzer ist als Dozent angemeldet
        * für CSV Upload:
            * `request`-Methode ist `POST`
            * CSV Datei mit Namen ``"students"`` in `POST` Request entahlten
            * Schlüssel ``"csv_insert_mode"`` in `POST` Request enthalten
        
    :return: gerendertes HTML Template `verwaltung/student.html`
    :rtype: django.http.HttpResponse 
    """

    if isUserDozent(request.user):
        if request.method == "POST":
            if "students" in request.FILES.keys() and "csv_insert_mode" in request.POST:
                file = request.FILES["students"]
                insert_mode = request.POST["csv_insert_mode"]
                save_csv(file)  # save file to /tmp/students.csv
                parser = CSVStudentParser("/tmp/students.csv")
                parser.parse()
                students = parser.get_students()
                if insert_mode == "append":
                    Student.objects.bulk_create(students)
                elif insert_mode == "overwrite":
                    deleteAllStudentData()
                    Student.objects.bulk_create(students)
                else:
                    # TODO: show error message
                    pass

        return render(
            request,
            "teamverwaltung_main/verwaltung/student.html",
            {"section_name": "Studenten"}
        )


def FragebogenSend(request):
    """Ermöglicht das Speichern von Fragebogen Daten, die vom
    Nutzer mittels `POST` Request gesendet werden.
    
    :Vorbedingungen:
        * Nutzer ist als Student angemeldet
        * `request`-Methode ist `POST`
        * `request` ist Ajax Request
    
    :return:
        * wenn gesendete Fragebogen Daten erfolgreich gespeichert
          wurden:
          
          .. code-block::

            {"success": 1}

        * wenn gesendete Fragebogen nicht erfolgreich gespeichert
          werden konnten:

          .. code-block::

            {"success": 0}
    :rtype: JsonResponse
    """

    if not request.user.is_authenticated:
        return
    if request.method == "POST" and is_ajax(request):
        topicRating = json.loads(request.POST.get("ratingTopics"))
        roleRating = json.loads(request.POST.get("ratingRoles"))
        skillRating = json.loads(request.POST.get("ratingSkills"))
        if(hasUserQuestionnaire(request.user)):
            stud = Student.objects.get(s_num=request.user.username)
            p = Poll.objects.get(student=stud)

            for _project in Project.objects.all().iterator():
                project_answer = ProjectAnswer.objects.get(
                    poll=p, project=_project)
                if project_answer.score != int(topicRating[str(_project.pk)]):
                    project_answer.score = int(topicRating[str(_project.pk)])
                    project_answer.save()

            for _role in Role.objects.all():
                role_answer = RoleAnswer.objects.get(poll=p, role=_role)
                if role_answer.score != int(roleRating[_role.role]):
                    role_answer.score = int(roleRating[_role.role])
                    role_answer.save()

            for _skill in Skill.objects.all():
                try:
                    print(SkillAnswer.objects.filter(poll=p, skill=_skill).exists())
                    if not SkillAnswer.objects.filter(poll=p, skill=_skill).exists():
                        skill_answer = SkillAnswer(poll=p, skill=_skill, 
                                                    score=int(skillRating[_skill.abbreviation]))
                        skill_answer.save()
                    elif skill_answer.score != int(skillRating[_skill.abbreviation]):
                        skill_answer = SkillAnswer.objects.get(poll=p, skill=_skill)
                        skill_answer.score = int(skillRating[_skill.abbreviation])
                        skill_answer.save()
                except:
                    pass

            return JsonResponse({"success": 1}, status=200)
        else:
            try:
                stud = Student.objects.get(s_num=request.user.username)
                # create poll
                stud_is_wing = False
                if stud.faculty == "wi":
                    stud_is_wing = True
                
                p = Poll(student=stud, is_wing=stud_is_wing)
                p.save()

                # create project answers
                projects = Project.objects.all()
                for _project in projects.iterator():
                    pa = ProjectAnswer(poll=p, project=_project,
                                    score=int(topicRating[str(_project.pk)]))
                    pa.save()

                # create role answers
                roles = Role.objects.all()
                for _role in roles.iterator():
                    ra = RoleAnswer(poll=p, role=_role,
                                    score=roleRating[_role.role])
                    ra.save()

                if len(skillRating) > 0:
                    skills = Skill.objects.all()
                    for _skill in skills.iterator():
                        try:
                            sa = SkillAnswer(poll=p, skill=_skill,
                                            score=skillRating[_skill.abbreviation])
                            sa.save()
                        except:
                            pass

                print("kein fragebogen vorhanden")
                return JsonResponse({"success": 1}, status=200)
            except:
                return JsonResponse({"success": 0}, status=200)
        return


def PollProgress(request):
    """Erlaubt das Abfragen wie viele Studenten bereits den Fragebogen
    ausgefüllt haben. Diese Funktion wird für die Progress Bar im
    Dozentenbereich benötigt.
    
    :param request: Web Request
    :type request: django.http.HttpRequest
    :Vorbedingungen:
        * Nutzer ist als Dozent angemeldet
        * `request` ist ein Ajax Request
        * `request`-Methode ist `GET`
    :return:
        .. code-block::

            {
                "share": int,         # Anteil beantwortet
                "pollTotal": int,     # Anzahl Studenten
                "pollsCurrent": int   # Anzahl beantwortet
            }

     Beispiel:
        .. code-block::

            {
                "share": 75,
                "pollTotal": 200,
                "pollsCurrent": 150
            }


    :rtype: JsonResponse
    """

    if request.method == "GET" and is_ajax(request):
        if not isUserDozent(request.user):
            return

        polls_total = Student.objects.count()
        polls_current = Student.objects.filter(poll__isnull=False).count()
        poll_share = (polls_current / polls_total) * 100

        return JsonResponse({"share": poll_share, "pollsTotal": polls_total, "pollsCurrent": polls_current}, status=200)

