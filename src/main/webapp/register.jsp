<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>E-Mart | Register</title>

    <%@include file="components/common_css_js.jsp" %>

</head>

<body class="bg-light">

    <%@include file="components/navbar.jsp" %>

    <div class="container">

        <div class="row mt-5">

            <div class="col-md-5 offset-md-3">

                <div class="card shadow-lg border-0">

                    <div class="card-body p-4">

                        <div class="text-center mb-3">
                            <i class="bi bi-person-circle text-primary" style="font-size:70px;"></i>

                            <h3 class="text-primary mt-2">
                                Create Account
                            </h3>

                            <p class="text-muted">
                                Register to continue shopping
                            </p>
                        </div>

                        <form action="RegisterServlet" method="post">

                            <!-- Name -->
                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-person-fill"></i>
                                    Full Name
                                </label>

                                <input type="text"
                                       name="user_name"
                                       class="form-control"
                                       placeholder="Enter your name"
                                       required>

                            </div>

                            <!-- Email -->
                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-envelope-fill"></i>
                                    Email
                                </label>

                                <input type="email"
                                       name="user_email"
                                       class="form-control"
                                       placeholder="Enter email"
                                       required>

                            </div>

                            <!-- Password -->
                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-lock-fill"></i>
                                    Password
                                </label>

                                <input type="password"
                                       name="user_password"
                                       class="form-control"
                                       placeholder="Enter password"
                                       required>

                            </div>

                            <!-- Phone -->
                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-telephone-fill"></i>
                                    Phone
                                </label>

                                <input type="text"
                                       name="user_phone"
                                       class="form-control"
                                       placeholder="98XXXXXXXX">

                            </div>

                            <!-- Address -->
                            <div class="mb-3">

                                <label class="form-label">
                                    <i class="bi bi-geo-alt-fill"></i>
                                    Address
                                </label>

                                <textarea class="form-control"
                                          name="user_address"
                                          rows="3"
                                          placeholder="Enter your address"></textarea>

                            </div>

                            <div class="text-center">

                                <button class="btn btn-primary w-100">

                                    <i class="bi bi-person-plus-fill"></i>

                                    Register

                                </button>

                            </div>

                            <div class="text-center mt-3">

                                <a href="login.jsp">
                                    Already have an account? Login
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