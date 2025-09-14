package dao;

import model.Cart;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public Cart getCartByUserId(int userId) {
        Cart cart = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM carts WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cart = new Cart(rs.getInt("id"), rs.getInt("user_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public Cart createCartForUser(int userId) {
        Cart cart = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO carts (user_id) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                cart = new Cart(generatedKeys.getInt(1), userId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public List<Product> getCartItems(int cartId) {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT p.*, ci.quantity FROM products p JOIN cart_items ci ON p.id = ci.product_id WHERE ci.cart_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        null // Image is not retrieved here, so pass null
                );
                // In a real application, you would also handle the quantity
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getCartItemCount(int cartId) {
        int count = 0;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT SUM(quantity) FROM cart_items WHERE cart_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public void addProductToCart(int cartId, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            // Check if the item is already in the cart
            String checkSql = "SELECT * FROM cart_items WHERE cart_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, cartId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // If it exists, update the quantity
                String updateSql = "UPDATE cart_items SET quantity = quantity + 1 WHERE cart_id = ? AND product_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, cartId);
                updateStmt.setInt(2, productId);
                updateStmt.executeUpdate();
            } else {
                // If not, insert a new row
                String insertSql = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, 1)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, cartId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeProductFromCart(int cartId, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCart(int cartId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM cart_items WHERE cart_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}