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

OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
List<Orders> orders = orderDao.getOrdersByUser(user.getUserId());

OrderItemDao itemDao = new OrderItemDao(FactoryProvider.getFactory());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - E-Mart</title>
    <%@include file="components/common_css_js.jsp"%>

    <style>
        .order-card{
            border-radius:15px;
            transition:.25s;
        }
        .order-card:hover{
            box-shadow:0 10px 22px rgba(0,0,0,.1);
        }
        .status-badge{
            padding:6px 14px;
            border-radius:20px;
            font-size:13px;
            font-weight:600;
        }
        .status-pending{ background:#fff4e0; color:#b45309; }
        .status-confirmed{ background:#e6f0ff; color:#1e3a8a; }
        .status-shipped{ background:#e6f7ee; color:#0f766e; }
        .status-delivered{ background:#e8f9e8; color:#166534; }
        .status-cancelled{ background:#fde8e8; color:#b91c1c; }
    </style>
</head>
<body>

<%@include file="components/navbar.jsp"%>
<%@include file="components/common_modal.jsp"%>

<div class="container my-5">

    <h2 class="fw-bold mb-4" style="color:#1e3a8a;">
        <i class="fa-solid fa-box-open"></i> My Orders
    </h2>

    <%
    if(orders == null || orders.size() == 0){
    %>
        <div class="alert alert-warning text-center">
            <h5>No orders yet</h5>
            <p class="mb-0">Looks like you haven't placed any orders. Start shopping now!</p>
            <a href="index.jsp" class="btn custom-bg text-white mt-2">Shop Now</a>
        </div>
    <%
    }else{
        for(Orders o : orders){

            List<OrderItem> items = itemDao.getItemsByOrderId(o.getOrderId());

            String statusClass = "status-pending";
            String status = o.getStatus() == null ? "Pending" : o.getStatus();

            if(status.equalsIgnoreCase("Confirmed")) statusClass = "status-confirmed";
            else if(status.equalsIgnoreCase("Shipped")) statusClass = "status-shipped";
            else if(status.equalsIgnoreCase("Delivered")) statusClass = "status-delivered";
            else if(status.equalsIgnoreCase("Cancelled")) statusClass = "status-cancelled";
    %>

    <div class="card order-card shadow-sm mb-4 border-0">

        <div class="card-header bg-white d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <strong>Order #<%=o.getOrderId()%></strong>
                <span class="text-muted ms-2"><%=o.getOrderDate()%></span>
            </div>
            <span class="status-badge <%=statusClass%>"><%=status%></span>
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
