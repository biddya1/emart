package com.learn.emart.servlets;

import com.learn.emart.dao.ProductDao;
import com.learn.emart.entities.Product;
import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");


        // Admin Access Check
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("current-user");

        if(user == null || !user.getUserType().equals("admin")) {

            session.setAttribute("message", "Only admin can delete products");

            response.sendRedirect("login.jsp");

            return;
        }


        try (PrintWriter out = response.getWriter()) {

            // Get Product ID
            int pid = Integer.parseInt(request.getParameter("pid"));

            ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

            // Find Product
            Product product = pdao.getProductById(pid);


            if (product != null) {

                // Delete Product Image
                try {

                    String imagePath = getServletContext().getRealPath("image/products")
                            + File.separator + product.getpPhoto();

                    File file = new File(imagePath);

                    if (file.exists()) {
                        file.delete();
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }


                // Delete Product from Database
                boolean flag = pdao.deleteProduct(product);


                if (flag) {

                    session.setAttribute("message",
                            "Product deleted successfully.");

                } else {

                    session.setAttribute("message",
                            "Could not delete product.");

                }


            } else {

                session.setAttribute("message",
                        "Product not found.");

            }


            response.sendRedirect("admin.jsp");

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

        return "Delete Product Servlet";

    }
}