package com.example.teamsverwaltung.entity;

import jakarta.persistence.*;

import java.math.BigInteger;

@Entity
@Table(name="Role")


public class Role {

    @Column(name="id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="role")
    private String role;

    public Role(Long id, String role) {
        this.id = id;
        this.role = role;
    }
}
