"""Im Admin Modul können die List Views auf der Django-Admin
Seite konfiguriert. Es kann bspw. eingestellt werden welche
Datenfelder eines Models angezeigt werden sollen, es kann die
Suchfunktion oder bestimmte Filter eingestellt werden uvm.

Die Adminseite kann unter
https://yourproject.com/admin aufgerufen werden.

Weitere Informationen zur Konfiguration der Admin Seite sind
unter https://docs.djangoproject.com/en/4.0/ref/contrib/admin/
zu finden.
"""

from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from django.contrib import messages
from . import models


####### CUSTOM FILTERS #######

# filter students by <poll is answered> or <poll is not answered>
class PollAnsweredFilter(admin.SimpleListFilter):
    """Ermöglicht das Filtern von Studenten, welche ihren
    Fragebogen
    
    1. beantwortet haben (Answered)
    2. nicht beantwortet haben (Not answered)
    """
    title = _("Poll status")
    parameter_name = "poll_answered"

    def lookups(self, request, model_admin):
        return(
            ("True", _("Answered")),
            ("False", _("Not answered"))
        )

    def queryset(self, request, queryset):
        polls = models.Poll.objects.all()
        if self.value() == "True":
            return queryset.filter(poll__in=polls)

        if self.value() == "False":
            return queryset.exclude(poll__in=polls)


####### CUSTOM ACTIONS #######

# create a poll with maximum score for all answers
def create_max_poll(modeladmin, request, queryset):
    """Implementiert die custom action zum automatischen
    generieren von Fragebögen, welche alle Projekte und
    Rollen mit dem maximalen Score bewertet haben.
    Dies ist insbesondere sinnvoll, wenn es Studenten
    gibt, welche den Fragebogen nicht bis zum
    vorgegebenen Termin ausgefüll haben. Diese kann der
    Dozent dann im Admin Bereich auswählen und diese Action
    auf sie anwenden. Dadurch, dass die den automatisch
    generierten Fragebogen mit maximalen Scores erhalten,
    sind sie für den Algorithmus mit jeder Rolle und jedem
    Projekt zufrieden und können somit flexibel zugeteilt
    werden.

    Die automatische Generierung ist nur für Studenten
    möglich, welche den Fragebogen noch nicht ausgefüllt
    haben.
    
    :return: Zeigt bei erfolgreicher Ausführung eine
     Erfolgsmeldung und beim Fehlschlagen ein entsprechende
     Meldeung auf der Djano Admin Seite an.
    :rtype: None
    """

    selected = queryset.values_list("pk")
    # selected students which already have answered the poll
    selected_with_poll = models.Poll.objects.filter(pk__in=selected)

    # if all selected students have not answered poll yet
    if not selected_with_poll:
        polls = []
        project_answers = []
        role_answers = []
        selected = list(selected)
        projects = list(models.Project.objects.filter(
            isActive=True).values_list("pk"))
        roles = list(models.Role.objects.values_list("pk"))

        # create new poll for each selected student
        for i, student in enumerate(selected):
            is_wing = False
            faculty = models.Student.objects.filter(id=student[0]).values_list("faculty")[0][0]
            if faculty == "wi":
                is_wing = True
            polls.append(models.Poll(student_id=student[0], is_wing=is_wing))

            for project in projects:
                # student_id == poll_id (because of one-to-one relationship)
                project_answers.append(models.ProjectAnswer(
                    poll=polls[i], project_id=project[0], score=5))

            for role in roles:
                role_answers.append(models.RoleAnswer(
                    poll=polls[i], role_id=role[0], score=5))

        # push new generated objects to database
        models.Poll.objects.bulk_create(polls)
        models.ProjectAnswer.objects.bulk_create(project_answers)
        models.RoleAnswer.objects.bulk_create(role_answers)
        # show success message
        modeladmin.message_user(
            request, f"Erfolgreich {len(polls)} Fragebögen erstellt", level=messages.SUCCESS, fail_silently=False)
    else:
        # raise error if user is trying to auto create a poll for a student which already has answered the poll
        modeladmin.message_user(
            request, "Ausgewählte(r) Student(en) hat bereits einen Fragebogen ausgefüllt", level=messages.ERROR, fail_silently=False)


