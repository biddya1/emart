<%@page import="com.learn.emart.entities.User"%>

<%
User user = (User) session.getAttribute("current-user");
%>
<!-- Cart Modal -->
<div class="modal fade" id="cart" tabindex="-1" aria-hidden="true">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header">

                <h5 class="modal-title">Your Cart</h5>

                <button type="button"
                        class="btn-close"
                        onclick="closeCart()">
                </button>

            </div>

            <!-- Body -->
            <div class="modal-body">

                <div class="cart-body">

                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer">

                <button class="btn btn-secondary"
                        onclick="closeCart()">
                    Close
                </button>

                <%
if(user != null && user.getUserType().equals("admin")){
%>


<button class="btn btn-primary"
        onclick="checkout()">
    Checkout
</button>

<%
}else{
%>

 <!-- Customer -->
        <button class="btn btn-success"
                onclick="BuyNow()">
            Buy Now
        </button>
<%
}
%>

            </div>

        </div>

    </div>

</div>

<!-- Toast -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">

    <div id="cartToast"
         class="toast"
         role="alert">

        <div class="toast-header">

            <strong class="me-auto">
                E-Mart
            </strong>

            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="toast">
            </button>

        </div>

        <div class="toast-body" id="toastMessage">

        </div>

    </div>

</div>