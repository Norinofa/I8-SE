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


    @Column(name= "userid")
    private  Long  userid;

    public Skillanswer() {
    }

    public Skillanswer(Long id, int score, int skillid, Long userid) {
        this.id = id;
        this.score = score;
        this.skillid = skillid;
        this.userid = userid;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getSkillid() {
        return skillid;
    }

    public void setSkillid(int skillid) {
        this.skillid = skillid;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }
}
