<%@page import="com.learn.emart.entities.User"%>
<%
User user = (User)session.getAttribute("current-user");

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
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="components/common_css_js.jsp"%>
<%@include file="components/navbar.jsp"%>

<div class="container">

    <!-- First Row -->
    <div class="row mt-4">

        <div class="col-md-4">
            <div class="card text-center shadow">
                <div class="card-body">
                    <img src="image/teamwork.png"
                         class="img-fluid rounded-circle"
                         style="max-width:125px;">
                    <h2 class="mt-3">4545</h2>
                    <h4 class="text-muted text-uppercase">Users</h4>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center shadow">
                <div class="card-body">
                    <img src="image/options.png"
                         class="img-fluid rounded-circle"
                         style="max-width:125px;">
                    <h2 class="mt-3">4355</h2>
                    <h4 class="text-muted text-uppercase">Categories</h4>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center shadow">
                <div class="card-body">
                    <img src="image/products.png"
                         class="img-fluid rounded-circle"
                         style="max-width:125px;">
                    <h2 class="mt-3">1234</h2>
                    <h4 class="text-muted text-uppercase">Products</h4>
                </div>
            </div>
        </div>

    </div>

    <!-- Second Row -->
    <div class="row mt-4">

        <div class="col-md-6">
            <div class="card text-center shadow">
                <div class="card-body">
                    <img src="image/add.png"
                         class="img-fluid rounded-circle"
                         style="max-width:125px;">
                    <p class="mt-3">Click here to add new categories</p>
                    <h4 class="text-uppercase text-muted">Add Category</h4>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card text-center shadow">
                <div class="card-body">
                    <img src="image/ecommerce.png"
                         class="img-fluid rounded-circle"
                         style="max-width:125px;">
                    <p class="mt-3">Click here to add new products</p>
                    <h4 class="text-uppercase text-muted">Add Products</h4>
                </div>
            </div>
        </div>

    </div>

</div>