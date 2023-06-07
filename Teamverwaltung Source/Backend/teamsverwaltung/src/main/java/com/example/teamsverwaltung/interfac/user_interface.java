package com.example.teamsverwaltung.interfac;
import com.example.teamsverwaltung.entity.person;
import org.springframework.data.jpa.repository.JpaRepository;


public interface user_interface extends JpaRepository<person, Integer> {
    person findByUsername(String username);

}
