package servlets;

import dao.CategoryDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addCategory")
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        CategoryDAO categoryDAO = new CategoryDAO();
        boolean success = categoryDAO.addCategory(name);
        response.sendRedirect("admin.jsp?categoryAdded=" + success);
    }
}