@admin.action(description="Erstelle Fragebogen mit maximalen Score")
def max_poll(modeladmin, request, queryset):
    create_max_poll(modeladmin, request, queryset)



####### LIST VIEWS #######

admin.site.register(models.Role)
admin.site.register(models.Skill)
admin.site.register(models.SectionControl)


@admin.register(models.Project)
class ProjectAdmin(admin.ModelAdmin):
    """Registriert und Konfiguriert den List View der Klasse
    `models.Project` in Django Admin."""

    list_display = ["name", "responsible", "isActive", "pk"]
    list_filter = ["isActive"]
    search_fields = ["name"]
    ordering = ["name"]


@admin.register(models.Poll)
class PollAdmin(admin.ModelAdmin):
    """Registriert und Konfiguriert den List View der Klasse
    `models.Poll` in Django Admin."""

    list_display = ["student_last_name", "student_first_name", "student_snum",
                    "is_wing", "timestamp", "pk"]
    list_select_related = ["student"]
    list_filter = ["is_wing"]
    search_fields = ["student__last_name","student__first_name" , "student__s_num"]
    ordering = ["student__last_name"]

    def student_first_name(self, poll):
        """Gibt den Vornamen des mit dem Fragebogen verknüpften Studenten zurück

        :param poll: Fragebogen Objekt
        :type poll: models.Poll 
        :return: ``poll.student.first_name``
        :rtype: str"""
        return poll.student.first_name
    # make foreign key student first_name sortable
    student_first_name.admin_order_field = "student__first_name"

    def student_last_name(self, poll):
        """Gibt den Nachnamen des mit dem Fragebogen verknüpften Studenten zurück
        
        :param poll: Fragebogen Objekt
        :type poll: models.Poll 
        :return: ``poll.student.last_name``
        :rtype: str"""
        return poll.student.last_name
    # make foreign key student last_name sortable
    student_last_name.admin_order_field = "student__last_name"

    def student_snum(self, poll):
        """Gibt die s-Nummer des mit dem Fragebogen verknüpften Studenten zurück
        
        :param poll: Fragebogen Objekt
        :type poll: models.Poll 
        :return: ``poll.student.s_num``
        :rtype: str"""
        return poll.student.s_num
    student_snum.admin_order_field = "student__s_num"


@admin.register(models.Student)
class StudentAdmin(admin.ModelAdmin):
    """Registriert und konfiguriert den List View der Klasse
    `models.Student` in Django Admin."""

    list_display = ["last_name", "first_name", "s_num", "pk"]
    search_fields = ["last_name", "first_name", "s_num"]
    ordering = ["last_name"]
    list_filter = [PollAnsweredFilter]
    actions = [max_poll,]


@admin.register(models.RoleAnswer)
class RoleAnswerAdmin(admin.ModelAdmin):
    """Registriert und konfiguriert den List View der Klasse
    `models.RoleAnswer` in Django Admin."""

    list_display = ["student_last_name", "student_first_name", "student_snum", "role", "score", "pk"]
    list_select_related = ["role", "poll", "poll__student"]
    list_filter = ["score", "role__role"]
    search_fields = ["poll__student__last_name","poll__student__first_name", "poll__student__s_num"]
    ordering = ["poll__student__last_name", "role__role"]

    def role(self, roleanswer):
        """Gibt den Titel des mit dem `models.RoleAnswer` verknüpften
        `models.Role` Objektes zurück.
        
        :param roleanswer: Rollenbewertung aus dem Fragebogen
        :type roleanswer: models.RoleAnswer
        :return: ``roleanswer.role.role``
        :rtype: str"""
        return roleanswer.role.role
    role.admin_order_field = "role__role"

    def student_first_name(self, roleanswer):
        """Gibt den Vornamen des mit dem `models.RoleAnswer` verknüpften
        Studenten zurück.
        
        :param roleanswer: Rollenbewertung aus dem Fragebogen
        :type roleanswer: models.RoleAnswer
        :return: ``roleanswer.poll.student.first_name``
        :rtype: str"""
        return roleanswer.poll.student.first_name
    student_first_name.admin_order_field = "poll__student__first_name"

    def student_last_name(self, roleanswer):
        """Gibt den Nachnamen des mit dem `models.RoleAnswer` verknüpften
        Studenten zurück.
        
        :param roleanswer: Rollenbewertung aus dem Fragebogen
        :type roleanswer: models.RoleAnswer
        :return: ``roleanswer.poll.student.last_name``
        :rtype: str"""
        return roleanswer.poll.student.last_name
    student_last_name.admin_order_field = "poll__student__last_name"

    def student_snum(self, roleanswer):
        """Gibt die s-Nummer des mit dem `models.RoleAnswer` verknüpften
        Studenten zurück.
        
        :param roleanswer: Rollenbewertung aus dem Fragebogen
        :type roleanswer: models.RoleAnswer
        :return: ``roleanswer.poll.student.s_num``
        :rtype: str"""
        return roleanswer.poll.student.s_num
    student_snum.admin_order_field = "poll__student__s_num"


