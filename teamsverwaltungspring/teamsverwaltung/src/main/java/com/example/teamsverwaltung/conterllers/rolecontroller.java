package com.example.teamsverwaltung.conterllers;

import com.example.teamsverwaltung.entity.Role;
import com.example.teamsverwaltung.interfac.Role_interface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
@RestController
@CrossOrigin("*")
@RequestMapping("/role")
public class rolecontroller {


    @Autowired
    private Role_interface roleobj;


    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody Role savedteam ) {

        roleobj.save(savedteam);
    }
    /// get alll teams
    /// select *
    @GetMapping(path = "/getall")
    public List<Role> getallteams() {

        return  roleobj.findAll();
    }


    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<Role> getbyid(@PathVariable(value = "id") Long id) {
        return  roleobj.findById(id);
    }


    // delete team by id
    @DeleteMapping(path="/delete/{id}")
    public void  deletebyid(@PathVariable(value = "id") Long id) {
        roleobj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path="/deleteall")
    public void  deleteall() {
        roleobj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void  editbyid( @RequestBody  Role editteam) {

        roleobj.save(editteam);
    }


}


