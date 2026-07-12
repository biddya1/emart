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

<div class="row mt-3 mx-2">

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
                All Products
            </a>

            <%
                for(Category c : clist){
            %>

            <a href="index.jsp?category=<%=c.getCategoryId()%>"
               class="list-group-item list-group-item-action">
                <%=c.getCategoryTitle()%>
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
        if(list.size() == 0){
        %>

            <div class="col-md-12">

                <div class="alert alert-warning text-center mt-4">

                    <h4>No Products Found</h4>

                    <p>
                        There are no products available in this category.
                    </p>

                </div>

            </div>

        <%
        }
        else{

            for(Product p : list){
        %>

            <div class="col-md-4 mb-4">

                <div class="card shadow product-card h-100">

                    <div class="text-center p-3">

                        <img src="image/products/<%=p.getpPhoto()%>"
                             class="card-img-top product-img"
                             alt="<%=p.getpName()%>">

                    </div>

                    <div class="card-body text-center">

                        <h5 class="fw-bold">
                            <%=p.getpName()%>
                        </h5>

                        <p class="text-muted">
                            <%=Helper.get10Words(p.getpDesc())%>
                        </p>

                    </div>

                    <div class="card-footer bg-white border-0 text-center">

                        <button class="btn custom-bg text-white">
                            Add to Cart
                        </button>

                        <button class="btn btn-outline-primary">
                            &#8377; <%=p.getpPrice()%>
                        </button>

                        <br><br>

                        <%
                        User user = (User)session.getAttribute("current-user");

                        if(user != null && user.getUserType().equals("admin")){
                        %>

                            <a href="updateProduct.jsp?pid=<%=p.getpId()%>"
                               class="btn btn-warning btn-sm">
                                Update
                            </a>

                            <a href="DeleteProductServlet?pid=<%=p.getpId()%>"
                               class="btn btn-danger btn-sm"
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
        }
        %>

        </div>

    </div>

</div>