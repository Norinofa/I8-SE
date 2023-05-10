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
    @Column(name="responsible")
    private String responsible;
    @Column(name="documentfile_url")
    private String documentfile_url;

    public Project(Long id, String name, String description, String responsible, String documentfile_url) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.responsible = responsible;
        this.documentfile_url = documentfile_url;
    }
}
