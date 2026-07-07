<%@page import="com.learn.emart.entities.User"%>

<%
User user1 = (User) session.getAttribute("current-user");
%>

<nav class="navbar navbar-expand-lg navbar-dark shadow"
     style="background:#1e3a8a;">
<div class="container-fluid">

    <a class="navbar-brand" href="index.jsp">
        E-Mart
    </a>

    <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">

        <span class="navbar-toggler-icon"></span>

    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">

        <!-- Left Side -->
        <ul class="navbar-nav me-auto">

            <li class="nav-item">
                <a class="nav-link active" href="index.jsp">
                    Home
                </a>
            </li>

            <li class="nav-item dropdown">

                <a class="nav-link dropdown-toggle"
                   href="#"
                   id="navbarDropdown"
                   role="button"
                   data-bs-toggle="dropdown">

                    Categories

                </a>

                <ul class="dropdown-menu">

                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>

                </ul>

            </li>

        </ul>

        <!-- Right Side -->
        <ul class="navbar-nav ms-auto">

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