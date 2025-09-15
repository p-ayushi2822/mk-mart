<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, model.Product, java.util.List, java.util.ArrayList, model.User, dao.WishlistDAO, model.Wishlist" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <title>MK Mart</title>
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

        .flex { display: flex; }
        .flex-col { flex-direction: column; }
        .gap-4 { gap: 1.25rem; }
        .max-w-md { max-width: 30rem; }

        input {
            border: 1px solid var(--input);
            border-radius: var(--radius);
            padding: 1rem 1.25rem;
            color: var(--foreground);
            flex: 1;
        }

        button {
            background-color: #ffffff;
            color: var(--primary);
            border-radius: var(--radius);
            padding: 1rem 1.75rem;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: var(--transition-smooth);
        }

        button:hover { background-color: #f5f5f5; }

        .border-t { border-top: 1px solid var(--border); }
        .bg-muted-30 { background-color: hsl(210, 31%, 91%, 0.3); }
        .py-12 { padding-top: 3rem; padding-bottom: 3rem; }
        .md-grid-cols-4 { grid-template-columns: repeat(4, minmax(0, 1fr)); }
        .space-y-2 { row-gap: 0.5rem; }
        .bg-gradient-primary { background: var(--gradient-primary); }
        .bg-clip-text { background-clip: text; -webkit-background-clip: text; }
        .text-transparent { color: transparent; }

        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 2rem; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="bg-gradient-subtle">
        <%@ include file="hero.jsp" %>

        <section class="py-20" id="products">
            <div class="container">
                <div class="text-center mb-16">
                    <h2 class="text-3xl font-bold mb-4">Our Products</h2>
                    <p class="text-xl text-muted-foreground max-w-2xl mx-auto">
                        Discover our collection of premium tech products
                    </p>
                </div>

                <div class="product-grid">
                    <% 
                        User user = (User) session.getAttribute("user");
                        ProductDAO productDAO = new ProductDAO();
                        List<Product> products = productDAO.getAllProducts();
                        WishlistDAO wishlistDAO = new WishlistDAO();
                        int userId = (user != null) ? user.getId() : -1;
                        Wishlist wishlist = wishlistDAO.getWishlistByUserId(userId);
                        for (Product product : products) {
                            boolean isInWishlist = wishlistDAO.isProductInWishlist(wishlist != null ? wishlist.getId() : -1, product.getId());
                    %>
                        <jsp:include page="productCard.jsp">
                            <jsp:param name="id" value="<%= product.getId() %>" />
                            <jsp:param name="name" value="<%= product.getName() %>" />
                            <jsp:param name="description" value="<%= product.getDescription() %>" />
                            <jsp:param name="price" value="<%= product.getPrice() %>" />
                            <jsp:param name="isInWishlist" value="<%= String.valueOf(isInWishlist) %>" />
                        </jsp:include>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

        <section class="py-20">
            <div class="container">
                <div class="bg-primary rounded-3xl p-12 text-center text-primary-foreground">
                    <h3 class="text-3xl font-bold mb-4">Stay Updated</h3>
                    <p class="text-xl mb-8 opacity-90">
                        Get the latest updates on new products and exclusive offers
                    </p>
                    <div class="flex flex-col sm-flex-row gap-4 max-w-md mx-auto">
                        <input type="email" placeholder="Enter your email" />
                        <button>Subscribe</button>
                    </div>
                </div>
            </div>
        </section>

        <footer class="border-t bg-muted-30 py-12">
            <div class="container">
                <div class="grid grid-cols-1 md-grid-cols-4 gap-8">
                    <div>
                        <h4 class="text-2xl font-bold bg-gradient-primary bg-clip-text text-transparent mb-4">
                            Mk mart
                        </h4>
                        <p class="text-muted-foreground">
                            Premium technology products for the modern lifestyle.
                        </p>
                    </div>
                    <div>
                        <h5 class="font-semibold mb-4">Products</h5>
                        <ul class="space-y-2 text-muted-foreground">
                            <li><a href="#">Electronics</a></li>
                            <li><a href="#">Accessories</a></li>
                            <li><a href="#">Smart Home</a></li>
                        </ul>
                    </div>
                    <div>
                        <h5 class="font-semibold mb-4">Support</h5>
                        <ul class="space-y-2 text-muted-foreground">
                            <li><a href="#">Help Center</a></li>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">Returns</a></li>
                        </ul>
                    </div>
                    <div>
                        <h5 class="font-semibold mb-4">Company</h5>
                        <ul class="space-y-2 text-muted-foreground">
                            <li><a href="#">About</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Privacy</a></li>
                        </ul>
                    </div>
                </div>
                <div class="border-t mt-8 pt-8 text-center text-muted-foreground">
                    <p>&copy; 2025 Mk mart. All rights reserved.</p>
                </div>
            </div>
        </footer>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const productsLink = document.querySelector('a[href="index.jsp#products"]');
            if (productsLink) {
                productsLink.addEventListener('click', function(e) {
                    e.preventDefault();

                    const targetId = this.getAttribute('href').split('#')[1];
                    const targetElement = document.getElementById(targetId);

                    if (targetElement) {
                        targetElement.scrollIntoView({
                            behavior: 'smooth'
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>
