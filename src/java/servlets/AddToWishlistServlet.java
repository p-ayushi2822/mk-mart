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

@WebServlet("/addToWishlist")
public class AddToWishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?message=Please login to add items to your wishlist.");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));

        WishlistDAO wishlistDAO = new WishlistDAO();
        Wishlist wishlist = wishlistDAO.getWishlistByUserId(user.getId());

        if (wishlist == null) {
            wishlist = wishlistDAO.createWishlistForUser(user.getId());
        }

        if (wishlist != null) {
            if (wishlistDAO.isProductInWishlist(wishlist.getId(), productId)) {
                wishlistDAO.removeProductFromWishlist(wishlist.getId(), productId);
            } else {
                wishlistDAO.addProductToWishlist(wishlist.getId(), productId);
            }
        }

        // Redirect back to the page where the request came from, or a default page
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("index.jsp"); // Default redirect
        }
    }
}