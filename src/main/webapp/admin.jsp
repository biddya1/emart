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

<div class="container admin">
    
    <div class="container-fluid mt-3">
        <%@include file="components/message.jsp" %>
    </div>

    <!-- First Row -->
    <div class="container mt-4">

    <!-- Welcome -->
    <div class="card shadow border-0 mb-4">
        <div class="card-body text-center text-white"
             style="background:linear-gradient(135deg,#0d6efd,#6610f2);border-radius:15px;">
            <h2>Welcome!</h2>
            <p class="mb-0">E-Mart Admin Dashboard</p>
        </div>
    </div>

    <div class="row">

        <div class="col-md-4 mb-4">
            <div class="card shadow text-center border-0 h-100">
                <div class="card-body">
                    <img src="image/teamwork.png" width="100">
                    <h2 class="text-primary mt-3">4545</h2>
                    <h5 class="text-secondary">USERS</h5>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow text-center border-0 h-100">
                <div class="card-body">
                    <img src="image/options.png" width="100">
                    <h2 class="text-success mt-3">4355</h2>
                    <h5 class="text-secondary">CATEGORIES</h5>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow text-center border-0 h-100">
                <div class="card-body">
                    <img src="image/products.png" width="100">
                    <h2 class="text-danger mt-3">1234</h2>
                    <h5 class="text-secondary">PRODUCTS</h5>
                </div>
            </div>
        </div>

    </div>

    <div class="row">

        <div class="col-md-6 mb-4">
            <div class="card shadow border-0 text-center h-100"
                 data-bs-toggle="modal"
                 data-bs-target="#add-category-modal"
                 style="cursor:pointer;">

                <div class="card-body p-5">
                    <img src="image/add.png" width="110">
                    <h3 class="text-primary mt-4">Add Category</h3>
                    <p class="text-muted">
                        Click here to add a new category.
                    </p>
                </div>

            </div>
        </div>

        <div class="col-md-6 mb-4">

            <div class="card shadow border-0 text-center h-100"
                 style="cursor:pointer;">

                <div class="card-body p-5">
                    <img src="image/ecommerce.png" width="110">
                    <h3 class="text-success mt-4">Add Product</h3>
                    <p class="text-muted">
                        Click here to add a new product.
                    </p>
                </div>

            </div>

        </div>

    </div>

</div>
<!-- add category modal -->

<!-- Modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content custom-bg text-white">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Fill Category details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post">
              
              <input type="hidden" name="operation" value="addcategory">
              
              <div class="form-group">
                  <input type="text" class="form-control" name="categoryTitle" placeholder="Enter category title" required />
              </div>
              <div class="form-group">
                  <textarea  style="height:300px;" class="form-control" placeholder="Enter category description" name="categoryDescription" required>
                  </textarea>
              </div>
              
              <div class="container text-center mt-3">
    <button type="submit" class="btn btn-outline-success">
        Add Category
    </button>

    <button type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal">
        Close
    </button>
</div>
       
          </form>
      </div>
     
    </div>
  </div>
</div>



<!-- end category modal -->