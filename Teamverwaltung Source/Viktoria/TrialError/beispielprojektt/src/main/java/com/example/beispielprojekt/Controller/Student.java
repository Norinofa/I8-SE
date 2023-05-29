package com.example.beispielprojekt.Controller;

public class Student {

    String title;
    String first_name;
    String last_name;
    String email;
    String faculty;

    public Student(String title, String first_name, String last_name, String email, String faculty){

        this.title=title;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.faculty=faculty;
    }
}