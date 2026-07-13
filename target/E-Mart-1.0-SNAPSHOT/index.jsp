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

                <img src="image/products/<%=p.getpPhoto()%>"
                     class="card-img-top product-img"
                     alt="<%=p.getpName()%>">

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
