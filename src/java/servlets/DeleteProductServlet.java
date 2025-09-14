package servlets;

import dao.ProductDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.deleteProduct(productId);

        if (success) {
            response.sendRedirect("admin.jsp?productDeleted=true");
        } else {
            response.sendRedirect("admin.jsp?productDeleted=false");
        }
    }
}
