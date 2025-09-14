package dao;

import model.User;
import java.sql.*;

public class UserDAO {

    public boolean registerUser(User user) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users(name, email, password_hash, phone, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // ⚠️ In real apps, use hashing
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getRole());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int userId = generatedKeys.getInt(1);
                    CartDAO cartDAO = new CartDAO();
                    cartDAO.createCartForUser(userId);
                    WishlistDAO wishlistDAO = new WishlistDAO();
                    wishlistDAO.createWishlistForUser(userId);
                    return true;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User validateUser(String email, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND password_hash=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password); // ⚠️ use hashed password in real apps
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password_hash"),
                    rs.getString("phone"),
                    rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
