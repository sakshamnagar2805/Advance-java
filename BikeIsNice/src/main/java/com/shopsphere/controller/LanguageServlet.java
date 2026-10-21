package com.shopsphere.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Locale;

/**
 * Controller to switch application language locale in user session.
 * Demonstrates RTU Syllabus Section 23 (Internationalization).
 */
@WebServlet(name = "LanguageServlet", urlPatterns = {"/language"})
public class LanguageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String lang = req.getParameter("lang");
        HttpSession session = req.getSession(true);

        if ("hi".equalsIgnoreCase(lang)) {
            session.setAttribute("userLocale", Locale.of("hi", "IN"));
            session.setAttribute("currentLang", "hi");
        } else {
            session.setAttribute("userLocale", Locale.ENGLISH);
            session.setAttribute("currentLang", "en");
        }

        String referer = req.getHeader("Referer");
        if (referer != null && !referer.trim().isEmpty()) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
