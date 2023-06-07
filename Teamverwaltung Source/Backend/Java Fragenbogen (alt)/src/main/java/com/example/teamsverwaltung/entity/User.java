package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;

import java.sql.Time;

@Entity
@Table(name="User")
public class User {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="password")
    private String password;
    @Column(name="last_login")
    private Time last_login;
    @Column(name="is_superuser")
    private boolean is_superuser;
    @Column(name="username")
    private String username;
    @Column(name="email")
    private String email;
    @Column(name="is_staff")
    private boolean is_staff;
    @Column(name="is_active")
    private boolean is_active;
    @Column(name="date_joined")
    private Time date_joined;
    @Column(name="frist_name")
    private String frist_name;
    @Column(name="last_name")
    private String last_name;
    @Column(name="groups")
    private String groups;

    @Column(name="user_permission")
    private String user_permission;

    public User(Long  id, String password, Time last_login, boolean is_superuser, String username, String email, boolean is_staff, boolean is_active, Time date_joined, String frist_name, String last_name, String groups, String user_permission) {
        this.id = id;
        this.password = password;
        this.last_login = last_login;
        this.is_superuser = is_superuser;
        this.username = username;
        this.email = email;
        this.is_staff = is_staff;
        this.is_active = is_active;
        this.date_joined = date_joined;
        this.frist_name = frist_name;
        this.last_name = last_name;
        this.groups = groups;
        this.user_permission = user_permission;
    }
}
