package com.example.teamsverwaltung.conterllers;

import com.example.teamsverwaltung.entity.Project;
import com.example.teamsverwaltung.entity.Teams;
import com.example.teamsverwaltung.entity.person;
import com.example.teamsverwaltung.interfac.algoproj;
import com.example.teamsverwaltung.interfac.project_interface;
import com.example.teamsverwaltung.interfac.teams_lnterface;
import com.example.teamsverwaltung.interfac.user_interface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/Algo")
public class ALgo {
    @Autowired
    private user_interface userobj;
    @Autowired
    private teams_lnterface teams_obj;
    @Autowired
    private algoproj algoobj;
    @Autowired
    private project_interface projobj;
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody Teams savedteam ) {



}

}
