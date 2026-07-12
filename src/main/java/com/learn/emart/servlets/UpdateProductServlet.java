package com.learn.emart.servlets;

import com.learn.emart.dao.CategoryDao;
import com.learn.emart.dao.ProductDao;
import com.learn.emart.entities.Category;
import com.learn.emart.entities.Product;
import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class UpdateProductServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // Admin Access Check
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("current-user");

        if(user == null || !user.getUserType().equals("admin")) {

            session.setAttribute("message", "Only admin can update products");

            response.sendRedirect("login.jsp");

            return;
        }


        int pid = Integer.parseInt(request.getParameter("pid"));

        String pName = request.getParameter("pName");
        String pDesc = request.getParameter("pDesc");
        int pPrice = Integer.parseInt(request.getParameter("pPrice"));
        int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
        int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
        int catId = Integer.parseInt(request.getParameter("catId"));

        Part part = request.getPart("pPic");


        ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

        Product product = pdao.getProductById(pid);


        if (product == null) {

            session.setAttribute("message", "Product not found");

            response.sendRedirect("admin.jsp");

            return;
        }


        product.setpName(pName);
        product.setpDesc(pDesc);
        product.setpPrice(pPrice);
        product.setpDiscount(pDiscount);
        product.setpQuantity(pQuantity);


        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());

        Category category = cdao.getCategoryById(catId);

        product.setCategory(category);



        // Update Image

        if (part != null && part.getSize() > 0) {


            String uploadPath = getServletContext().getRealPath("image/products");


            File folder = new File(uploadPath);


            if (!folder.exists()) {

                folder.mkdirs();

            }



            // Delete old image

            if(product.getpPhoto() != null && !product.getpPhoto().isEmpty()) {


                File oldImage = new File(
                        uploadPath + File.separator + product.getpPhoto()
                );


                if(oldImage.exists()) {

                    oldImage.delete();

                }

            }



            // Save new image

            String newImage = part.getSubmittedFileName();


            part.write(uploadPath + File.separator + newImage);


            product.setpPhoto(newImage);

        }



        boolean flag = pdao.updateProduct(product);



        if(flag) {

            session.setAttribute("message",
                    "Product Updated Successfully");

        } else {

            session.setAttribute("message",
                    "Product Update Failed");

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