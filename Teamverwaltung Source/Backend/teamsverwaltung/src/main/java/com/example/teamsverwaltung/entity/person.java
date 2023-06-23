package com.example.teamsverwaltung.entity;


import jakarta.persistence.*;

@Entity
@Table(name="users")
public class person {
    @Column(name = "id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="password")
    private String password;

    @Column(name="username")
    private String username;

    @Column(name="firstname")
    private String firstname;

    @Column(name="lastname")
    private String lastname;
    @Column(name="role")
    private String role;

    @Column(name="issanswerd")
    private String ISAnswred;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public person(int id, String password, String username, String firstname, String lastname, String role, String ISAnswred) {
        this.id = id;
        this.password = password;
        this.username = username;
        this.firstname = firstname;
        this.lastname = lastname;
        this.role = role;
        this.ISAnswred = ISAnswred;
    }

    public person() {
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public String getISAnswred() {
        return ISAnswred;
    }

    public void setISAnswred(String ISAnswred) {
        this.ISAnswred = ISAnswred;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
