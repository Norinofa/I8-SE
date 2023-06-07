package com.example.demo;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@CrossOrigin(value = "*",allowedHeaders = "*")
@RequestMapping("/Users")
public class Usercontroller {



    public Usercontroller(AuthService authService) {
        this.authService = authService;
    }

    /// save  Team
    //insert


    private final AuthService authService;


    @PostMapping("/logins")
    public ResponseEntity<String> loginss(@RequestBody logins loginRequest) {
        if (authService.authenticate(loginRequest.getUsername(), loginRequest.getPassword())) {
            return ResponseEntity.ok("Login successful");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }







}