@admin.register(models.ProjectAnswer)
class ProjectAnswerAdmin(admin.ModelAdmin):
    """Registriert und konfiguriert den List View der Klasse
    `models.ProjectAnswer` in Django Admin."""

    list_display = ["student_last_name", "student_first_name", "student_snum",
                    "project_name", "score", "pk"]
    list_select_related = ["poll", "project", "poll__student"]
    list_filter = ["score", "project__name"]
    search_fields = ["poll__student__last_name","poll__student__first_name", "poll__student__s_num"]
    ordering = ["poll__student__last_name", "project__name"]

    def student_first_name(self, projectanswer):
        """Gibt den Vornamen des mit dem `models.ProjectAnswer` verknüpften
        Studenten zurück.
        
        :param projectanswer: Projektbewertung aus dem Fragebogen
        :type projectanswer: models.ProjectAnswer
        :return: ``projectanswer.poll.student.first_name``
        :rtype: str"""
        return projectanswer.poll.student.first_name
    student_first_name.admin_order_field = "poll__student__first_name"

    def student_last_name(self, projectanswer):
        """Gibt den Nachnamen des mit dem `models.ProjectAnswer` verknüpften
        Studenten zurück.
        
        :param projectanswer: Projektbewertung aus dem Fragebogen
        :type projectanswer: models.ProjectAnswer
        :return: ``projectanswer.poll.student.last_name``
        :rtype: str"""
        return projectanswer.poll.student.last_name
    student_last_name.admin_order_field = "poll__student__last_name"

    def student_snum(self, projectanswer):
        """Gibt die s-Nummer des mit dem `models.ProjectAnswer` verknüpften
        Studenten zurück.
        
        :param projectanswer: Projektbewertung aus dem Fragebogen
        :type projectanswer: models.ProjectAnswer
        :return: ``projectanswer.poll.student.s_num``
        :rtype: str"""
        return projectanswer.poll.student.s_num
    student_snum.admin_order_field = "poll__student__s_num"

    def project_name(self, projectanswer):
        """Gibt den Namen des mit dem `models.ProjectAnswer` verknüpften
        Projektes zurück.
        
        :param projectanswer: Projektbewertung aus dem Fragebogen
        :type projectanswer: models.ProjectAnswer
        :return: ``projectanswer.project.name``
        :rtype: str"""
        return projectanswer.project.name
    project_name.admin_order_field = "project__name"


