package com.example.teamsverwaltung.interfac;

import com.example.teamsverwaltung.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface algoproj extends JpaRepository<Role,Long> {
}
