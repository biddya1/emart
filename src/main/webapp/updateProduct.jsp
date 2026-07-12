<%@page import="java.util.List"%>
<%@page import="com.learn.emart.dao.CategoryDao"%>
<%@page import="com.learn.emart.dao.ProductDao"%>
<%@page import="com.learn.emart.entities.Category"%>
<%@page import="com.learn.emart.entities.Product"%>
<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>

<%
    int pid = Integer.parseInt(request.getParameter("pid"));

    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
    Product p = pdao.getProductById(pid);

    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> categories = cdao.getCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-lg-8 col-md-10">

            <div class="card shadow-lg border-0 rounded">

                <div class="card-header bg-primary text-white text-center py-3">
                    <h2 class="mb-0">Update Product</h2>
                </div>

                <div class="card-body p-4">

                    <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="pid" value="<%=p.getpId()%>">

                        <div class="form-group mb-3">
                            <label><b>Product Name</b></label>
                            <input type="text"
                                   class="form-control"
                                   name="pName"
                                   value="<%=p.getpName()%>"
                                   required>
                        </div>

                        <div class="form-group mb-3">
                            <label><b>Description</b></label>
                            <textarea class="form-control"
                                      name="pDesc"
                                      rows="4"
                                      required><%=p.getpDesc()%></textarea>
                        </div>

                        <div class="row">

                            <div class="col-md-4">
                                <div class="form-group mb-3">
                                    <label><b>Price</b></label>
                                    <input type="number"
                                           class="form-control"
                                           name="pPrice"
                                           value="<%=p.getpPrice()%>"
                                           required>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-3">
                                    <label><b>Discount (%)</b></label>
                                    <input type="number"
                                           class="form-control"
                                           name="pDiscount"
                                           value="<%=p.getpDiscount()%>"
                                           required>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-3">
                                    <label><b>Quantity</b></label>
                                    <input type="number"
                                           class="form-control"
                                           name="pQuantity"
                                           value="<%=p.getpQuantity()%>"
                                           required>
                                </div>
                            </div>

                        </div>

                        <div class="form-group mb-3">

                            <label><b>Category</b></label>

                            <select class="form-control" name="catId">

                                <% for(Category c : categories){ %>

                                <option value="<%=c.getCategoryId()%>"
    <%= (p.getCategory() != null && 
          p.getCategory().getCategoryId() == c.getCategoryId()) 
          ? "selected" : "" %>>
    <%= c.getCategoryTitle() %>
</option>

                                <% } %>

                            </select>

                        </div>

                        <div class="text-center mb-3">

                            <label><b>Current Image</b></label><br><br>

                            <img src="image/products/<%=p.getpPhoto()%>"
                                 class="img-thumbnail shadow"
                                 style="width:180px;height:180px;object-fit:cover;">

                        </div>

                        <div class="form-group mb-4">

                            <label><b>Select New Image (Optional)</b></label>

                            <input type="file"
                                   class="form-control"
                                   name="pPic">

                        </div>

                        <div class="text-center">

                            <button type="submit" class="btn btn-success btn-lg px-5">
                                Update Product
                            </button>

                            <a href="admin.jsp" class="btn btn-danger btn-lg px-5 ml-2">
                                Cancel
                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</div>

</body>
</html>