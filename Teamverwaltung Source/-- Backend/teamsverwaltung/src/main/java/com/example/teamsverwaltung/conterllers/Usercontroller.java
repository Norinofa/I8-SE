package com.example.teamsverwaltung.conterllers;


import com.example.teamsverwaltung.entity.logins;
import com.example.teamsverwaltung.entity.person;
import com.example.teamsverwaltung.interfac.user_interface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Optional;


@RestController
@CrossOrigin(value = "*",allowedHeaders = "*")
@RequestMapping("/Users")
public class Usercontroller {

    @Autowired
    private user_interface userobj;

    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public void savetema(@RequestBody person savedteam) {

        userobj.save(savedteam);
    }


    @PostMapping(path = "/login")
    public ResponseEntity<person> login(@RequestBody logins loginRequest) {
        person foundUser = userobj.findByUsername(loginRequest.getUsername());
        if (foundUser != null && foundUser.getPassword().equals(loginRequest.getPassword())) {
            return ResponseEntity.ok(foundUser);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);

        }

}


    /// get alll teams
    /// select *
    @GetMapping(path = "/getall")
    public List<person> getallteams() {
        return userobj.findAll();
    }


    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<person> getbyid(@PathVariable(value = "id") int id) {
        return userobj.findById(id);
    }


    // delete team by id
    @DeleteMapping(path = "/delete/{id}")
    public void deletebyid(@PathVariable(value = "id") int id) {
        userobj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path = "/deleteall")
    public void deleteall() {
        userobj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void editbyid(@RequestBody person editteam) {

        userobj.save(editteam);
    }




}
