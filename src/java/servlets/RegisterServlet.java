package servlets;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data from register.jsp
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        System.out.println("RegisterServlet: Retrieved name: " + name); // Debug print

        // Create User object
        User user = new User(0, name, email, password, phone, role);

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.registerUser(user);

        if (success) {
            // Redirect to login page after successful registration
            response.sendRedirect("login.jsp?msg=registered");
        } else {
            // Redirect back to register page with error
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
