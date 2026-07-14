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
    <title>Update Product - E-Mart</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">

    <style>
        body{
            background:#f4f6f9;
        }
        .update-header{
            background:linear-gradient(135deg,#1e3a8a,#3b82f6);
            border-radius:15px 15px 0 0;
        }
        .form-control:focus{
            border-color:#3b82f6;
            box-shadow:0 0 0 0.2rem rgba(59,130,246,.25);
        }
        .current-img-box{
            border:2px dashed #cbd5e1;
            border-radius:15px;
            padding:15px;
            display:inline-block;
        }
    </style>
</head>

<body>

<div class="container my-5">

    <div class="row justify-content-center">

        <div class="col-lg-8 col-md-10">

            <div class="card shadow-lg border-0 rounded-4 overflow-hidden">

                <div class="update-header text-white text-center py-4">
                    <h2 class="mb-1 fw-bold">
                        <i class="bi bi-pencil-square"></i> Update Product
                    </h2>
                    <p class="mb-0 opacity-75">Edit the details below and save your changes</p>
                </div>

                <div class="card-body p-4 p-md-5">

                    <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="pid" value="<%=p.getpId()%>">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Product Name</label>
                            <input type="text"
                                   class="form-control form-control-lg"
                                   name="pName"
                                   value="<%=p.getpName()%>"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Description</label>
                            <textarea class="form-control"
                                      name="pDesc"
                                      rows="4"
                                      required><%=p.getpDesc()%></textarea>
                        </div>

                        <div class="row">

                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Price (?)</label>
                                    <input type="number"
                                           class="form-control"
                                           name="pPrice"
                                           value="<%=p.getpPrice()%>"
                                           required>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Discount (%)</label>
                                    <input type="number"
                                           class="form-control"
                                           name="pDiscount"
                                           value="<%=p.getpDiscount()%>"
                                           required>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Quantity</label>
                                    <input type="number"
                                           class="form-control"
                                           name="pQuantity"
                                           value="<%=p.getpQuantity()%>"
                                           required>
                                </div>
                            </div>

                        </div>

                        <div class="mb-4">

                            <label class="form-label fw-bold">Category</label>

                            <select class="form-select" name="catId">

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

                        <div class="text-center mb-4">

                            <label class="form-label fw-bold d-block mb-2">Current Image</label>

                            <div class="current-img-box">
                                <img src="image/products/<%=p.getpPhoto()%>"
                                     class="img-thumbnail shadow-sm"
                                     style="width:160px;height:160px;object-fit:cover;border:none;">
                            </div>

                        </div>

                        <div class="mb-4">

                            <label class="form-label fw-bold">Select New Image (Optional)</label>

                            <input type="file"
                                   class="form-control"
                                   name="pPic">

                        </div>

                        <div class="d-flex justify-content-center gap-3">

                            <button type="submit" class="btn btn-primary btn-lg px-5 rounded-pill">
                                <i class="bi bi-check-circle"></i> Update Product
                            </button>

                            <a href="admin.jsp" class="btn btn-outline-secondary btn-lg px-5 rounded-pill">
                                Cancel
                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>
