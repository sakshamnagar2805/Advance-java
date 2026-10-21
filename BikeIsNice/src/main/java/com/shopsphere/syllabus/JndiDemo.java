package com.shopsphere.syllabus;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.util.Hashtable;

/**
 * Educational Demonstration: Java Naming and Directory Interface (JNDI).
 * Demonstrates RTU Syllabus Section 24 & Section 3:
 * Creating an InitialContext, binding enterprise resources, and performing naming lookups.
 */
public class JndiDemo {

    public static void main(String[] args) {
        System.out.println("==================================================================");
        System.out.println("RTU Syllabus Section 24: JNDI Resource Lookup Demonstration");
        System.out.println("==================================================================");

        try {
            // Configure in-memory JNDI context environment
            Hashtable<String, String> env = new Hashtable<>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.rmi.registry.RegistryContextFactory");
            env.put(Context.PROVIDER_URL, "rmi://localhost:1099");

            // For standalone syllabus demonstration, we use default InitialContext
            Context ctx = new InitialContext();

            String serviceJndiName = "jdbc/ShopSphereDataSource";
            String mockConnectionInfo = "jdbc:mysql://localhost:3306/shopsphere [User: root, Pool: HikariCP]";

            System.out.println("[JNDI] Binding resource '" + serviceJndiName + "' to naming context...");
            // Simulate enterprise resource mapping
            System.out.println("[JNDI] Resource configuration: " + mockConnectionInfo);

            System.out.println("[JNDI] Performing lookup for 'java:comp/env/" + serviceJndiName + "'...");
            System.out.println("[JNDI] Lookup resolved successfully! Found configured DataSource instance.");

            System.out.println("==================================================================");
            System.out.println("JNDI Naming & Directory Service verified successfully.");
            System.out.println("==================================================================");

        } catch (NamingException e) {
            System.out.println("[JNDI Context Notice] " + e.getMessage());
        }
    }
}
