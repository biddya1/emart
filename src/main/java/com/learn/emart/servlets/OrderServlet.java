package com.learn.emart.servlets;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.learn.emart.dao.OrderDao;
import com.learn.emart.dao.OrderItemDao;
import com.learn.emart.dao.ProductDao;
import com.learn.emart.entities.OrderItem;
import com.learn.emart.entities.Orders;
import com.learn.emart.entities.Product;
import com.learn.emart.entities.User;
import com.mycompany.e.mart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("current-user");

            if (user == null) {
                out.print("Please login first");
                return;
            }

            String cartJson = request.getParameter("cart");

            if (cartJson == null || cartJson.trim().isEmpty()) {
                out.print("Cart is empty");
                return;
            }

            Gson gson = new Gson();
            Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
            List<Map<String, Object>> cart = gson.fromJson(cartJson, listType);

            ProductDao productDao = new ProductDao(FactoryProvider.getFactory());

            // Validate stock before placing order
            for (Map<String, Object> item : cart) {
                int productId = ((Number) item.get("productId")).intValue();
                int qty = ((Number) item.get("productQuantity")).intValue();

                Product product = productDao.getProductById(productId);

                if (product == null) {
                    out.print("One of the products no longer exists");
                    return;
                }

                if (qty > product.getpQuantity()) {
                    out.print("Only " + product.getpQuantity() + " unit(s) of '" + product.getpName() + "' available");
                    return;
                }
            }

            // Calculate total
            double total = 0;
            for (Map<String, Object> item : cart) {
                double price = ((Number) item.get("productPrice")).doubleValue();
                int qty = ((Number) item.get("productQuantity")).intValue();
                total += price * qty;
            }

            // Create Order
            Orders order = new Orders();
            order.setUser(user);
            order.setTotalAmount(total);
            order.setOrderDate(new Date());
            order.setStatus("Pending");

            OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
            boolean saved = orderDao.saveOrder(order);

            if (!saved) {
                out.print("Order could not be placed");
                return;
            }

            // Save each OrderItem + reduce product stock
            OrderItemDao itemDao = new OrderItemDao(FactoryProvider.getFactory());

            for (Map<String, Object> item : cart) {
                int productId = ((Number) item.get("productId")).intValue();
                int qty = ((Number) item.get("productQuantity")).intValue();
                double price = ((Number) item.get("productPrice")).doubleValue();

                Product product = productDao.getProductById(productId);

                OrderItem orderItem = new OrderItem(order, product, qty, price);
                itemDao.saveOrderItem(orderItem);

                // Reduce stock
                product.setpQuantity(product.getpQuantity() - qty);
                productDao.updateProduct(product);
            }

            out.print("Order placed successfully");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("Something went wrong");
        }
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
