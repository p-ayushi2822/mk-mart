package servlets;

import dao.CartDAO;
import dao.OrderDAO;
import model.Cart;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?message=Please login to checkout.");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO();

        Cart cart = cartDAO.getCartByUserId(user.getId());

        if (cart == null) {
            response.sendRedirect("cart.jsp?message=Your cart is empty.");
            return;
        }

        List<Product> cartItems = cartDAO.getCartItems(cart.getId());

        if (cartItems.isEmpty()) {
            response.sendRedirect("cart.jsp?message=Your cart is empty.");
            return;
        }

        double totalAmount = 0;
        for (Product item : cartItems) {
            totalAmount += item.getPrice();
        }

        // Create the order
        int orderId = orderDAO.createOrder(user.getId(), totalAmount);

        if (orderId != -1) {
            // Add order items
            for (Product item : cartItems) {
                orderDAO.addOrderItem(orderId, item.getId(), 1, item.getPrice()); // Assuming quantity 1 for now
            }
            // Clear the cart
            cartDAO.clearCart(cart.getId());
            response.sendRedirect("myOrders.jsp?orderPlaced=true");
        } else {
            response.sendRedirect("cart.jsp?message=Failed to place order. Please try again.");
        }
    }
}
