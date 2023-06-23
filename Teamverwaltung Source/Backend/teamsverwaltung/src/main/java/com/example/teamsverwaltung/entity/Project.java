package com.example.teamsverwaltung.entity;
import jakarta.persistence.*;

@Entity
@Table(name ="project")

public class Project {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="name")
    private String name ;
    @Column(name="description")
    private String description;
    @Column(name="proid")
    private String proid;
    @Column(name="firma")
    private String firma;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProid() {
        return proid;
    }

    public void setProid(String proid) {
        this.proid = proid;
    }

    public Project(Long id, String name, String description, String proid, String firma) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.proid = proid;
        this.firma = firma;
    }

    public String getFirma() {
        return firma;
    }

    public void setFirma(String firma) {
        this.firma = firma;
    }

    public Project() {
    }
}
