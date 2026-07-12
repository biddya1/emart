package com.learn.emart.servlets;

import com.learn.emart.dao.CategoryDao;
import com.learn.emart.entities.Category;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get category id from URL
        String cidParam = request.getParameter("cid");

        // Check if parameter exists
        if (cidParam == null || cidParam.trim().isEmpty()) {

            HttpSession session = request.getSession();
            session.setAttribute("message", "Invalid Category ID");

            response.sendRedirect("admin.jsp");
            return;
        }

        int cid = Integer.parseInt(cidParam);

        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());

        Category category = cdao.getCategoryById(cid);

        HttpSession session = request.getSession();

        if (category != null) {

            boolean flag = cdao.deleteCategory(category);

            if (flag) {
                session.setAttribute("message", "Category deleted successfully");
            } else {
                session.setAttribute("message", "Category could not be deleted");
            }

        } else {

            session.setAttribute("message", "Category not found");

        }

        response.sendRedirect("admin.jsp");
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
}