package dao;

import model.Order;
import model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        // Joining with users table to get customer name
        String sql = "SELECT o.*, u.name as customerName FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("order_date"),
                    rs.getDouble("total_amount"),
                    rs.getString("status") // Add status here
                );
                order.setCustomerName(rs.getString("customerName"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        // Joining with products table to get product name
        String sql = "SELECT oi.*, p.name as productName FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                    );
                    item.setProductName(rs.getString("productName"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public int createOrder(int userId, double totalAmount) {
        String sql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
        int orderId = -1;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setDouble(2, totalAmount);
            stmt.setString(3, "Pending"); // Default status
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public void addOrderItem(int orderId, int productId, int quantity, double price) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, price);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getUserOrders(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.name as customerName FROM orders o JOIN users u ON o.user_id = u.id WHERE o.user_id = ? ORDER BY o.order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("order_date"),
                        rs.getDouble("total_amount"),
                        rs.getString("status") // Include status
                    );
                    order.setCustomerName(rs.getString("customerName"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
