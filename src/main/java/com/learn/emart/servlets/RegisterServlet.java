package com.learn.emart.servlets;

import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            try {

                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");

                if (userName == null || userName.trim().isEmpty()) {
                    out.println("Name is blank");
                    return;
                }

                User user = new User(
                        userName,
                        userEmail,
                        userPassword,
                        userPhone,
                        "default.jpg",
                        userAddress,
                        "normal"
                );

                Session hibernateSession = FactoryProvider.getFactory().openSession();

                Transaction tx = hibernateSession.beginTransaction();

                int userId = (int) hibernateSession.save(user);

                tx.commit();
                hibernateSession.close();

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message",
                        "Registration Successful!! User ID is " + userId);

                response.sendRedirect("register.jsp");
                return;

            } catch (Exception e) {

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message",
                        "Email already registered! Please use another email.");

                response.sendRedirect("register.jsp");
                return;
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Register Servlet";
    }
}