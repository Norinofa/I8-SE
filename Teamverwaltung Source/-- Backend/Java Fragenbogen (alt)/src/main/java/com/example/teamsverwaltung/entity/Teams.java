package com.example.teamsverwaltung.entity;
import jakarta.persistence.*;

@Entity
@Table(name ="teams")
public class Teams {

    @Column(name = "id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;



    @Column(name = "teamname")
    public String teamname;
    @Column(name ="mixzahl")
    public int mixzahl;
    @Column(name="minanzahl")
    public int minanzahl;

    public Teams(String teamname, int mixzahl, int minanzahl) {
        this.teamname = teamname;
        this.mixzahl = mixzahl;
        this.minanzahl = minanzahl;
    }

    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }

    public int getMixzahl() {
        return mixzahl;
    }

    public void setMixzahl(int mixzahl) {
        this.mixzahl = mixzahl;
    }

    public int getMinanzahl() {
        return minanzahl;
    }

    public void setMinanzahl(int minanzahl) {
        this.minanzahl = minanzahl;
    }
}
