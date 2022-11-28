"""Im Modul models sind alle Datenmodelle definiert.
"Ein Modell ist die einzige, definitive Informationsquelle zu Ihren Daten.
Es enthält alle wesentlichen Felder und Verhaltensweisen der Daten, die gespeichert werden.
Im Allgemeinen ist jedes Model einer einzelnen Datenbanktabelle zugeordnet." (vgl. Django Docs)

Mehr zur allgemeinen Implementierung von Django-Models ist unter diesem Link zu finden:
https://docs.djangoproject.com/en/4.0/topics/db/models/
"""
from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator, RegexValidator
from django_auth_ldap.backend import LDAPBackend
from django.core.exceptions import PermissionDenied


class Project(models.Model):
    """Hält die Menge aller Projekte, die zur Auswahl stehen."""

    name = models.CharField(max_length=255)  # Projektname
    # Knappe Projektbeschreibung
    description = models.CharField(max_length=1023)
    # Zuständiger / Ansprechpartner
    responsible = models.CharField(max_length=255)
    documentfile_url = models.CharField(max_length=255)  # Link
    isActive = models.BooleanField(default=True)

    def __str__(self):
        return self.name + ": " + self.description + ". - " + self.responsible

    # def get_absolute_url(self):
    #    return reverse('project_detail', args=[str(self.id)])


class Role(models.Model):
    """Hält die Menge aller möglichen Rollen/ Tätigkeiten, die ein
    Student in einem Projekt ausüben kann."""

    role = models.CharField(max_length=255)

    def __str__(self) -> str:
        return self.role


class Skill(models.Model):
    """Hält die Menge aller möglichen Fähigkeiten, die ein Student im
    Fragebogen angeben kann."""

    skill = models.CharField(max_length=255)
    abbreviation = models.CharField(max_length=30, default=None)

    def __str__(self) -> str:
        return self.skill


class Student(models.Model):
    """Hält die Menge aller Studenten, die im SE-Beleg eingeschrieben
    sind."""

    FACULTY_CHOICES = [("ia", "Informatik"), ("iw", "Wirtschaftsinformatik"),
                       ("iv", "Verwaltungsinformatik"), ("wi", "Wirtschaftsingenieurswesen")]

    title = models.CharField(max_length=1, choices=[
                             ("h", "Herr"), ("f", "Frau")])
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    s_num = models.CharField(max_length=6, unique=True, validators=[RegexValidator(
        regex="^s[0-9]{5}$",
        message="s-nummer nach folgendem Schema angeben: s12345",
        code="invalid s_num"
    )])
    faculty = models.CharField(
        max_length=2,
        choices=FACULTY_CHOICES,
        default=None
    )

    # def save(self, *args, **kwargs):
    #    self.name = str(self.first_name) + str(self.last_name)
    #    super().save(*args, **kwargs)

    @property
    def name(self):
        return f'{self.first_name} {self.last_name}'

    def __str__(self) -> str:
        return f"{self.name} - {self.s_num}"


class Poll(models.Model):
    """Hält die Menge aller Fragebogen-Objekte. Diese
    dienen als Parent Objekt auf das ProjectAnswer, RoleAnswer
    und SkillAnswer verweisen. Ein Poll Objekt verweist auf
    seinen zugehörigen Studenten und wird beim erstmaligen
    Beantworten des Fragebogens erstellt."""

    student = models.OneToOneField(
        Student, on_delete=models.CASCADE, primary_key=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    is_wing = models.BooleanField()

    def __str__(self) -> str:
        return f"poll {self.student.name} - {self.student.s_num}"


class ProjectAnswer(models.Model):
    """Hält die Menge aller abgegebenen Antworten aus den Fragebögen
    zu einem bestimmten Projekt."""

    poll = models.ForeignKey(Poll, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.PROTECT)
    # score from 1(very bad) to 5(very good)
    score = models.PositiveBigIntegerField(
        default=3,
        validators=[MinValueValidator(1), MaxValueValidator(5)])

    def __str__(self) -> str:
        return f"{self.poll.student.name} ({self.poll.student.s_num}) - {self.project.name}"


class RoleAnswer(models.Model):
    """Hält die Menge aller abgegebenen Antworten aus den Fragebögen
    zu einer bestimmten Rolle."""

    poll = models.ForeignKey(Poll, on_delete=models.CASCADE)
    role = models.ForeignKey(Role, on_delete=models.PROTECT)
    # score from 1(very bad) to 5(very good)
    score = models.PositiveBigIntegerField(
        default=3,
        validators=[MinValueValidator(1), MaxValueValidator(5)])

    def __str__(self) -> str:
        return f"{self.poll.student.name} ({self.poll.student.s_num}) - {self.role.role}"


class SkillAnswer(models.Model):
    """Hält die Menge aller abgegebenen Antworten aus den Fragebögen
    zu einem bestimmten Skill/ einer bestimmten Fähigkeit."""

    poll = models.ForeignKey(Poll, on_delete=models.CASCADE)
    skill = models.ForeignKey(Skill, on_delete=models.PROTECT)
    # score from 1(bad) to 3(good)
    score = models.PositiveIntegerField(
        default=2,
        validators=[MinValueValidator(1), MaxValueValidator(3)]
    )

    def __str__(self) -> str:
        return f"{self.poll.student.name} ({self.poll.student.s_num}) - {self.skill.skill}"


class Assignment(models.Model):
    """Hält die Menge aller endgültigen Zuordnungen. Eine Zuordnung
    besteht aus einem Studenten, einer zugewiesenen Rolle und einem
    zugewiesenen Projekt."""

    student = models.OneToOneField(
        Student, on_delete=models.CASCADE, primary_key=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    role = models.ForeignKey(Role, on_delete=models.PROTECT)

    def __str__(self) -> str:
        return f"{self.student.name} ({self.student.s_num}) - {self.project.name}, {self.role.role}"


class SectionControl(models.Model):
    """Hält die Menge der Freigabe-Status bspw. zum Ein- und
    Ausblenden des Fragebogens oder der Teameinsicht auf der
    Homepage."""

    section = models.CharField(max_length=100)
    activated = models.BooleanField()


class CustomLDAPBackend(LDAPBackend):
    """Dient zur Authentifizierung der Studenten mit ihrem HTW Login
    mittels LDAP. Diese Klasse wird im settings.py Modul als
    Authentication Backend registriert."""

    default_settings = {
        "LOGIN_COUNTER_KEY": "CUSTOM_LDAP_LOGIN_ATTEMPT_COUNT",
        "LOGIN_ATTEMPT_LIMIT": 20,
        "RESET_TIME": 30 * 60,
    }

    def authenticate_ldap_user(self, user, password):
        """Prüft, ob der Nutzername (s-Nummer) eines versuchten LDAP
        Logins in der Datenbasis "Students" enthalten ist. Somit wird
        ausgeschlossen, dass sich jeder Nutzer an der HTW mit einem
        gültigen HTW-Login auf der Website anmelden kann. Nur Studenten,
        welche in der Students Tabelle enthalten sind, können sich
        erfolgreich anmelden."""

        ldap_user = user.authenticate(password)

        # if user is not ldap user or not in student table
        if ldap_user == None or not Student.objects.filter(s_num=ldap_user.username).exists():
            return None

        print("LDAP user authenticated: " + ldap_user.username)
        return ldap_user
