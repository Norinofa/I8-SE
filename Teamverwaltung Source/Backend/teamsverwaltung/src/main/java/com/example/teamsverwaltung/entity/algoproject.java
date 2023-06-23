package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;

@Entity
@Table(name ="project")
public class algoproject {
    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="student")
    private String student ;
    @Column(name="Role")
    private String Role;
    @Column(name="Project")
    private String Project;
    @Column(name="team")
    private String team;

    public algoproject(Long id, String student, String role, String project, String team) {
        this.id = id;
        this.student = student;
        Role = role;
        Project = project;
        this.team = team;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStudent() {
        return student;
    }

    public void setStudent(String student) {
        this.student = student;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String role) {
        Role = role;
    }

    public String getProject() {
        return Project;
    }

    public void setProject(String project) {
        Project = project;
    }
}
