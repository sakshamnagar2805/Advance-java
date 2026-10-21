package com.servelent;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        // Application start hone par ye run hota hai
        System.out.println("Application Started Successfully!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // Application stop hone par ye run hota hai
        System.out.println("Application Stopped!");
    }
}