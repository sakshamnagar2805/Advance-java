package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.model.Product;
import com.shopsphere.model.User;
import com.shopsphere.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Controller for Customer Order History & Order Details Tracking.
 * Fulfills RTU Syllabus Module 7 & Section 14 (OrderServlet).
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders", "/orders/*"})
public class OrderServlet extends HttpServlet {

    private final OrderService orderService;
    private final ProductDAO productDAO;

    public OrderServlet() {
        this.orderService = new OrderService();
        this.productDAO = new ProductDAO();
    }

    public OrderServlet(OrderService orderService, ProductDAO productDAO) {
        this.orderService = orderService;
        this.productDAO = productDAO;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=/orders");
            return;
        }

        String orderIdParam = req.getParameter("id");
        try {
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                // View specific order details
                Long orderId = Long.parseLong(orderIdParam.trim());
                Optional<Order> orderOpt = orderService.getOrderById(orderId);

                if (orderOpt.isPresent()) {
                    Order order = orderOpt.get();
                    // Security check: ensure order belongs to logged-in user unless admin
                    if (!order.getUserId().equals(user.getUserId()) && !"admin".equalsIgnoreCase(user.getRole())) {
                        resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this order.");
                        return;
                    }

                    List<OrderItem> items = orderService.getOrderItems(orderId);
                    Map<Long, Product> productMap = new HashMap<>();
                    for (OrderItem item : items) {
                        productDAO.findById(item.getProductId()).ifPresent(p -> productMap.put(p.getProductId(), p));
                    }

                    req.setAttribute("selectedOrder", order);
                    req.setAttribute("orderItems", items);
                    req.setAttribute("productMap", productMap);
                } else {
                    req.setAttribute("errorMessage", "Order not found.");
                }
            }

            // Always load list of user orders
            List<Order> orders = orderService.getUserOrders(user.getUserId());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid order identifier specified.");
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error loading orders: " + e.getMessage());
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);
        }
    }
}
