package com.learn.emart.servlets;

import com.learn.emart.dao.UserDao;
import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // Get data from login form
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");

            // Authenticate user
            UserDao userDao = new UserDao(FactoryProvider.getFactory());

            User user = userDao.getUserByEmailAndPassword(email, password);

            HttpSession httpSession = request.getSession();

            if (user == null) {

                httpSession.setAttribute("message",
                        "Invalid Email or Password!");

                response.sendRedirect("login.jsp");
                return;

            } else {

                // Save logged-in user in session
                httpSession.setAttribute("current-user", user);

                // Check user type
                if (user.getUserType().equals("admin")) {

                    response.sendRedirect("admin.jsp");

                } else if (user.getUserType().equals("normal")) {

                    response.sendRedirect("normal.jsp");

                } else {

                    httpSession.setAttribute("message",
                            "Unknown User Type!");

                    response.sendRedirect("login.jsp");
                }
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
        return "Login Servlet";
    }
}