@admin.register(models.SkillAnswer)
class SkillAnswerAdmin(admin.ModelAdmin):
    """Registriert und konfiguriert den List View der Klasse
    `models.SkillAnswer` in Django Admin."""

    list_display = ["student_last_name", "student_first_name", "student_snum", "skill", "score", "pk"]
    list_select_related = ["poll", "skill", "poll__student"]
    list_filter = ["score", "skill__skill"]
    search_fiels = ["poll__student__last_name","poll__student__first_name", "poll__student__s_num"]
    odering = ["poll__student__last_name", "skill__skill"]

    def student_first_name(self, skillanswer):
        """Gibt den Vornamen des mit dem `models.SkillAnswer` verknüpften
        Studenten zurück.
        
        :param skillanswer: Fähigkeitsbewertung aus dem Fragebogen
        :type skillanswer: models.SkillAnswer
        :return: ``skillanswer.poll.student.first_name``
        :rtype: str"""
        return skillanswer.poll.student.first_name
    student_first_name.admin_order_field = "poll__student__first_name"

    def student_last_name(self, skillanswer):
        """Gibt den Nachnamen des mit dem `models.SkillAnswer` verknüpften
        Studenten zurück.
        
        :param skillanswer: Fähigkeitsbewertung aus dem Fragebogen
        :type skillanswer: models.SkillAnswer
        :return: ``skillanswer.poll.student.last_name``
        :rtype: str"""
        return skillanswer.poll.student.last_name
    student_last_name.admin_order_field = "poll__student__last_name"

    def student_snum(self, skillanswer):
        """Gibt die s-Nummer des mit dem `models.SkillAnswer` verknüpften
        Studenten zurück.
        
        :param skillanswer: Fähigkeitsbewertung aus dem Fragebogen
        :type skillanswer: models.SkillAnswer
        :return: ``skillanswer.poll.student.s_num``
        :rtype: str"""
        return skillanswer.poll.student.s_num
    student_snum.admin_order_field = "poll__student__s_num"

    def skill(self, skillanswer):
        """Gibt die Beschreibung des mit dem `models.SkillAnswer` verknüpften
        Skills/ Fähigkeit zurück.
        
        :param skillanswer: Fähigkeitsbewertung aus dem Fragebogen
        :type skillanswer: models.SkillAnswer
        :return: ``skillanswer.skill.skill``
        :rtype: str"""
        return skillanswer.skill.skill
    skill.admin_order_field = "skill__skill"


@admin.register(models.Assignment)
class AssignmentAdmin(admin.ModelAdmin):
    """Registriert und konfiguriert den List View der Klasse
    `models.Assignment` in Django Admin."""
    
    list_display = ["student_last_name", "student_first_name", "student_snum",
                    "project_name", "role", "is_wing", "pk"]
    list_select_related = ["student", "student__poll", "project", "role"]
    list_filter = ["project__name", "role__role", "student__poll__is_wing"]
    search_fields = ["student_last_name", "student_first_name", "student__s_num"]
    ordering = ["student__first_name", "role__role"]

    def student_first_name(self, assignment):
        """Gibt den Vornamen des mit der Zuordnung verknüpften
        Studenten zurück.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.student.poll.student.first_name``
        :rtype: str"""
        return assignment.student.poll.student.first_name
    student_first_name.admin_order_field = "student__first_name"

    def student_last_name(self, assignment):
        """Gibt den Nachnamen des mit der Zuordnung verknüpften
        Studenten zurück.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.student.poll.student.last_name``
        :rtype: str"""
        return assignment.student.poll.student.last_name
    student_last_name.admin_order_field = "student__last_name"

    def student_snum(self, assignment):
        """Gibt die s-Nummer des mit der Zuordnung verknüpften
        Studenten zurück.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.student.poll.student.s_num``
        :rtype: str"""
        return assignment.student.poll.student.s_num
    student_snum.admin_order_field = "student__s_num"

    def project_name(self, assignment):
        """Gibt den Namen des mit der Zuordnung verknüpften
        Projektes zurück.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.project.name``
        :rtype: str"""
        return assignment.project.name
    project_name.admin_order_field = "project__name"

    def is_wing(self, assignment):
        """Gibt zurück, ob der mit der Zuordnung verknüpfte Student der Fakultät
        Wirtschaftsingenieurwesen angehört oder nicht.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.student.poll.is_wing``
        :rtype: bool"""
        return assignment.student.poll.is_wing
    is_wing.admin_order_field = "student__poll__is_wing"
    is_wing.boolean = True

    def role(self, assignment):
        """Gibt den Titel der mit der Zuordnung verknüpften
        Rolle zurück.
        
        :param assignment: Zuordnung eines Studenten in Projekt und Rolle
        :type assignmnet: models.Assignment
        :return: ``assignment.role.role``
        :rtype: str"""
        return assignment.role.role
    role.admin_order_field = "role__role"
