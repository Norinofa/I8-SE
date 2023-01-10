from django.test import TestCase
from ..models import ProjectAnswer
from ..models import Poll
from ..models import Student
from ..models import Project
from ..models import Role
from ..models import Assignment
from ..models import Skill
from ..models import SkillAnswer
from ..models import RoleAnswer

class ProjectAnswerTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.project = Project.objects.create(
            name="Test 1",
            description="desc 1",
            responsible="resp 1",
            documentfile_url="foo.foo.de",
        )
        cls.st = Student.objects.create(
            title="h",
            first_name="Max",
            last_name="Mustermann",
            s_num="s12345",
            faculty="ia"
        )
        cls.role = Role.objects.create(
            role="Meister"
        )
        cls.skill = Skill.objects.create(
            skill="schlafen",
            abbreviation="slp"
        )
        cls.stpoll = Poll.objects.create(student=cls.st, is_wing=False)
        cls.stpa = ProjectAnswer.objects.create(poll=cls.stpoll,project=cls.project)
        cls.stassignment = Assignment.objects.create(
            student=cls.st,
            project=cls.project,
            role=cls.role)
        cls.stsa = SkillAnswer.objects.create(
            poll=cls.stpoll,
            skill=cls.skill
        )
        cls.stra = RoleAnswer.objects.create(
            poll=cls.stpoll,
            role=cls.role
        )

    def test_st(self):
        self.assertEqual(self.st.title,"h")
        self.assertEqual(self.st.first_name,"Max")
        self.assertEqual(self.st.last_name,"Mustermann")
        self.assertEqual(self.st.s_num,"s12345")
        self.assertEqual(self.st.faculty,"ia")
        self.assertEqual(self.st.__str__(),"Max Mustermann - s12345")

    def test_project(self):
        self.assertEqual(self.project.name,"Test 1")
        self.assertEqual(self.project.description,"desc 1")
        self.assertEqual(self.project.responsible,"resp 1")
        self.assertEqual(self.project.documentfile_url,"foo.foo.de")
        self.assertEqual(self.project.__str__(),"Test 1: desc 1. - resp 1")
    
    def test_poll(self):
        full_name = f"{self.stpoll.student.first_name} {self.stpoll.student.last_name}"
        self.assertEqual(full_name, 'Max Mustermann')
        self.assertEqual(self.stpoll.student, self.st)
        self.assertFalse(self.stpoll.is_wing)
        self.assertEqual(self.stpoll.__str__(),"poll Max Mustermann - s12345")

    def test_projectanswer(self):
        self.assertEqual(self.stpa.poll, self.stpoll)
        self.assertEqual(self.stpa.project, self.project)
        self.assertEqual(self.stpa.score, 3)
        self.assertRaises(Exception, self.stpa.full_clean())
        self.assertEqual(self.stpa.__str__(),"Max Mustermann (s12345) - Test 1")

    def test_role(self):
        self.assertEqual(self.role.role, "Meister")
        self.assertEqual(self.role.__str__(),"Meister")

    def test_assignment(self):
        self.assertEqual(self.stassignment.student, self.st)
        self.assertEqual(self.stassignment.project, self.project)
        self.assertEqual(self.stassignment.role, self.role)
        self.assertEqual(self.stassignment.__str__(),"Max Mustermann (s12345) - Test 1, Meister")
    
    def test_skill(self):
        self.assertEqual(self.skill.skill, "schlafen")
        self.assertEqual(self.skill.abbreviation, "slp")
        #student_skill = Skill.objects.filter(pk__in=SkillAnswer.objects.filter(id=1).values_list('skill'))
        #print(student_skill)
        self.assertEqual(self.skill.__str__(),"schlafen")

    def test_skillanswer(self):
        self.assertEqual(self.stsa.poll, self.stpoll)
        self.assertEqual(self.stsa.skill, self.skill)
        self.assertEqual(self.stsa.score, 2)
        self.assertRaises(Exception, self.stsa.full_clean())
        self.assertEqual(self.stsa.__str__(),"Max Mustermann (s12345) - schlafen")

    def test_roleanswer(self):
        self.assertEqual(self.stra.poll, self.stpoll)
        self.assertEqual(self.stra.role, self.role)
        self.assertEqual(self.stra.score, 3)
        self.assertEqual(self.stra.__str__(),"Max Mustermann (s12345) - Meister")
