package com.example.teamsverwaltung.conterllers;

import com.example.teamsverwaltung.entity.RoleQuestion;
import com.example.teamsverwaltung.entity.Skill;
import com.example.teamsverwaltung.entity.Skillanswer;
import com.example.teamsverwaltung.interfac.Skillanswer_interface;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/Answers/Skill")
public class Skillanswercontroller {

    @Autowired
    private Skillanswer_interface Skillanswerobj;


    @PostMapping (path = "/gets")
    public   int getsavetema(@RequestBody  answerget getid ) {
        int x = 0;
        List<Skillanswer> getall = Skillanswerobj.findAll();
        for (Skillanswer s : getall) {
            if (getid.userid==s.getUserid()&&getid.subid==s.getSkillid())
            {
                x = s.getScore();
            }
        }
        return x;
    }

    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody List<Skillanswer> savedteam ) {

        Skillanswerobj.saveAll(savedteam);
    }
    /// get alll teams
    /// select *

    @GetMapping(path = "/getall")
    public List<Skillanswer> getallteams() {
        return  Skillanswerobj.findAll();
    }


    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<Skillanswer> getbyid(@PathVariable(value = "id") Long id) {
        return  Skillanswerobj.findById(id);
    }

    @GetMapping(path ="/deleteall")
    public void removeall() {
        Skillanswerobj.deleteAll();
    }
    // delete team by id
    @DeleteMapping(path="/delete/{id}")
    public void  deletebyid(@PathVariable(value = "id") Long id) {
        Skillanswerobj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path="/deleteall")
    public void  deleteall() {
        Skillanswerobj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void  editbyid( @RequestBody  Skillanswer editteam) {

        Skillanswerobj.save(editteam);
    }



    @DeleteMapping(path = "/delall/{id}")
    @Transactional
    public void deleteByUserId(@PathVariable("id") Long userId) {
        Skillanswerobj.deleteByUserid(userId);
    }


}
