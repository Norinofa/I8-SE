package com.example.teamsverwaltung.conterllers;


import com.example.teamsverwaltung.entity.Skill;
import com.example.teamsverwaltung.entity.student;

import com.example.teamsverwaltung.interfac.student_interface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/student")
public class studentconteroller {
    @Autowired
    private student_interface stdobj;
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody student savedteam ) {

        stdobj.save(savedteam);
    }
    @PostMapping(path = "/saveall")
    public  void savetema(@RequestBody List<student> savedteam ) {

        stdobj.saveAll(savedteam);
        System.out.print(savedteam);
    }
    @GetMapping(path = "/getall")
    public List<student> getallteams() {
        return  stdobj.findAll();
    }


}
