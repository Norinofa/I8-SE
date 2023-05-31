package com.example.teamsverwaltung.conterllers;


import com.example.teamsverwaltung.entity.Teams;
import com.example.teamsverwaltung.interfac.teams_lnterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/teams")
public class teamcontller {
    @Autowired
    private teams_lnterface teams_obj;


    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody Teams savedteam ) {

        teams_obj.save(savedteam);
    }
    /// get alll teams
    /// select *
    @GetMapping(path = "/getall")
    public List<Teams> getallteams() {
      return  teams_obj.findAll();
    }


    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<Teams>  getbyid(@PathVariable(value = "id") Long id) {
        return  teams_obj.findById(id);
    }


    // delete team by id
    @DeleteMapping(path="/delete/{id}")
    public void  deletebyid(@PathVariable(value = "id") Long id) {
          teams_obj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path="/deleteall")
    public void  deleteall() {
        teams_obj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void  editbyid( @RequestBody  Teams editteam) {

        teams_obj.save(editteam);
    }




}
