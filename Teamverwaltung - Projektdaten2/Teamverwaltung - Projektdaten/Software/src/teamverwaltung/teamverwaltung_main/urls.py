from django.urls import path
from . import views
from .views import VerwaltungThemenOverview, VerwaltungFragebogen

#from .views import ProjectOverview, ProjectDetail, ProjectCreate, ProjectUpdate, ProjectDelete, ProjectStudentOverview


urlpatterns = [
    path('', views.AppHome, name="app_home"),
    path('verwaltung/themen', VerwaltungThemenOverview.as_view(),
         name='themen_overview'),
    path('verwaltung/fragebogen', views.VerwaltungFragebogen, name='fragebogen'),
    path('verwaltung/fragebogen/details', views.VerwaltungFragebogenDetails, name="fragebogendetails"),
    path('verwaltung/teams', views.VerwaltungTeamerstellung, name='teams'),
    path('verwaltung/teamerstellung', views.VerwaltungTeamerstellung, name='teamerstellung'),
    path('verwaltung/teamerstellung_changes', views.VerwaltungTeamerstellung_Changes, name='teamerstellung_changes'),
    path('verwaltung/sectioncontrol', views.VerwaltungSectionControl, name='sectioncontrol'),
    path('verwaltung/pollprogress', views.PollProgress, name="pollprogress"),
    path('verwaltung/student', views.VerwaltungStudent, name="student"),
    path('fragebogen/send', views.FragebogenSend, name="fragebogensend"),
]
