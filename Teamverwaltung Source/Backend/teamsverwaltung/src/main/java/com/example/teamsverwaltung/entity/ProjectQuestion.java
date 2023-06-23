package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;

@Entity
@Table(name ="projectquestion")
public class ProjectQuestion {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name= "score")
    private  int Score;

    @Column(name= "projectid")
    private  Long  Projectid;

    @Column(name= "userid")
    private  Long  userid;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getScore() {
        return Score;
    }

    public void setScore(int score) {
        Score = score;
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

    public ProjectQuestion() {
    }

    public ProjectQuestion(int score, Long projectid, Long userid) {

        Score = score;
        Projectid = projectid;
        this.userid = userid;
    }
}
