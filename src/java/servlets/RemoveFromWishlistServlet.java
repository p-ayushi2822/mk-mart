package servlets;

import dao.WishlistDAO;
import model.User;
import model.Wishlist;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/removeFromWishlist")
public class RemoveFromWishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));

        WishlistDAO wishlistDAO = new WishlistDAO();
        Wishlist wishlist = wishlistDAO.getWishlistByUserId(user.getId());

        if (wishlist != null) {
            wishlistDAO.removeProductFromWishlist(wishlist.getId(), productId);
        }

        response.sendRedirect("wishlist.jsp");
    }
}
