package com.example.teamsverwaltung.conterllers;



import com.example.teamsverwaltung.entity.RoleQuestion;

import com.example.teamsverwaltung.interfac.rolequestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/Answers/Role")
public class RoleqwestionContller {
    @Autowired
    private rolequestion rolobj;
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody List<RoleQuestion> savedteam ) {

        rolobj.saveAll(savedteam);
    }
}
