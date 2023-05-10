package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;


import java.math.BigDecimal;
import java.math.BigInteger;

@Entity
@Table(name ="skill")
public class Skill {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigInteger id;
    @Column(name="skill")
    private String skill;

    public Skill(BigInteger id, String skill) {
        this.id = id;
        this.skill = skill;
    }
}
