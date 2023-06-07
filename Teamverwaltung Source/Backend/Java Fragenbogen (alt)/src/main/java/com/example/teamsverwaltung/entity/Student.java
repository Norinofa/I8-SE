package com.example.teamsverwaltung.entity;


import jakarta.persistence.*;

import java.math.BigInteger;

@Entity
@Table(name="Student")
public class Student {
    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name="name")
    private String  name ;

    @Column(name="s_num")
    private String s_num;





}
