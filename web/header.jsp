<%@ page import="model.User" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.Cart" %>
<% User currentUser = (User) session.getAttribute("user"); %>
<header style="position: sticky; top: 0; z-index: 50; width: 100%; background: #fff; border-bottom: 1px solid #ddd; backdrop-filter: blur(10px);">
  <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; height: 72px; padding: 0 1.5rem;">
    
    <h1 style="font-size: 1.75rem; font-weight: bold; background: linear-gradient(135deg, #3b82f6, #60a5fa); -webkit-background-clip: text; color: transparent;">
        MK Mart
    </h1>

    <% boolean isAdmin = (currentUser != null && "admin".equals(currentUser.getRole())); %>
    <% if (!isAdmin) { %>
    <nav style="display: flex; gap: 2rem;">
      <a href="index.jsp" style="text-decoration: none; color: #333; font-weight: 500;">Home</a>
      <a href="index.jsp#products" style="text-decoration: none; color: #333; font-weight: 500;">Products</a>
      <a href="about.jsp" style="text-decoration: none; color: #333; font-weight: 500;">About</a>
      <a href="contact.jsp" style="text-decoration: none; color: #333; font-weight: 500;">Contact</a>
      <a href="myOrders.jsp" style="text-decoration: none; color: #333; font-weight: 500;">My Orders</a>
    </nav>
    <% } else { %>
        <div></div>
    <% } %>

    <div style="display: flex; align-items: center; gap: 1.5rem; font-size:22px;">
        <% if (currentUser != null) { %>
            <a href="logout" title="Logout" style="display: flex; align-items: center; justify-content: center; width: 44px; height: 44px; border-radius: 50%; border: 1px solid #ddd; color: #333; text-decoration: none;"><i class="fas fa-sign-out-alt"></i></a>
        <% } else { %>
            <a href="login.jsp" title="Login" style="display: flex; align-items: center; justify-content: center; width: 44px; height: 44px; border-radius: 50%; border: 1px solid #ddd; color: #333; text-decoration: none;"><i class="fas fa-user"></i></a>
        <% } %>
      <a href="wishlist.jsp" title="Wishlist" style="color:#333;"><i class="fas fa-heart"></i></a>
      <a href="cart.jsp" title="Cart" style="position: relative; color:#333;">
        <i class="fas fa-shopping-cart"></i>
        <span style="position:absolute; top:-8px; right:-12px; background:#3b82f6; color:#fff; border-radius:50%; font-size: 13px; padding:3px 7px;">
          <% 
            int cartItemCount = 0;
            if (currentUser != null) {
                CartDAO cartDAO = new CartDAO();
                Cart userCart = cartDAO.getCartByUserId(currentUser.getId());
                if (userCart != null) {
                    cartItemCount = cartDAO.getCartItemCount(userCart.getId());
                }
            }
            out.print(cartItemCount);
          %>
        </span>
      </a>
    </div>

  </div>
</header>