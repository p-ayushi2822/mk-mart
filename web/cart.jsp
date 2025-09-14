<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shopping Cart</title>
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
        .cart-table { width: 100%; border-collapse: collapse; margin-top: 2.5rem; }
        .cart-table th, .cart-table td { padding: 1.25rem; border-bottom: 1px solid var(--border); text-align: left; }
        .cart-table th { background-color: hsl(210, 31%, 91%); font-weight: 500; }
        .cart-table tr:hover { background-color: hsl(210, 31%, 98%); }
        .total-row { font-weight: bold; font-size: 1.3rem; }
        .checkout-btn { background: var(--primary); color: var(--primary-foreground); padding: 1.25rem 2.5rem; border-radius: var(--radius); text-decoration: none; display: inline-block; margin-top: 2.5rem; font-weight: 500; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 style="font-size: 2.5rem; font-weight: 700;">Shopping Cart</h1>

        <% 
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
            <p>Please <a href="login.jsp">login</a> to see your cart.</p>
        <% } else { 
            CartDAO cartDAO = new CartDAO();
            Cart cart = cartDAO.getCartByUserId(user.getId());
            if (cart == null) {
        %>
            <p>Your cart is empty.</p>
        <% } else { 
            List<Product> cartItems = cartDAO.getCartItems(cart.getId());
            if (cartItems.isEmpty()) {
        %>
            <p>Your cart is empty.</p>
        <% } else { %>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        double total = 0;
                        for (Product product : cartItems) {
                            total += product.getPrice();
                    %>
                    <tr>
                        <td><%= product.getName() %></td>
                        <td>₹<%= String.format("%.2f", product.getPrice()) %></td>
                        <td><a href="removeFromCart?id=<%= product.getId() %>" style="color: red;">Remove</a></td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td>Total</td>
                        <td>₹<%= String.format("%.2f", total) %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>

            <a href="checkout" class="checkout-btn">Proceed to Checkout</a>
        <% } } } %>
    </div>
</body>
</html>