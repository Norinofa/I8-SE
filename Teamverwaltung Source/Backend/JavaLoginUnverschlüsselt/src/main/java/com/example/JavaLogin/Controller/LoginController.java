package com.example.JavaLogin.Controller;

import com.example.JavaLogin.LdapService;
import com.example.JavaLogin.UserCredentials;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
    private final LdapService ldapService;

    @Autowired
    public LoginController(LdapService ldapService) {
        this.ldapService = ldapService;
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(UserCredentials userCredentials, Model model) {
        boolean isAuthenticated = ldapService.authenticate(userCredentials.getUsername(), userCredentials.getPassword());

        if (isAuthenticated) {
            model.addAttribute("message", "Authentication successful");
            return "success";
        } else {
            model.addAttribute("error", "Invalid credentials. Please try again.");
            return "login";
        }
    }
}

