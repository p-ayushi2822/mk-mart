package dao;

import model.Product;
import java.sql.*;
import java.util.*;

public class ProductDAO {
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM products");
            while(rs.next()) {
                products.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("category_id"),
                    rs.getBytes("image")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addProduct(Product product) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO products(name, description, price, category_id, image) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId());
            stmt.setBytes(5, product.getImage());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int id) {
        Product product = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("category_id"),
                    rs.getBytes("image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
}