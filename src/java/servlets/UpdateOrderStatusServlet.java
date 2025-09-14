package servlets;

import dao.OrderDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateOrderStatus")
public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.updateOrderStatus(orderId, status);

        if (success) {
            response.sendRedirect("admin.jsp?orderUpdate=success");
        } else {
            response.sendRedirect("admin.jsp?orderUpdate=fail");
        }
    }
}