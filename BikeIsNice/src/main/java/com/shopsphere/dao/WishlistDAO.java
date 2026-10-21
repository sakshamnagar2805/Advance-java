package com.shopsphere.dao;

import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Wishlist operations.
 * Implements JDBC PreparedStatement CRUD queries in accordance with RTU Syllabus Section 11.
 */
public class WishlistDAO {

    private static final String SQL_ADD = 
        "INSERT IGNORE INTO wishlist (user_id, product_id) VALUES (?, ?)";

    private static final String SQL_REMOVE = 
        "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";

    private static final String SQL_CHECK = 
        "SELECT COUNT(*) FROM wishlist WHERE user_id = ? AND product_id = ?";

    private static final String SQL_GET_USER_WISHLIST = 
        "SELECT p.product_id, p.category_id, p.sku, p.name, p.slug, p.description, " +
        "p.price, p.sale_price, p.stock_quantity, p.status, p.created_at, p.updated_at " +
        "FROM wishlist w " +
        "INNER JOIN products p ON w.product_id = p.product_id " +
        "WHERE w.user_id = ? ORDER BY w.created_at DESC";

    private static final String SQL_COUNT = 
        "SELECT COUNT(*) FROM wishlist WHERE user_id = ?";

    public boolean addToWishlist(Long userId, Long productId) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_ADD)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean removeFromWishlist(Long userId, Long productId) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_REMOVE)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean isInWishlist(Long userId, Long productId) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_CHECK)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public int getWishlistCount(Long userId) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_COUNT)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Product> getUserWishlist(Long userId) throws SQLException {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_USER_WISHLIST)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getLong("product_id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setSku(rs.getString("sku"));
                    product.setName(rs.getString("name"));
                    product.setSlug(rs.getString("slug"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setSalePrice(rs.getBigDecimal("sale_price"));
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setStatus(rs.getString("status"));
                    list.add(product);
                }
            }
        }
        return list;
    }
}
