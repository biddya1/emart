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
<div class="text-white py-3 mb-4"
     style="background:linear-gradient(120deg,#0f172a,#1e3a8a 55%,#2563eb);">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-warning text-dark mb-2 px-2 py-1" style="font-size:11px;letter-spacing:1px;">
                    NEW ARRIVALS EVERY WEEK
                </span>
                <h1 class="fw-bold mb-2" style="font-size:32px;">
                    Big Deals, <span style="color:#93c5fd;">Every Day</span>
                </h1>
                <p class="mb-3" style="font-size:14px;color:#cbd5e1;max-width:520px;">
                    Explore authentic local products including fresh vegetables, homemade foods, traditional wear, handicrafts, and daily essentials 
                    — all from trusted local seller.
                </p>
                <a href="index.jsp?category=all" class="btn btn-light btn-sm px-3 rounded-pill fw-bold">
                    Shop Now <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid mt-4 px-4">

<div class="row mt-3">

<%
String cat = request.getParameter("category");
String search = request.getParameter("search");

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

if(search != null && !search.trim().equals("")){
    String keyword = search.trim().toLowerCase();
    List<Product> filtered = new java.util.ArrayList<Product>();

    for(Product p : list){
        if(p.getpName().toLowerCase().contains(keyword)){
            filtered.add(p);
        }
    }

    list = filtered;
}

User loggedUser = (User)session.getAttribute("current-user");
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

                      <p class="card-text">

<%
String desc = p.getpDesc();

if(desc.length() > 60){
%>

    <span id="shortDesc<%=p.getpId()%>">
        <%= desc.substring(0,60) %>...
    </span>

    <span id="fullDesc<%=p.getpId()%>" style="display:none;">
        <%= desc %>
    </span>

    <a href="javascript:void(0)"
       id="btn<%=p.getpId()%>"
       onclick="toggleDescription(<%=p.getpId()%>)"
       style="font-size:14px;text-decoration:none;">
        See More
    </a>

<%
}else{
%>

    <%= desc %>

<%
}
%>

</p>

                        <h5 class="text-success">
                            रु <%=p.getPriceAfterApplyingDiscount()%>
                        </h5>

                        <small class="text-decoration-line-through text-muted">
                            रु <%=p.getpPrice()%>
                        </small>

                        <span class="badge bg-danger">
                            <%=p.getpDiscount()%>% OFF
                        </span>

                    </div>

                    <div class="card-footer bg-white border-0 text-center">

                        <%
                        if(loggedUser == null || !loggedUser.getUserType().equals("admin")){
                        %>

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
                        }
                        %>

                        <%
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
        <script>
    var isUserLoggedIn = <%= session.getAttribute("current-user") != null %>;
</script>
<script>
function toggleDescription(id){

    var shortDesc=document.getElementById("shortDesc"+id);
    var fullDesc=document.getElementById("fullDesc"+id);
    var btn=document.getElementById("btn"+id);

    if(fullDesc.style.display==="none"){

        shortDesc.style.display="none";
        fullDesc.style.display="inline";
        btn.innerHTML=" See Less";

    }else{

        shortDesc.style.display="inline";
        fullDesc.style.display="none";
        btn.innerHTML=" See More";

    }

}
</script>

 <%@include file="components/common_modal.jsp" %>
