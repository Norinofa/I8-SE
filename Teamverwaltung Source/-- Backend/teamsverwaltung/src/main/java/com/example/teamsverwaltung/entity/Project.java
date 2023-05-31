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

    public String getResponsible() {
        return responsible;
    }

    public void setResponsible(String responsible) {
        this.responsible = responsible;
    }

    public String getDocumentfile_url() {
        return documentfile_url;
    }

    public void setDocumentfile_url(String documentfile_url) {
        this.documentfile_url = documentfile_url;
    }

    public Project(Long id, String name, String description, String responsible, String documentfile_url) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.responsible = responsible;
        this.documentfile_url = documentfile_url;
    }
    public Project() {
    }
}
