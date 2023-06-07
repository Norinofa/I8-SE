package com.example.teamsverwaltung.interfac;

import com.example.teamsverwaltung.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;


public interface project_interface extends JpaRepository<Project, Long> {
}
