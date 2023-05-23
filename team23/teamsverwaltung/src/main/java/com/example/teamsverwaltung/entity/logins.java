package com.example.teamsverwaltung.entity;

public class logins {
    String username;
    String password;

    public logins(String username) {
        this.username = username;
    }

    public logins(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
