package com.learn.emart.servlets;

import com.learn.emart.dao.CategoryDao;
import com.learn.emart.dao.ProductDao;
import com.learn.emart.entities.Category;
import com.learn.emart.entities.Product;
import com.mycompany.e.mart.helper.FactoryProvider;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {

                String title = request.getParameter("categoryTitle");
                String description = request.getParameter("categoryDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());

                int categoryId = categoryDao.saveCategory(category);

                out.println("Category Saved");

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message",
                        "Category added successfully : " + categoryId);

                response.sendRedirect("admin.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {

                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));

                Part part = request.getPart("pPic");

                System.out.println("File Name = " + part.getSubmittedFileName());
                System.out.println("File Size = " + part.getSize());

                Product p = new Product();

                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);
                p.setpPhoto(part.getSubmittedFileName());

                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
Category category = cdao.getCategoryById(catId);

System.out.println("catId = " + catId);
System.out.println("category = " + category);

p.setCategory(category);


                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

                boolean flag = pdao.saveProduct(p);

                // Upload Product Image
                try {

                    // ************ ONLY THIS LINE CHANGED ************
                    String uploadPath = "C:\\Users\\Dell\\Documents\\NetBeansProjects\\E-Mart\\src\\main\\webapp\\image\\products";
                    // ***********************************************

                    File uploadDir = new File(uploadPath);

                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + part.getSubmittedFileName();

                    System.out.println("Upload Path : " + filePath);
                    System.out.println("File Name : " + part.getSubmittedFileName());
                    System.out.println("File Size : " + part.getSize());

                    part.write(filePath);

                    System.out.println("Image Uploaded Successfully");

                } catch (Exception e) {
                    e.printStackTrace();
                }

                HttpSession httpSession = request.getSession();

                if (flag) {

                    httpSession.setAttribute("message",
                            "Product added successfully");

                } else {

                    httpSession.setAttribute("message",
                            "Product could not be added");
                }

                response.sendRedirect("admin.jsp");
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
        return "Short description";
    }
}