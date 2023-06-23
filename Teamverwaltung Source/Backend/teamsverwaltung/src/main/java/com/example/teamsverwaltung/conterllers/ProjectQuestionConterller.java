package com.example.teamsverwaltung.conterllers;



import com.example.teamsverwaltung.entity.ProjectQuestion;
import com.example.teamsverwaltung.interfac.projectquestion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/Answers/Project")
public class ProjectQuestionConterller {
    @Autowired
    private projectquestion projobj;
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody List<ProjectQuestion> savedteam ) {

        projobj.saveAll(savedteam);
    }
    @PostMapping (path = "/get")
    public   int getsavetema(@RequestBody  answerget getid ) {
        int x = 0;
        List<ProjectQuestion> getall = projobj.findAll();
        for (ProjectQuestion s : getall) {
            if (getid.userid==s.getUserid()&&getid.subid==s.getProjectid())
            {
                x = s.getScore();
            }
        }
        return x;
    }
    @GetMapping(path ="/deleteall")
        public void removeall() {
        projobj.deleteAll();
    }
    @DeleteMapping(path = "/delall/{id}")
    @Transactional
    public void deleteByUserId(@PathVariable("id") Long userId) {
        projobj.deleteByUserid(userId);
    }

}
