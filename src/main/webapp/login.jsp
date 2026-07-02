<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login - E-Mart</title>

    <%@include file="components/common_css_js.jsp" %>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

    <%@include file="components/navbar.jsp" %>

    <div class="container">

        <div class="row mt-5">

            <div class="col-md-5 offset-md-3">

                <div class="card shadow-lg border-0 rounded-4">

                    <%@include file="components/message.jsp"%>

                    <div class="card-body p-4">

                        <div class="text-center">

                            <i class="bi bi-person-circle text-primary"
                               style="font-size:70px;"></i>

                            <h3 class="text-primary mt-2">
                                Login Here
                            </h3>

                            <p class="text-muted">
                                Welcome Back! Login to continue shopping.
                            </p>

                        </div>

                        <form action="LoginServlet" method="post">

                            <!-- Email -->

                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-envelope-fill"></i>
                                    Email Address
                                </label>

                                <input
                                    type="email"
                                    name="user_email"
                                    class="form-control"
                                    placeholder="Enter Email"
                                    required>

                            </div>

                            <!-- Password -->

                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-lock-fill"></i>
                                    Password
                                </label>

                                <input
                                    type="password"
                                    name="user_password"
                                    class="form-control"
                                    placeholder="Enter Password"
                                    required>

                            </div>

                            <div class="container text-center mt-4">

                                <button type="submit"
                                        class="btn btn-primary">

                                    <i class="bi bi-box-arrow-in-right"></i>

                                    Login

                                </button>

                                <button type="reset"
                                        class="btn btn-outline-danger">

                                    <i class="bi bi-arrow-clockwise"></i>

                                    Reset

                                </button>

                            </div>

                        </form>

                        <div class="text-center mt-3">

                            <a href="register.jsp"
                               class="text-decoration-none">

                                <i class="bi bi-person-plus-fill"></i>

                                Create New Account

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</body>

</html>