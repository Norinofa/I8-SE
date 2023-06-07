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
    private Long id;
    @Column(name="skill")
    private String skill;

    public Skill(String skill) {
        this.skill = skill;
    }

    public Skill(Long id, String skill) {
        this.id = id;
        this.skill = skill;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public Skill() {
    }
}
