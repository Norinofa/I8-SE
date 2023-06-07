package com.example.demo;

import org.springframework.data.ldap.repository.LdapRepository;

public interface UserRepository extends LdapRepository<User> {
}
