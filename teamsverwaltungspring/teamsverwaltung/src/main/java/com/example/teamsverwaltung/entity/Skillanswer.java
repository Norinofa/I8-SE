package com.example.teamsverwaltung.entity;


import jakarta.persistence.*;

@Entity
@Table(name="skillanswer")
public class Skillanswer {


    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id ;
    @Column(name="score")
    private int score;

    @Column(name="skillid")
    private int skillid;
}
