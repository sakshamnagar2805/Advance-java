package com.shopsphere.listener;

import com.shopsphere.util.DBConnection;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Application & Session Lifecycle Listener.
 * Implements ServletContextListener and HttpSessionListener in accordance with RTU Syllabus Section 15.
 * Demonstrates web-container event tracking, active session count calculation, and resource management.
 */
@WebListener
public class AppListener implements ServletContextListener, HttpSessionListener {

    private final AtomicInteger activeSessions = new AtomicInteger(0);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String startTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        context.setAttribute("appStartTime", startTime);
        context.setAttribute("appName", "BikeIsNice (ShopSphere)");
        context.setAttribute("activeSessions", activeSessions);

        System.out.println("==================================================================");
        System.out.println("[AppListener] Application context initialized at: " + startTime);
        System.out.println("[AppListener] RTU Advanced Java E-Commerce System Container Ready.");
        System.out.println("==================================================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[AppListener] Application context destroying. Shutting down HikariCP connection pool...");
        try {
            DBConnection.closeDataSource();
            System.out.println("[AppListener] Database connection pool cleanly closed.");
        } catch (Exception e) {
            System.err.println("[AppListener] Error closing database pool: " + e.getMessage());
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = activeSessions.incrementAndGet();
        System.out.println("[AppListener] New HttpSession created: " + se.getSession().getId() + " | Active sessions: " + count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int count = activeSessions.decrementAndGet();
        if (count < 0) {
            activeSessions.set(0);
            count = 0;
        }
        System.out.println("[AppListener] HttpSession invalidated: " + se.getSession().getId() + " | Active sessions: " + count);
    }
}
