import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/ecommerce?useSSL=false&serverTimezone=UTC";
        String user = "root"; // Replace with your MySQL username
        String password = "mysql"; // Replace with your MySQL password
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load driver explicitly
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");
            conn.close();
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
    }
}