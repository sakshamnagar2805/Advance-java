package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.dao.WishlistDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Controller for Customer Wishlist operations.
 * Fulfills RTU Syllabus Module 7 (Customer Module) & Section 14 (Servlet Controllers).
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist", "/wishlist/*"})
public class WishlistServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO;
    private final CartDAO cartDAO;

    public WishlistServlet() {
        this.wishlistDAO = new WishlistDAO();
        this.cartDAO = new CartDAO();
    }

    public WishlistServlet(WishlistDAO wishlistDAO, CartDAO cartDAO) {
        this.wishlistDAO = wishlistDAO;
        this.cartDAO = cartDAO;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=/wishlist");
            return;
        }

        try {
            List<Product> wishlistProducts = wishlistDAO.getUserWishlist(user.getUserId());
            req.setAttribute("wishlistProducts", wishlistProducts);
            session.setAttribute("wishlistCount", wishlistProducts.size());
            req.getRequestDispatcher("/wishlist.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Failed to load wishlist: " + e.getMessage());
            req.getRequestDispatcher("/wishlist.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=/wishlist");
            return;
        }

        String action = req.getParameter("action");
        String productIdStr = req.getParameter("productId");

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/wishlist");
            return;
        }

        try {
            Long productId = Long.parseLong(productIdStr.trim());

            if ("add".equalsIgnoreCase(action)) {
                wishlistDAO.addToWishlist(user.getUserId(), productId);
                session.setAttribute("wishlistSuccess", "Product added to your Wishlist!");
            } else if ("remove".equalsIgnoreCase(action)) {
                wishlistDAO.removeFromWishlist(user.getUserId(), productId);
                session.setAttribute("wishlistSuccess", "Product removed from your Wishlist.");
            } else if ("moveToCart".equalsIgnoreCase(action)) {
                CartItem item = new CartItem(null, user.getUserId(), productId, 1, null, null);
                cartDAO.addOrUpdateItem(item);
                wishlistDAO.removeFromWishlist(user.getUserId(), productId);
                session.setAttribute("wishlistSuccess", "Moved product to shopping cart!");
            }

            int count = wishlistDAO.getWishlistCount(user.getUserId());
            session.setAttribute("wishlistCount", count);

        } catch (NumberFormatException | SQLException e) {
            session.setAttribute("wishlistError", "Error updating wishlist: " + e.getMessage());
        }

        String referer = req.getHeader("Referer");
        if (referer != null && !referer.contains("/login")) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/wishlist");
        }
    }
}
