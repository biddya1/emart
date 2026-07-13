<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
            <%@include file="components/common_css_js.jsp" %>

            
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
          <%@include file="components/common_modal.jsp" %>
        <!-- Hero Section -->
<div class="text-center text-white py-5"
     style="background:linear-gradient(135deg,#1e3a8a,#3b82f6);">
    <div class="container">
        <h1 class="fw-bold display-5">About E-Mart</h1>
        <p class="lead mb-0">Your trusted destination for smart, simple, and affordable shopping.</p>
    </div>
</div>

<!-- Who We Are -->
<div class="container my-5">
    <div class="row align-items-center">
        <div class="col-md-6 mb-4 mb-md-0">
            <img src="image/ecommerce.png" class="img-fluid" style="max-height:280px;" alt="About E-Mart">
        </div>
        <div class="col-md-6">
            <h2 class="fw-bold mb-3" style="color:#1e3a8a;">Who We Are</h2>
            <p class="text-muted" style="font-size:16px;line-height:1.8;">
                E-Mart is an online marketplace built to make everyday shopping easier.
                From electronics and fashion to toys and home essentials, we bring a wide
                range of quality products together in one simple platform. Our goal is to
                give every customer a smooth, secure, and enjoyable shopping experience
                from browsing to checkout.
            </p>
        </div>
    </div>
</div>

<!-- Why Choose Us -->
<div class="py-5" style="background:#f4f6f9;">
    <div class="container">
        <h2 class="fw-bold text-center mb-5" style="color:#1e3a8a;">Why Choose E-Mart</h2>

        <div class="row text-center g-4">

            <div class="col-md-3 col-6">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <i class="fa-solid fa-truck-fast fa-2x mb-3" style="color:#3b82f6;"></i>
                    <h6 class="fw-bold">Fast Delivery</h6>
                    <p class="text-muted small mb-0">Quick and reliable shipping to your doorstep.</p>
                </div>
            </div>

            <div class="col-md-3 col-6">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <i class="fa-solid fa-tags fa-2x mb-3" style="color:#3b82f6;"></i>
                    <h6 class="fw-bold">Best Prices</h6>
                    <p class="text-muted small mb-0">Great deals and discounts on every category.</p>
                </div>
            </div>

            <div class="col-md-3 col-6">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <i class="fa-solid fa-shield-halved fa-2x mb-3" style="color:#3b82f6;"></i>
                    <h6 class="fw-bold">Secure Shopping</h6>
                    <p class="text-muted small mb-0">Your data and payments are always protected.</p>
                </div>
            </div>

            <div class="col-md-3 col-6">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <i class="fa-solid fa-headset fa-2x mb-3" style="color:#3b82f6;"></i>
                    <h6 class="fw-bold">24/7 Support</h6>
                    <p class="text-muted small mb-0">We're here to help whenever you need us.</p>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Our Mission -->
<div class="container my-5 text-center">
    <h2 class="fw-bold mb-3" style="color:#1e3a8a;">Our Mission</h2>
    <p class="text-muted mx-auto" style="max-width:700px;font-size:16px;line-height:1.8;">
        To make online shopping accessible, affordable, and enjoyable for everyone by
        connecting customers with quality products through a fast, secure, and
        user-friendly platform.
    </p>
</div>

<!-- Footer -->
<footer class="text-white text-center py-4" style="background:#1e3a8a;">
    <p class="mb-0">&copy; 2026 E-Mart. All rights reserved.</p>
</footer>
    </body>
</html>
