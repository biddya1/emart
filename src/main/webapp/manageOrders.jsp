<%@page import="java.util.List"%>
<%@page import="com.learn.emart.entities.Orders"%>
<%@page import="com.learn.emart.entities.OrderItem"%>
<%@page import="com.learn.emart.entities.User"%>
<%@page import="com.learn.emart.dao.OrderDao"%>
<%@page import="com.learn.emart.dao.OrderItemDao"%>
<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
User user = (User) session.getAttribute("current-user");

if(user == null){
    session.setAttribute("message","You are not logged in !! Login first");
    response.sendRedirect("login.jsp");
    return;
}

if(user.getUserType().equals("normal")){
    session.setAttribute("message","You are not admin! Do not access this page");
    response.sendRedirect("login.jsp");
    return;
}

OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
List<Orders> orders = orderDao.getAllOrders();

OrderItemDao itemDao = new OrderItemDao(FactoryProvider.getFactory());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders - E-Mart Admin</title>
    <%@include file="components/common_css_js.jsp"%>

    <style>
        .order-card{
            border-radius:15px;
            transition:.25s;
        }
        .order-card:hover{
            box-shadow:0 10px 22px rgba(0,0,0,.1);
        }
        .status-select{
            width:auto;
            display:inline-block;
        }
    </style>
</head>
<body>

<%@include file="components/navbar.jsp"%>
<%@include file="components/common_modal.jsp"%>

<div class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0" style="color:#1e3a8a;">
            <i class="fa-solid fa-clipboard-list"></i> Manage Orders
        </h2>
        <a href="admin.jsp" class="btn btn-outline-secondary rounded-pill">
            <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <%@include file="components/message.jsp"%>

    <%
    if(orders == null || orders.size() == 0){
    %>
        <div class="alert alert-warning text-center">
            <h5>No orders placed yet</h5>
        </div>
    <%
    }else{
        for(Orders o : orders){

            List<OrderItem> items = itemDao.getItemsByOrderId(o.getOrderId());
            String status = o.getStatus() == null ? "Pending" : o.getStatus();
    %>

    <div class="card order-card shadow-sm mb-4 border-0">

        <div class="card-header bg-white d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <strong>Order #<%=o.getOrderId()%></strong>
                <span class="text-muted ms-2"><%=o.getOrderDate()%></span>
                <span class="badge bg-secondary ms-2">
                    <%=o.getUser().getUserName()%>
                </span>
            </div>

            <form action="UpdateOrderStatusServlet" method="post" class="d-flex align-items-center gap-2">
                <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">

                <select name="status" class="form-select form-select-sm status-select">
                    <option value="Pending" <%=status.equals("Pending")?"selected":""%>>Pending</option>
                    <option value="Confirmed" <%=status.equals("Confirmed")?"selected":""%>>Confirmed</option>
                    <option value="Shipped" <%=status.equals("Shipped")?"selected":""%>>Shipped</option>
                    <option value="Delivered" <%=status.equals("Delivered")?"selected":""%>>Delivered</option>
                    <option value="Cancelled" <%=status.equals("Cancelled")?"selected":""%>>Cancelled</option>
                </select>

                <button type="submit" class="btn btn-primary btn-sm">Update</button>
            </form>
        </div>

        <div class="card-body">

            <table class="table table-borderless mb-2">
                <thead>
                    <tr class="text-muted small text-uppercase">
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th class="text-end">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(OrderItem item : items){
                    %>
                    <tr>
                        <td><%=item.getProduct().getpName()%></td>
                        <td><%=item.getQuantity()%></td>
                        <td>₹ <%=item.getPriceAtPurchase()%></td>
                        <td class="text-end">₹ <%=item.getPriceAtPurchase() * item.getQuantity()%></td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>

        </div>

        <div class="card-footer bg-white text-end">
            <strong>Total: ₹ <%=o.getTotalAmount()%></strong>
        </div>

    </div>

    <%
        }
    }
    %>

</div>

</body>
</html>

