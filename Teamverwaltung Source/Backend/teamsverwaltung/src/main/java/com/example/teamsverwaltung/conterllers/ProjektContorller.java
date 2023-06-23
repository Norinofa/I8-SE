package com.example.teamsverwaltung.conterllers;

import com.example.teamsverwaltung.entity.Project;
import com.example.teamsverwaltung.entity.Skill;
import com.example.teamsverwaltung.interfac.project_interface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;


@RestController
@CrossOrigin("*")
@RequestMapping("/Project")
public class ProjektContorller {


    @Autowired
    private project_interface projobj;


    /// save  Team
    //insert
    @PostMapping(path = "/save")
    public  void savetema(@RequestBody Project savedteam ) {

        projobj.save(savedteam);
    }
    /// get alll teams
    /// select *
    @GetMapping(path = "/getall")
    public List<Project> getallteams() {
        return  projobj.findAll();
    }

    @GetMapping(path = "/getprojid/{id}")
    public boolean isprojectexsit(@PathVariable(value = "id")  String projd) {
        boolean isexsit = false;
        List<Project> allprojtes = projobj.findAll();
        for(Project is : allprojtes) {
            if(is.getProid().equals(projd))
            {
                isexsit =true;
            }
        }
        return isexsit;
    }
    // select where id
    @GetMapping(path = "/getbyid/{id}")
    public Optional<Project> getbyid(@PathVariable(value = "id") Long id) {
        return  projobj.findById(id);
    }


    // delete team by id
    @DeleteMapping(path="/delete/{id}")
    public void  deletebyid(@PathVariable(value = "id") Long id) {
        projobj.deleteById(id);
    }

    // delete all
    @DeleteMapping(path="/deleteall")
    public void  deleteall() {
        projobj.deleteAll();
    }

    @PutMapping(path = "/edit/{id}")
    public void editById(@PathVariable(value = "id") Long id, @RequestBody Project updatedProject) {
        Project existingProject = projobj.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Project not found with ID: " + id));

        // Update the existing project with the new values
        existingProject.setName(updatedProject.getName());
        existingProject.setDescription(updatedProject.getDescription());
        existingProject.setProid(updatedProject.getProid());
        existingProject.setFirma(updatedProject.getFirma());
        // Update other fields as needed

        // Save the updated project
        projobj.save(existingProject);
    }



}
