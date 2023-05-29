package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;

@Entity
@Table(name="RoleQuestion")
public class RoleQuestion {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="score")
    private int score;

    @Column(name= "roleid")
    private  Long  Projectid;

    @Column(name= "userid")
    private  Long  userid;

    public RoleQuestion(Long id, int score, Long projectid, Long userid) {
        this.id = id;
        this.score = score;
        Projectid = projectid;
        this.userid = userid;
    }

    public RoleQuestion() {
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

    public Long getProjectid() {
        return Projectid;
    }

    public void setProjectid(Long projectid) {
        Projectid = projectid;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }
}
