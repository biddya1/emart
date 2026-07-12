<%@page import="com.learn.emart.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.emart.entities.Category"%>
<%@page import="com.learn.emart.dao.CategoryDao"%>
<%@page import="com.learn.emart.entities.Product"%>
<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page import="com.mycompany.e.mart.helper.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="components/common_css_js.jsp"%>
<%@include file="components/navbar.jsp"%>
<link rel="stylesheet" 
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<%
    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> clist = cdao.getCategories();

    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
    List<Product> list = pdao.getAllProducts();
%>


<div class="container-fluid">

    <div class="row mt-3">

        <!-- Categories -->
        <div class="col-md-2">

            <div class="list-group shadow rounded">

                <a href="#" class="list-group-item list-group-item-action active fw-bold">
                    All Products
                </a>

                <%
                    for(Category c : clist){
                %>

                <a href="#" class="list-group-item list-group-item-action">
                    <%= c.getCategoryTitle() %>
                </a>

                <%
                    }
                %>

            </div>

        </div>

        <!-- Products -->
        <div class="col-md-10">

            <div class="row">

                <%
                    for(Product p : list){
                %>

                <div class="col-md-4 mb-4">

                    <div class="card shadow product-card h-100">

                        <div class="text-center p-3">
                           <img src="image/products/<%= p.getpPhoto() %>"
                                 class="card-img-top product-img"
                            alt="<%= p.getpName() %>">

                        </div>

                        <div class="card-body text-center">

                            <h5 class="fw-bold">
                                <%= p.getpName() %>
                            </h5>

                            <p class="text-muted">
                                <%= Helper.get10Words(p.getpDesc()) %>
                            </p>

                        </div>

                        <div class="card-footer bg-white border-0 text-center">

                            <button class="btn custom-bg text-white">
                                Add to Cart
                            </button>

                            <button class="btn btn-outline-primary">
                                &#8377; <%= p.getpPrice() %>
                            </button>
                            <br><br>

                   <%
User user = (User)session.getAttribute("current-user");

if(user != null && user.getUserType().equals("admin")){
%>

<a href="updateProduct.jsp?pid=<%=p.getpId()%>" 
   class="btn btn-sm px-4 rounded-pill shadow-sm"
   style="background:#2563eb; color:white; border:none;">
    Update
</a>


<a href="DeleteProductServlet?pid=<%=p.getpId()%>"
   class="btn btn-sm px-4 rounded-pill shadow-sm"
   style="background:#e11d48; color:white; border:none;"
   onclick="return confirm('Are you sure you want to delete this product?');">
    Delete
</a>

<%
}
%>

                        </div>
                            

                    </div>

                </div>

                <%
                    }
                %>

            </div>

        </div>

    </div>

</div>