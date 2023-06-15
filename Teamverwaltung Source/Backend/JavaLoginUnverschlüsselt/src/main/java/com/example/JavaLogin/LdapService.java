package com.example.JavaLogin;


import org.springframework.stereotype.Service;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

@Service
public class LdapService {
    private final String ldapUrl = "ldap://rlux40.rz.htw-dresden.de:389";
    //private final String ldapUrl = "ldaps://rlux40.rz.htw-dresden.de:636";
    private final String ldapBaseDn = "ou=people,dc=htw-dresden,dc=de";

    public boolean authenticate(String username, String password) {
        String ldapUsername = "uid=" + username + "," + ldapBaseDn;

        System.out.println("User und Passwort: " + username + ", " +password);

        try {

            System.setProperty("jdk.tls.client.protocols", "TLSv1.3,TLSv1.2");
            // Set up environment properties for LDAP connection
            java.util.Hashtable<String, String> env = new java.util.Hashtable<>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, ldapUrl);

            env.put(Context.SECURITY_AUTHENTICATION, "simple");

            env.put(Context.SECURITY_PRINCIPAL, ldapUsername);
            env.put(Context.SECURITY_CREDENTIALS, password);

            // Create the initial context
            DirContext ctx = new InitialDirContext(env);
            System.out.println("Authentication successful");
            // If the context was created successfully, authentication was successful
            ctx.close();
            return true;
        } catch (NamingException e) {
            System.out.println("Authentication failed");
            e.printStackTrace();
            return false;

        }

    }
}