package com.example.teamsverwaltung.interfac;


import com.example.teamsverwaltung.entity.ProjectQuestion;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;


public interface projectquestion extends JpaRepository<ProjectQuestion, Long> {
    @Transactional
    void deleteByUserid(Long userid);

}
