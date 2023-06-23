package com.example.teamsverwaltung.interfac;


import com.example.teamsverwaltung.entity.student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface student_interface extends JpaRepository<student, Long> {
}
