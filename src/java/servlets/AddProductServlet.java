package servlets;

import dao.ProductDAO;
import model.Product;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/addProduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));

        byte[] imageBytes = null;
        try {
            Part filePart = request.getPart("image");
            if (filePart != null) {
                InputStream inputStream = filePart.getInputStream();
                imageBytes = new byte[inputStream.available()];
                inputStream.read(imageBytes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Create Product object (id is 0 because it's auto-incremented in the DB)
        Product product = new Product(0, name, description, price, categoryId, imageBytes);

        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.addProduct(product);

        if (success) {
            // Redirect back to admin page with a success message
            response.sendRedirect("admin.jsp?productAdded=true");
        } else {
            // Redirect back to admin page with an error message
            response.sendRedirect("admin.jsp?productAdded=false");
        }
    }
}
