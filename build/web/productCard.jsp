<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String price = request.getParameter("price");
    boolean isInWishlist = Boolean.parseBoolean(request.getParameter("isInWishlist"));
%>

<div style="background: #fff; border:1px solid #eee; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); overflow: hidden; transition: transform 0.3s ease; cursor:pointer; display: flex; flex-direction: column; height: 100%;">
    <img src="productImage?id=<%= id %>" alt="<%= name %>" style="width: 100%; height: 220px; object-fit: cover;">
    
    <div style="padding: 1.25rem; display: flex; flex-direction: column; flex-grow: 1;">
        <h3 style="font-weight:600; font-size:1.2rem; margin: 0.75rem 0;"><%= name %></h3>

        <p style="color: #666; font-size: 1rem; min-height: 60px; flex-grow: 1;"><%= description %></p>

        <div style="margin:0.75rem 0;">
            <span style="font-size:1.4rem; font-weight:bold; color:#3b82f6;">₹<%= price %></span>
        </div>

        <div style="display: flex; gap: 0.75rem; margin-top: auto;">
            <a href="addToCart?id=<%= id %>" style="flex-grow: 1; background:#3b82f6; color:#fff; padding:0.75rem; border-radius:8px; text-align:center; text-decoration:none; font-weight:bold;">
                🛒 Add to Cart
            </a>
            <a href="addToWishlist?id=<%= id %>" style="background: #eee; color: <%= isInWishlist ? "red" : "#333" %>; padding: 0.75rem 1.25rem; border-radius: 8px; text-align: center; text-decoration: none; font-weight: bold;">
                <i class="fas fa-heart"></i>
            </a>
        </div>
    </div>
</div>