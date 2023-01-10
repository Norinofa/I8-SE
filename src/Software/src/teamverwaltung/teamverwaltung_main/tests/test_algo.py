import unittest
import random
from ..algo import AssignmentAlgo
project_count = 10
role_count = 5
student_count = 100

class AlgoTestCases(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):                            # test preparation method
        global project_count, role_count, student_count
        # print('test data:')

        # create random project answers from 100 students for 10 projects
        cls.project_answers = {}
        for i in range(student_count):
            cls.project_answers[i] = {}
            for x in range(project_count):
                cls.project_answers[i][x] = random.randint(1, 5)
        # print('project answers:', self.project_answers)

        # create random role answers from 100 students
        cls.role_answers = {}
        for i in range(student_count):
            cls.role_answers[i] = {}
            for x in range(role_count):
                cls.role_answers[i][x] = random.randint(1, 5)
        # print('role answers:', self.role_answers)

        # define first 15% students as WIng students
        cls.wing = [0] * student_count
        for i in range(int(15/100*student_count)):
            cls.wing[i] = 1
        # print('wing students:', self.wing)

        # start algorithm
        algo = AssignmentAlgo(cls.project_answers,cls.role_answers, cls.wing)
        algo.run()
        cls.res = algo.get_result()

    @classmethod
    def tearDownClass(cls):                         # test's post test activities method
        cls.project_answers.clear()
        cls.role_answers.clear()
        cls.wing.clear()

    def test_allStudentsPartOfResult(self):
        global project_count, role_count, student_count


        # extract students from result
        students_res = [None]*len(self.res)
        for x in range(len(self.res)):
            students_res[x] = self.res[x][1]

        # check if every student is part of the result
        for x in range(student_count):
            self.assertIn(x, students_res, "at least one student is missing in the result")

    def test_allProjectsPartOfResult(self):
        global project_count, role_count, student_count


        # extract projects from result
        projects_res = [None] * len(self.res)
        for x in range(len(self.res)):
            projects_res[x] = self.res[x][0]

        # check if every project is part of the result
        for x in range(project_count):
            self.assertIn(x, projects_res, "at least one project is missing in the result. Project: Nr." + str(x))

    def test_everyStudentExactlyOneProject(self):
        global project_count, role_count, student_count


        # extract students from result
        students_res = [None]*len(self.res)
        for x in range(len(self.res)):
            students_res[x] = self.res[x][1]

        # check if all students are occurring exactly once in the result
        for student in students_res:
            self.assertEqual(1, students_res.count(student), "student " + str(student) +" is occurring multiple times in the result")

    def test_allStudentsEquallyDistributed(self):
        global project_count, role_count, student_count


        # extract projects from result
        projects_res = [None] * len(self.res)
        for x in range(len(self.res)):
            projects_res[x] = self.res[x][0]

        # count students per project
        projectmembers = [None] * project_count
        for project in projects_res:
            projectmembers[project] = projects_res.count(project)

        # check if the difference between max. and min. number of students per project is max. 1
        self.assertLessEqual(max(projectmembers)-min(projectmembers), 1, "the students are not equally distributed. Min. Projectmembers: " + str(min(projectmembers)) + ". Max Projectmembers: " + str(max(projectmembers)))

    def test_wingStudentsEquallyDistributed(self):
        global project_count, role_count, student_count


        # if a student is wing student, increase number of wing students for the project the student is assigned to
        wingprojectmembers = [0] * project_count
        for x in range(len(self.res)):
            if self.wing[self.res[x][1]] == 1:
                wingprojectmembers[self.res[x][0]] += 1
                
        # check if the difference between max. and min. number of wing students per project is max. 1
        self.assertLessEqual(max(wingprojectmembers)-min(wingprojectmembers), 1, "the wing-students are not equally distributed. Min. wing-students per project: " + str(min(wingprojectmembers)) + ". Max wing-students per project: " + str(max(wingprojectmembers)))

    def test_exactlyOneTeamleader(self):
        global project_count, role_count, student_count


        # if a student is team leader, increase number of team leaders for the project the student is assigned to
        leaderprojectmembers = [0] * project_count
        for x in range(len(self.res)):
            if self.res[x][2] == 4:
                leaderprojectmembers[self.res[x][0]] += 1

        # check for each project if the number of team leaders is exactly 1
        for x in range(project_count):
            self.assertEqual(1, leaderprojectmembers[x], "At least one project has not exactly one team leader. Project: Nr." + str(x))

    def test_rolesEquallyDistributed(self):
        global project_count, role_count, student_count


        # if a student is not team leader, increase number of students having the specific role of the student in the project the student is assigned to
        projectroles = [[0] * (role_count-1) for i in range(project_count)]
        for x in range(len(self.res)):
            if self.res[x][2] != 4:
                projectroles[self.res[x][0]][self.res[x][2]] += 1

        # check if the difference between max. and min. number of students per role per project is max. 1
        for x in range(project_count):
            self.assertLessEqual(max(projectroles[x])-min(projectroles[x]), 1, "the roles within the projects are not equally distributed.")


if __name__ == '__main__':
    unittest.main()
