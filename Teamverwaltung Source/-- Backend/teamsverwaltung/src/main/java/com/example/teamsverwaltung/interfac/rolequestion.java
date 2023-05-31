package com.example.teamsverwaltung.interfac;


import com.example.teamsverwaltung.entity.RoleQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface rolequestion extends JpaRepository<RoleQuestion,Long> {
}
