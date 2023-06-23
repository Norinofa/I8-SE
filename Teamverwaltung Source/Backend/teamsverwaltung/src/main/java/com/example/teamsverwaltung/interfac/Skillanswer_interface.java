package com.example.teamsverwaltung.interfac;

import com.example.teamsverwaltung.entity.Role;
import com.example.teamsverwaltung.entity.Skillanswer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

public interface Skillanswer_interface  extends JpaRepository<Skillanswer,Long> {

    @Transactional
    void deleteByUserid(Long userid);

}
