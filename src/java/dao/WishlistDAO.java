package dao;

import model.Product;
import model.Wishlist;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public Wishlist getWishlistByUserId(int userId) {
        Wishlist wishlist = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM wishlists WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                wishlist = new Wishlist(rs.getInt("id"), rs.getInt("user_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishlist;
    }

    public Wishlist createWishlistForUser(int userId) {
        Wishlist wishlist = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO wishlists (user_id) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                wishlist = new Wishlist(generatedKeys.getInt(1), userId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishlist;
    }

    public List<Product> getWishlistItems(int wishlistId) {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT p.* FROM products p JOIN wishlist_items wi ON p.id = wi.product_id WHERE wi.wishlist_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, wishlistId);
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
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public void addProductToWishlist(int wishlistId, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT * FROM wishlist_items WHERE wishlist_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, wishlistId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                String insertSql = "INSERT INTO wishlist_items (wishlist_id, product_id) VALUES (?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, wishlistId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeProductFromWishlist(int wishlistId, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM wishlist_items WHERE wishlist_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, wishlistId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isProductInWishlist(int wishlistId, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM wishlist_items WHERE wishlist_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, wishlistId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
