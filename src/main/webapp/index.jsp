<%@page import="com.learn.emart.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.emart.entities.Category"%>
<%@page import="com.learn.emart.dao.CategoryDao"%>
<%@page import="com.learn.emart.entities.Product"%>
<%@page import="com.learn.emart.entities.User"%>
<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page import="com.mycompany.e.mart.helper.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@include file="components/common_css_js.jsp"%>
<%@include file="components/navbar.jsp"%>

<!-- Hero Banner -->
<div class="text-white text-center py-5 mb-4"
     style="background:linear-gradient(135deg,#1e3a8a,#3b82f6);">
    <div class="container">
        <h1 class="fw-bold display-5 mb-2">Big Deals, Every Day 🛍️</h1>
        <p class="lead mb-0">Shop the latest trends across Fashion, Electronics, Toys & more.</p>
    </div>
</div>

<div class="container-fluid mt-4 px-4">

<div class="row mt-3">

<%
String cat = request.getParameter("category");

CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
List<Category> clist = cdao.getCategories();

ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
List<Product> list = null;

if(cat == null || cat.trim().equals("all")){
    list = pdao.getAllProducts();
}
else{
    int cid = Integer.parseInt(cat.trim());
    list = pdao.getAllProductsById(cid);
}
%>

    <!-- Categories -->
    <div class="col-md-2">

        <div class="list-group shadow rounded">

            <a href="index.jsp?category=all"
               class="list-group-item list-group-item-action active fw-bold">
                <i class="fa-solid fa-border-all me-2"></i> All Products
            </a>

            <%
                for(Category c : clist){
                    String title = c.getCategoryTitle().toLowerCase();
                    String icon = "fa-tag";

                    if(title.contains("fashion") || title.contains("cloth")) icon = "fa-shirt";
                    else if(title.contains("flower")) icon = "fa-seedling";
                    else if(title.contains("toy")) icon = "fa-puzzle-piece";
                    else if(title.contains("laptop") || title.contains("labtop")) icon = "fa-laptop";
                    else if(title.contains("watch")) icon = "fa-clock";
            %>

            <a href="index.jsp?category=<%=c.getCategoryId()%>"
               class="list-group-item list-group-item-action">
                <i class="fa-solid <%=icon%> me-2"></i> <%=c.getCategoryTitle()%>
            </a>

            <%
                }
            %>

        </div>

    </div>

    <!-- Products -->
    <div class="col-lg-10 col-md-9">

        <div class="row g-4">

        <%
        if(list.size()==0){
        %>

            <div class="col-12">
                <div class="alert alert-warning text-center">
                    <h4>No Products Found</h4>
                </div>
            </div>

        <%
        }else{

            for(Product p:list){
        %>

            <div class="col-lg-4 col-md-6 col-sm-6">

                <div class="card product-card h-100 shadow">

                    <div class="position-relative">
                        <% if(p.getpDiscount() >= 10){ %>
                            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-2">
                                🔥 Hot Deal
                            </span>
                        <% } %>
                        <img src="image/products/<%=p.getpPhoto()%>"
                             class="card-img-top product-img"
                             alt="<%=p.getpName()%>">
                    </div>

                    <div class="card-body text-center">

                        <h5><%=p.getpName()%></h5>

                        <p>
                            <%=Helper.get10Words(p.getpDesc())%>
                        </p>

                        <h5 class="text-success">
                            ₹ <%=p.getPriceAfterApplyingDiscount()%>
                        </h5>

                        <small class="text-decoration-line-through text-muted">
                            ₹ <%=p.getpPrice()%>
                        </small>

                        <span class="badge bg-danger">
                            <%=p.getpDiscount()%>% OFF
                        </span>

                    </div>

                    <div class="card-footer bg-white border-0 text-center">

                        <button class="btn custom-bg text-white"
                        onclick="add_to_cart(
                            <%=p.getpId()%>,
                            '<%=p.getpName()%>',
                            <%=p.getPriceAfterApplyingDiscount()%>,
                            <%=p.getpQuantity()%>
                        )">

                            Add to Cart

                        </button>

                        <%
                        User loggedUser = (User)session.getAttribute("current-user");

                        if(loggedUser != null && loggedUser.getUserType().equals("admin")){
                        %>

                        <div class="mt-2">

                            <a href="updateProduct.jsp?pid=<%=p.getpId()%>"
                               class="btn btn-outline-primary btn-sm">
                                Update
                            </a>

                            <a href="DeleteProductServlet?pid=<%=p.getpId()%>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this product?');">
                                Delete
                            </a>

                        </div>

                        <%
                        }
                        %>

                    </div>

                </div>

            </div>

        <%
            }
        }
        %>

        </div>

    </div>

</div>

</div>

 <%@include file="components/common_modal.jsp" %>
