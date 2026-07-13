<%@page import="com.learn.emart.entities.User"%>
<%
User user1 = (User) session.getAttribute("current-user");
%>
<nav class="navbar navbar-expand-lg navbar-dark shadow"
     style="background:#1e3a8a;">
<div class="container-fluid">

    <!-- Logo -->
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
        <img src="image/emart-logo-white.svg" alt="E-Mart Logo" height="46">
    </a>

    <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">

        <!-- Left Side -->
        <ul class="navbar-nav me-3">
    <li class="nav-item">
        <a class="nav-link active" href="index.jsp">
            Home
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="about.jsp">
            About
        </a>
    </li>
</ul>

        <!-- Search Bar -->
        <form class="d-flex mx-auto my-2 my-lg-0" style="max-width:420px;width:100%;" action="index.jsp" method="get">
            <div class="input-group">
                <span class="input-group-text bg-white border-0">
                    <i class="fa-solid fa-magnifying-glass text-secondary"></i>
                </span>
                <input type="text"
                       name="search"
                       class="form-control border-0"
                       placeholder="Search products...">
            </div>
        </form>

        <!-- Right Side -->
        <ul class="navbar-nav ms-auto">

            <!-- Cart -->
            <li class="nav-item">
                <a class="nav-link"
                   href="#"
                   data-bs-toggle="modal"
                   data-bs-target="#cart"
                   onclick="updateCart()">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="cart-items">
                        (0)
                    </span>
                </a>
            </li>

            <%
            if(user1 == null){
            %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
            <%
            }else{
            %>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <%=user1.getUserName()%>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">
                        Logout
                    </a>
                </li>
            <%
            }
            %>

        </ul>

    </div>
</div>
</nav>
