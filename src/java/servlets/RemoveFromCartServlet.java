package servlets;

import dao.CartDAO;
import model.Cart;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/removeFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));

        CartDAO cartDAO = new CartDAO();
        Cart cart = cartDAO.getCartByUserId(user.getId());

        if (cart != null) {
            cartDAO.removeProductFromCart(cart.getId(), productId);
        }

        response.sendRedirect("cart.jsp");
    }
}
