package com.example.teamsverwaltung.conterllers;



import com.example.teamsverwaltung.entity.ProjectQuestion;
import com.example.teamsverwaltung.entity.RoleQuestion;

import com.example.teamsverwaltung.interfac.rolequestion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
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
    @PostMapping (path = "/get")
    public   int getsavetema(@RequestBody  answerget getid ) {
        int x = 0;
        List<RoleQuestion> getall = rolobj.findAll();
        for (RoleQuestion s : getall) {
            if (getid.userid==s.getUserid()&&getid.subid==s.getProjectid())
            {
                x = s.getScore();
            }
        }
        return x;
    }
    @GetMapping(path ="/deleteall")
    public void removeall() {
        rolobj.deleteAll();
    }
    @DeleteMapping(path = "/delall/{id}")
    @Transactional
    public void deleteByUserId(@PathVariable("id") Long userId) {
        rolobj.deleteByUserid(userId);
    }
}
