package com.example.teamsverwaltung.interfac;


import com.example.teamsverwaltung.entity.RoleQuestion;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

public interface rolequestion extends JpaRepository<RoleQuestion,Long> {
    @Transactional
    void deleteByUserid(Long userid);

}
