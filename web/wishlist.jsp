<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<%@ page import="dao.WishlistDAO" %>
<%@ page import="model.Wishlist" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Wishlist</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --background: hsl(210, 36%, 96%);
            --foreground: hsl(222, 47%, 11%);
            --card: hsl(0, 0%, 100%);
            --card-foreground: hsl(222, 47%, 11%);
            --primary: hsl(205, 78%, 60%);
            --primary-foreground: hsl(0, 0%, 98%);
            --border: hsl(210, 31%, 91%);
            --radius: 1rem;
        }
        body {
            background-color: var(--background);
            color: var(--foreground);
            font-family: 'Roboto', sans-serif;
            margin: 0;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 3rem 1.5rem; }
        .wishlist-table { width: 100%; border-collapse: collapse; margin-top: 2.5rem; }
        .wishlist-table th, .wishlist-table td { padding: 1.25rem; border-bottom: 1px solid var(--border); text-align: left; }
        .wishlist-table th { background-color: hsl(210, 31%, 91%); font-weight: 500; }
        .wishlist-table tr:hover { background-color: hsl(210, 31%, 98%); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 style="font-size: 2.5rem; font-weight: 700;">My Wishlist</h1>

        <% 
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
            <p>Please <a href="login.jsp">login</a> to see your wishlist.</p>
        <% } else { 
            WishlistDAO wishlistDAO = new WishlistDAO();
            Wishlist wishlist = wishlistDAO.getWishlistByUserId(user.getId());
            if (wishlist == null) {
        %>
            <p>Your wishlist is empty.</p>
        <% } else { 
            List<Product> wishlistItems = wishlistDAO.getWishlistItems(wishlist.getId());
            if (wishlistItems.isEmpty()) {
        %>
            <p>Your wishlist is empty.</p>
        <% } else { %>
            <table class="wishlist-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Action</th>
                        <th>Add to Cart</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        for (Product product : wishlistItems) {
                    %>
                    <tr>
                        <td><%= product.getName() %></td>
                        <td>₹<%= String.format("%.2f", product.getPrice()) %></td>
                        <td><a href="removeFromWishlist?id=<%= product.getId() %>" style="color: red;">Remove</a></td>
                        <td><a href="addToCart?id=<%= product.getId() %>" style="background: #3b82f6; color: #fff; padding: 0.75rem 1.5rem; border-radius: 8px; text-decoration: none;">Add to Cart</a></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } } } %>
    </div>
</body>
</html>