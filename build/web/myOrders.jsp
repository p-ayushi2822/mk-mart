<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.User" %>
<%@ page import="dao.OrderDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Orders</title>
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
        .orders-table { width: 100%; border-collapse: collapse; margin-top: 2.5rem; }
        .orders-table th, .orders-table td { padding: 1.25rem; border-bottom: 1px solid var(--border); text-align: left; }
        .orders-table th { background-color: hsl(210, 31%, 91%); font-weight: 500; }
        .orders-table tr:hover { background-color: hsl(210, 31%, 98%); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 style="font-size: 2.5rem; font-weight: 700;">My Orders</h1>

        <% 
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
            <p>Please <a href="login.jsp">login</a> to see your orders.</p>
        <% } else { 
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getUserOrders(user.getId());
            if (orders.isEmpty()) {
        %>
            <p>You have no orders yet.</p>
        <% } else { %>
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        for (Order order : orders) {
                    %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(order.getOrderDate()) %></td>
                        <td>₹<%= String.format("%.2f", order.getTotalAmount()) %></td>
                        <td><%= order.getStatus() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } } %>
    </div>
</body>
</html>