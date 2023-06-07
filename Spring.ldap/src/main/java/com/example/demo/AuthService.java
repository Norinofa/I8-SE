package com.example.demo;


import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.NamingException;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.query.LdapQuery;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.naming.directory.Attributes;
import java.util.List;

import static org.springframework.ldap.query.LdapQueryBuilder.query;

@Service

public class AuthService {
    private final LdapTemplate ldapTemplate;

    public AuthService(LdapTemplate ldapTemplate) {
        this.ldapTemplate = ldapTemplate;
    }
    public boolean authenticate(String uid, String password) {
        try {
            // Construct the search query
            LdapQuery ldapQuery = query()
                    .base("ou=people,dc=htw-dresden,dc=de")
                    .where("uid").is(uid);

            // Search for the user using the query
            List<User> users = ldapTemplate.search(ldapQuery, new UserAttributesMapper());

            if (users.isEmpty()) {
                throw new UsernameNotFoundException("Invalid credentials");
            }

            User user = users.get(0);
            String userDn = "uid=" + user.getUid() + ",ou=people,dc=htw-dresden,dc=de";

            // Authenticate using the user DN and password
            //     ldapTemplate.authenticate(userDn, password);

            return true; // Authentication successful
        } catch (AuthenticationException e) {
            return false; // Authentication failed
        }
    }
}

class UserAttributesMapper implements AttributesMapper<User> {
    @Override
    public User mapFromAttributes(Attributes attributes) throws NamingException {
        User user = new User();

        // Set other user attributes as needed
        return user;
    }
}
