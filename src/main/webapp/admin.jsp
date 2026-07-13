<%@page import="com.learn.emart.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.emart.entities.Category"%>
<%@page import="com.learn.emart.dao.CategoryDao"%>
<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.query.Query"%>

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
<%
Session hsession = FactoryProvider.getFactory().openSession();

Long userCount = (Long) hsession.createQuery("select count(u) from User u").uniqueResult();
Long categoryCount = (Long) hsession.createQuery("select count(c) from Category c").uniqueResult();
Long productCount = (Long) hsession.createQuery("select count(p) from Product p").uniqueResult();

hsession.close();
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
                    <h2 class="text-primary mt-3"><%=userCount%></h2>
                    <h5 class="text-secondary">USERS</h5>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow text-center border-0 h-100">
                <div class="card-body">
                    <img src="image/options.png" width="100">
                    <h2 class="text-success mt-3"><%=categoryCount%></h2>
                    <h5 class="text-secondary">CATEGORIES</h5>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow text-center border-0 h-100">
                <div class="card-body">
                    <img src="image/products.png" width="100">
                    <h2 class="text-danger mt-3"><%=productCount%></h2>
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
                 data-bs-toggle="modal"
                 data-bs-target="#add-product-modal"
                 style="cursor:pointer;">

            <div class="card shadow border-0 text-center h-100"
                 style="cursor:pointer;">

                <div class="card-body p-5">
                    <img src="image/ecommerce.png" width="110">
                    <h3 class="text-success mt-4">Add Product</h3>
                    <p class="text-muted">
                        Click here to add a new product.
                    </p>
                </div>
                <%
CategoryDao cdao2 = new CategoryDao(FactoryProvider.getFactory());
List<Category> categories = cdao2.getCategories();
%>

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>All Categories</h4>
        </div>

        <div class="card-body">

            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <% for(Category c : categories){ %>

                    <tr>
                        <td><%= c.getCategoryId() %></td>
                        <td><%= c.getCategoryTitle() %></td>
                        <td><%= c.getCategoryDescription() %></td>

                        <td>

                            <a href="DeleteCategoryServlet?cid=<%= c.getCategoryId() %>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete this category?');">

                                Delete

                            </a>

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>
    </div>
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



<!--Start product modal-->


</div>
</div>

<!-- Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          
         <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
             

    <input type="hidden" name="operation" value="addproduct">

    <!-- Product Name -->
    <div class="mb-3">
        <label class="form-label"><b>Product Name</b></label>
        <input type="text"
               class="form-control"
               name="pName"
               placeholder="Enter product name"
               required>
    </div>

    <!-- Product Description -->
    <div class="mb-3">
        <label class="form-label"><b>Product Description</b></label>
        <textarea class="form-control"
                  rows="4"
                  name="pDesc"
                  placeholder="Enter product description"
                  required></textarea>
    </div>

    <!-- Product Price -->
    <div class="mb-3">
        <label class="form-label"><b>Product Price (Rs.)</b></label>
        <input type="number"
               class="form-control"
               name="pPrice"
               placeholder="Enter product price"
               required>
    </div>

    <!-- Product Discount -->
    <div class="mb-3">
        <label class="form-label"><b>Discount (%)</b></label>
        <input type="number"
               class="form-control"
               name="pDiscount"
               placeholder="Enter discount"
               required>
    </div>

    <!-- Product Quantity -->
    <div class="mb-3">
        <label class="form-label"><b>Quantity</b></label>
        <input type="number"
               class="form-control"
               name="pQuantity"
               placeholder="Enter quantity"
               required>
    </div>
<%
CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
List<Category> list = cdao.getCategories();
%>

<!-- Product Category -->
<div class="mb-3">
    <label class="form-label"><b>Select Category</b></label>

    <select name="catId" class="form-select" required>

        <option value="">-- Select Category --</option>

        <% for(Category c : list){ %>

            <option value="<%= c.getCategoryId() %>">
                <%= c.getCategoryTitle() %>
            </option>

        <% } %>

    </select>

    <!-- Product Image -->
    <div class="mb-3">
        <label class="form-label"><b>Product Image</b></label>

        <input type="file"
               class="form-control"
               id="pPic"
               name="pPic"
                required/>
    </div>

    <!-- Buttons -->
    <div class="text-center mt-4">

        <button type="submit" class="btn btn-success px-4">
            Add Product
        </button>

        <button type="button"
                class="btn btn-secondary px-4"
                data-bs-dismiss="modal">
            Close
        </button>

    </div>

</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
Static backdrop


<!--End product modal-->