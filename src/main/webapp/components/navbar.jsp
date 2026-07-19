<%@page import="com.learn.emart.entities.User"%>
<%
User user1 = (User) session.getAttribute("current-user");
%>

<style>
.emart-navbar{
    background:linear-gradient(90deg,#0f172a,#1e3a8a 60%,#1e40af);
    position:sticky;
    top:0;
    z-index:1030;
    padding:10px 0;
}
.emart-navbar .nav-link{
    color:#e2e8f0 !important;
    font-weight:500;
    position:relative;
    padding:8px 14px !important;
    transition:.25s;
}
.emart-navbar .nav-link:hover,
.emart-navbar .nav-link.active{
    color:#ffffff !important;
}
.emart-navbar .nav-link::after{
    content:"";
    position:absolute;
    left:14px;
    right:14px;
    bottom:2px;
    height:2px;
    background:#facc15;
    transform:scaleX(0);
    transform-origin:left;
    transition:transform .25s;
}
.emart-navbar .nav-link:hover::after,
.emart-navbar .nav-link.active::after{
    transform:scaleX(1);
}
.emart-search{
    background:rgba(255,255,255,0.12);
    border-radius:30px;
    overflow:hidden;
    transition:.25s;
}
.emart-search:focus-within{
    background:#ffffff;
    box-shadow:0 4px 14px rgba(0,0,0,.15);
}
.emart-search input{
    background:transparent;
    border:none;
    color:#fff;
    box-shadow:none !important;
}
.emart-search:focus-within input{
    color:#1e293b;
}
.emart-search input::placeholder{
    color:#cbd5e1;
}
.emart-search:focus-within input::placeholder{
    color:#94a3b8;
}
.emart-search .search-icon{
    color:#cbd5e1;
}
.emart-search:focus-within .search-icon{
    color:#1e3a8a;
}
.cart-icon-wrap{
    position:relative;
    display:inline-block;
}
.cart-badge{
    position:absolute;
    top:-6px;
    right:-10px;
    background:#facc15;
    color:#1e293b;
    font-size:11px;
    font-weight:700;
    min-width:18px;
    height:18px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:0 4px;
}
.user-avatar{
    width:32px;
    height:32px;
    border-radius:50%;
    background:#facc15;
    color:#1e293b;
    font-weight:700;
    font-size:13px;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    margin-right:6px;
}
.btn-outline-light-pill{
    border:1px solid rgba(255,255,255,.4);
    border-radius:30px;
    padding:6px 18px;
    color:#fff;
    transition:.25s;
}
.btn-outline-light-pill:hover{
    background:#ffffff;
    color:#1e3a8a;
}
</style>

<nav class="navbar navbar-expand-lg navbar-dark emart-navbar shadow">
<div class="container-fluid px-4">

    <!-- Logo -->
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
        <img src="image/emart-logo-white.svg" alt="E-Mart Logo" height="42">
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
            <li class="nav-item">
    <a class="nav-link" href="help.jsp">
        Help & Support
    </a>
</li>
        </ul>

        <!-- Search Bar -->
        <form class="d-flex mx-auto my-2 my-lg-0" style="max-width:420px;width:100%;" action="index.jsp" method="get">
            <div class="input-group emart-search px-3">
                <span class="input-group-text bg-transparent border-0 p-0 pe-2">
                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                </span>
                <input type="text"
                       name="search"
                       class="form-control py-2"
                       value='<%=request.getParameter("search")!=null?request.getParameter("search"):""%>'
                       placeholder="Search products...">
            </div>
        </form>

        <!-- Right Side -->
        <ul class="navbar-nav ms-auto align-items-lg-center">

            <!-- Cart -->
            <%
            if(user1 == null || !user1.getUserType().equals("admin")){
            %>
            <li class="nav-item">
                <a class="nav-link"
                   href="#"
                   data-bs-toggle="modal"
                   data-bs-target="#cart"
                   onclick="updateCart()">
                    <span class="cart-icon-wrap">
                        <i class="fa-solid fa-cart-shopping fs-5"></i>
                        <span class="cart-badge cart-items">0</span>
                    </span>
                </a>
            </li>
            <%
            }
            %>

            <%
            if(user1 == null){
            %>
                <li class="nav-item ms-lg-2">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item ms-lg-2">
                    <a class="btn-outline-light-pill" href="register.jsp">Register</a>
                </li>
            <%
            }else{
            %>
                <%
                if(user1.getUserType().equals("admin")){
                %>
                <li class="nav-item">
                    <a class="nav-link" href="admin.jsp">
                        <i class="fa-solid fa-gauge"></i> Admin Dashboard
                    </a>
                </li>
                <%
                }
                %>
                <li class="nav-item d-flex align-items-center">
                    <a class="nav-link d-flex align-items-center" href="#">
                        <span class="user-avatar">
                            <%=user1.getUserName().substring(0,1).toUpperCase()%>
                        </span>
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
