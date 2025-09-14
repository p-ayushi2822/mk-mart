<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page import="model.Category" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="model.Order" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    // Protect this page from non-admin users
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get data for the page
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Elite Store</title>
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
            --primary-glow: hsl(205, 78%, 70%);
            --secondary: hsl(210, 31%, 91%);
            --secondary-foreground: hsl(222, 47%, 11%);
            --muted: hsl(210, 31%, 91%);
            --muted-foreground: hsl(215, 16%, 47%);
            --accent: hsl(205, 78%, 60%);
            --accent-foreground: hsl(0, 0%, 98%);
            --border: hsl(210, 31%, 91%);
            --input: hsl(210, 31%, 91%);
            --ring: hsl(205, 78%, 60%);
            --radius: 1rem;
            --gradient-primary: linear-gradient(135deg, hsl(205, 78%, 60%), hsl(205, 78%, 70%));
            --gradient-hero: linear-gradient(135deg, hsl(205, 78%, 60%), hsl(261, 83%, 58%));
            --gradient-subtle: linear-gradient(180deg, hsl(0, 0%, 100%), hsl(210, 31%, 98%));
            --shadow-soft: 0 2px 8px -2px hsl(205, 78%, 60%, 0.08);
            --shadow-medium: 0 4px 20px -4px hsl(205, 78%, 60%, 0.15);
            --shadow-strong: 0 10px 40px -10px hsl(205, 78%, 60%, 0.25);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            background-color: var(--background);
            color: var(--foreground);
            font-family: 'Roboto', sans-serif;
            margin: 0;
        }

        .container { max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; }
        .bg-gradient-subtle { background: var(--gradient-subtle); }
        .py-20 { padding-top: 6rem; padding-bottom: 6rem; }
        .text-center { text-align: center; }
        .mb-16 { margin-bottom: 4.5rem; }
        .text-3xl { font-size: 2rem; line-height: 2.5rem; }
        .font-bold { font-weight: 700; }
        .mb-4 { margin-bottom: 1.25rem; }
        .text-xl { font-size: 1.3rem; line-height: 1.8rem; }
        .text-muted-foreground { color: var(--muted-foreground); }
        .max-w-2xl { max-width: 45rem; }
        .mx-auto { margin-left: auto; margin-right: auto; }

        .grid { display: grid; }
        .grid-cols-1 { grid-template-columns: 1fr; }
        .gap-8 { gap: 2.5rem; }

        .bg-primary { background-color: var(--primary); }
        .rounded-3xl { border-radius: 2rem; }
        .p-12 { padding: 3.5rem; }
        .text-primary-foreground { color: var(--primary-foreground); }
        .opacity-90 { opacity: 0.9; }
        .mb-8 { margin-bottom: 2.5rem; }

        .bg-card { background-color: var(--card); }
        .text-2xl { font-size: 1.5rem; line-height: 2rem; }

        table tr:hover { background-color: hsl(210, 31%, 98%); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container py-20">
        <h1 class="text-3xl font-bold mb-16">Admin Dashboard</h1>

        <!-- Manage Categories -->
        <div class="bg-card p-12 rounded-3xl" style="background: #fff; border: 1px solid var(--border); box-shadow: var(--shadow-soft); margin-bottom: 2rem;">
            <h2 class="text-2xl font-bold mb-4">Manage Categories</h2>
            <form action="addCategory" method="post" style="margin-bottom: 2rem;">
                <input type="text" name="name" placeholder="Category Name" required style="padding: 1rem; border: 1px solid var(--input); border-radius: var(--radius); margin-right: 1rem;">
                <button type="submit" style="background: var(--primary); color: var(--primary-foreground); padding: 1rem 2rem; border: none; border-radius: var(--radius); cursor: pointer;">Add Category</button>
            </form>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="border-bottom: 1px solid var(--border);">
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">ID</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Name</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Category category : categories) { %>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1.25rem;"><%= category.getId() %></td>
                                <td style="padding: 1.25rem;"><%= category.getName() %></td>
                                <td style="padding: 1.25rem;">
                                    <a href="deleteCategory?id=<%= category.getId() %>" style="color: red; text-decoration: none;">Delete</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Manage Products -->
        <div class="bg-card p-12 rounded-3xl" style="background: #fff; border: 1px solid var(--border); box-shadow: var(--shadow-soft); margin-bottom: 2rem;">
            <h2 class="text-2xl font-bold mb-4">Manage Products</h2>
            <form action="addProduct" method="post" enctype="multipart/form-data" style="margin-bottom: 2rem;">
                <input type="text" name="name" placeholder="Product Name" required style="padding: 1rem; border: 1px solid var(--input); border-radius: var(--radius); margin-right: 1rem; margin-bottom: 1rem;">
                <input type="number" name="price" placeholder="Price" required style="padding: 1rem; border: 1px solid var(--input); border-radius: var(--radius); margin-right: 1rem; margin-bottom: 1rem;">
                <textarea name="description" placeholder="Description" required style="padding: 1rem; border: 1px solid var(--input); border-radius: var(--radius); margin-right: 1rem; margin-bottom: 1rem; width: 100%; min-height: 100px;"></textarea>
                <select name="categoryId" required style="padding: 1rem; border: 1px solid var(--input); border-radius: var(--radius); margin-right: 1rem; margin-bottom: 1rem;">
                    <% for (Category category : categories) { %>
                        <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <% } %>
                </select>
                <input type="file" name="image" required style="margin-bottom: 1rem;">
                <button type="submit" style="background: var(--primary); color: var(--primary-foreground); padding: 1rem 2rem; border: none; border-radius: var(--radius); cursor: pointer;">Add Product</button>
            </form>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="border-bottom: 1px solid var(--border);">
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">ID</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Name</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Price</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product product : products) { %>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1.25rem;"><%= product.getId() %></td>
                                <td style="padding: 1.25rem;"><%= product.getName() %></td>
                                <td style="padding: 1.25rem;">₹<%= String.format("%.2f", product.getPrice()) %></td>
                                <td style="padding: 1.25rem;">
                                    <a href="deleteProduct?id=<%= product.getId() %>" style="color: red; text-decoration: none;">Delete</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- All Orders Table -->
        <div class="bg-card p-12 rounded-3xl" style="background: #fff; border: 1px solid var(--border); box-shadow: var(--shadow-soft);">
            <h2 class="text-2xl font-bold mb-4">All Orders</h2>
            <div style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="border-bottom: 1px solid var(--border);">
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Order ID</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Customer</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Date</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Total</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Status</th>
                            <th style="padding: 1.25rem; text-align: left; font-weight: 600;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orders) { %>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1.25rem;"><%= order.getId() %></td>
                                <td style="padding: 1.25rem;"><%= order.getCustomerName() %></td>
                                <td style="padding: 1.25rem; color: var(--muted-foreground);"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(order.getOrderDate()) %></td>
                                <td style="padding: 1.25rem; font-weight: 600;">₹<%= String.format("%.2f", order.getTotalAmount()) %></td>
                                <td style="padding: 1.25rem;"><%= order.getStatus() %></td>
                                <td style="padding: 1.25rem;">
                                    <% if ("Pending".equals(order.getStatus())) { %>
                                        <form action="updateOrderStatus" method="post" style="display: inline-block;">
                                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                            <input type="hidden" name="status" value="Confirmed">
                                            <button type="submit" style="background-color: #4CAF50; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 6px; cursor: pointer;">Confirm</button>
                                        </form>
                                        <form action="updateOrderStatus" method="post" style="display: inline-block; margin-left: 0.75rem;">
                                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                            <input type="hidden" name="status" value="Rejected">
                                            <button type="submit" style="background-color: #f44336; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 6px; cursor: pointer;">Reject</button>
                                        </form>
                                    <% } else { %>
                                        <span style="color: gray;">No actions</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>