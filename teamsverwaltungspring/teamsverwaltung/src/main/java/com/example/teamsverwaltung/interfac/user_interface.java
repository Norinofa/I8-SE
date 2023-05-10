package com.example.teamsverwaltung.interfac;
import com.example.teamsverwaltung.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface user_interface extends JpaRepository<User, Long> {
}
