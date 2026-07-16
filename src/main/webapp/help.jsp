<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Help & Support | E-Mart</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>

    <style>

        body{
            background:#f5f7fb;
        }

        .hero{
            background:linear-gradient(90deg,#0f172a,#1e3a8a);
            color:white;
            padding:40px 20px;
            text-align:center;
            border-radius:0 0 20px 20px;
            margin-bottom:35px;
        }

        .hero h2{
            font-weight:bold;
        }

        .info-card{
            border:none;
            border-radius:15px;
            box-shadow:0 5px 15px rgba(0,0,0,.08);
            transition:.3s;
        }

        .info-card:hover{
            transform:translateY(-5px);
        }

        .info-card i{
            font-size:35px;
            color:#1e3a8a;
            margin-bottom:15px;
        }

        .accordion-button:not(.collapsed){
            background:#1e3a8a;
            color:white;
        }

        .contact-box{
            background:white;
            padding:25px;
            border-radius:15px;
            box-shadow:0 5px 15px rgba(0,0,0,.08);
        }

        .contact-box p{
            font-size:17px;
            margin-bottom:12px;
        }

    </style>

</head>

<body>

<%@include file="components/navbar.jsp"%>

<div class="hero">
    <h2><i class="fa-solid fa-headset"></i> Help & Support</h2>
    <p>We're here to help you with your shopping experience.</p>
</div>

<div class="container">

<div class="row g-4">

<div class="col-md-4">

<div class="card info-card text-center p-4 h-100">

<i class="fa-solid fa-cart-shopping"></i>

<h5>How to Shop</h5>

<p>
Register/Login, browse products, add them to your cart and proceed to checkout.
</p>

</div>

</div>

<div class="col-md-8">

<div class="card info-card p-3">

<h4 class="mb-3">
<i class="fa-solid fa-circle-question text-primary"></i>
Frequently Asked Questions
</h4>

<div class="accordion" id="faqAccordion">

<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button"

type="button"

data-bs-toggle="collapse"

data-bs-target="#q1">

How do I register?

</button>

</h2>

<div id="q1"

class="accordion-collapse collapse show"

data-bs-parent="#faqAccordion">

<div class="accordion-body">

Click the <b>Register</b> button in the navigation bar, fill in your information and submit the form to create your account.

</div>

</div>

</div>



<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"

type="button"

data-bs-toggle="collapse"

data-bs-target="#q2">

How do I add products to my cart?

</button>

</h2>

<div id="q2"

class="accordion-collapse collapse"

data-bs-parent="#faqAccordion">

<div class="accordion-body">

Browse products and click the <b>Add to Cart</b> button. Your selected products will appear in the shopping cart.

</div>

</div>

</div>



<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"

type="button"

data-bs-toggle="collapse"

data-bs-target="#q3">

How do I checkout?

</button>

</h2>

<div id="q3"

class="accordion-collapse collapse"

data-bs-parent="#faqAccordion">

<div class="accordion-body">

Open your cart, review your selected items and click the <b>Checkout</b> button to continue.

</div>

</div>

</div>



<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"

type="button"

data-bs-toggle="collapse"

data-bs-target="#q4">

How can I contact E-Mart?

</button>

</h2>

<div id="q4"

class="accordion-collapse collapse"

data-bs-parent="#faqAccordion">

<div class="accordion-body">

You can contact us through email, phone or visit our office using the contact information below.

</div>

</div>

</div>

</div>

</div>

</div>

</div>

<br>

<div class="contact-box">

<h4 class="mb-3">
<i class="fa-solid fa-phone-volume text-primary"></i>
Contact Us
</h4>

<p><i class="fa-solid fa-envelope text-primary"></i> support@emart.com</p>

<p><i class="fa-solid fa-phone text-success"></i> +977-9800000000</p>

<p><i class="fa-solid fa-location-dot text-danger"></i> Pokhara, Nepal</p>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>