package com.example.teamsverwaltung.conterllers;



import com.example.teamsverwaltung.entity.ProjectQuestion;
import com.example.teamsverwaltung.interfac.projectquestion;
import org.springframework.beans.factory.annotation.Autowired;
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
}
