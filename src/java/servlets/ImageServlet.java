package servlets;

import dao.ProductDAO;
import model.Product;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/productImage")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product != null && product.getImage() != null) {
            response.setContentType("image/jpeg"); // Or image/png, depending on your image type
            response.setContentLength(product.getImage().length);
            response.getOutputStream().write(product.getImage());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
