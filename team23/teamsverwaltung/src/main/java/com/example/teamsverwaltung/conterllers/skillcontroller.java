package com.example.teamsverwaltung.conterllers;

import com.example.teamsverwaltung.entity.Skill;
import com.example.teamsverwaltung.entity.Teams;
import com.example.teamsverwaltung.interfac.Skill_interface;
import com.example.teamsverwaltung.interfac.teams_lnterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/skills")
public class skillcontroller {
    @Autowired
    private Skill_interface Skillobj;


    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody Skill savedteam ) {

        Skillobj.save(savedteam);
    }
    /// get alll teams
    /// select *
    @GetMapping(path = "/getall")
    public List<Skill> getallteams() {
        return  Skillobj.findAll();
    }


    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<Skill> getbyid(@PathVariable(value = "id") Long id) {
        return  Skillobj.findById(id);
    }


    // delete team by id
    @DeleteMapping(path="/delete/{id}")
    public void  deletebyid(@PathVariable(value = "id") Long id) {
        Skillobj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path="/deleteall")
    public void  deleteall() {
        Skillobj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void  editbyid( @RequestBody  Skill editteam) {

        Skillobj.save(editteam);
    }
}
