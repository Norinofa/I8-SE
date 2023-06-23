package com.example.teamsverwaltung.entity;


import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name="student")
public class student  implements Serializable {
    @Column(name = "id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="firstname")
    private String firstname;
    @Column(name="lastname")
    private String lastname;
    @Column(name="email")
    private String email;

    @Column(name="studiengruppe")
    private String studiengruppe;

    public student() {
    }

    public student(int id, String firstname, String lastname, String email, String studiengruppe) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.studiengruppe = studiengruppe;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStudiengruppe() {
        return studiengruppe;
    }

    public void setStudiengruppe(String studiengruppe) {
        this.studiengruppe = studiengruppe;
    }
}
