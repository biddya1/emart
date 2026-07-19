package com.learn.emart.servlets;

import com.learn.emart.dao.OrderDao;
import com.learn.emart.entities.Orders;
import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateOrderStatusServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("current-user");

        if (user == null || !user.getUserType().equals("admin")) {
            session.setAttribute("message", "You are not authorized to perform this action");
            response.sendRedirect("login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
        Orders order = orderDao.getOrderById(orderId);

        if (order != null) {
            order.setStatus(newStatus);
            orderDao.updateOrder(order);
            session.setAttribute("message", "Order #" + orderId + " status updated to " + newStatus);
        } else {
            session.setAttribute("message", "Order not found");
        }

        response.sendRedirect("manageOrders.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}