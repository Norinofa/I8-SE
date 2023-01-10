def queryset2algo(q_student, q_project):

    # stores key map for students for solution writeback to database
    # like so: {index_of_student_in_algo:pk_of_student_in_database}
    student_keys = {}
    # project key map
    # {index_of_project_in_algo:pk_of_project_in_database}
    project_keys = {}

    is_wing = []
    n_projects = 0

    # parse student's faculty
    for i in range(len(q_student)):
        print(q_student[i])
        student_keys[i] = q_student[i].get("pk")
        if q_student[i].get("poll__is_wing") == True:
            is_wing.append(1)
        elif q_student[i].get("poll__is_wing") == False:
            is_wing.append(0)
        else:
            pass
            # TODO: raise exception

    # parse project
    for i in range(len(q_project)):
        print(q_project[i])
        project_keys[i] = q_project[i].get("pk")
    n_projects = len(q_project)

    print(student_keys)
    print(project_keys)
    print(is_wing)
    print(f"n_projects: {n_projects}")
