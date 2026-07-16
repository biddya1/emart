// ===================== ADD TO CART =====================

function add_to_cart(pid, pname, price, stock)
{
    if(!isUserLoggedIn)
    {
        alert("Please login first to add products to cart.");
        window.location.href = "login.jsp";
        return;
    }

    console.log(pid);
    console.log(pname);
    console.log(price);
    console.log(stock);

    let cart = localStorage.getItem("cart");

    if(cart == null)
    {
        let products = [];

        let product = {
            productId: pid,
            productName: pname,
            productQuantity: 1,
            productPrice: price,
            productStock: stock
        };

        products.push(product);

        localStorage.setItem("cart", JSON.stringify(products));

        showToast(pname, "Added to cart successfully 🛒");
    }
    else
    {
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find(item => item.productId == pid);

        if(oldProduct)
        {
            if(oldProduct.productQuantity < oldProduct.productStock)
            {
                oldProduct.productQuantity++;

                localStorage.setItem("cart", JSON.stringify(pcart));

                showToast(pname, "Quantity increased 🔼");
            }
            else
            {
                alert("Only " + oldProduct.productStock + " item(s) are available in stock.");
            }
        }
        else
        {
            let product = {
                productId: pid,
                productName: pname,
                productQuantity: 1,
                productPrice: price,
                productStock: stock
            };

            pcart.push(product);

            localStorage.setItem("cart", JSON.stringify(pcart));

            showToast(pname, "Added to cart successfully 🛒");
        }
    }

    updateCart();
}


// ===================== UPDATE CART =====================

function updateCart()
{
    let cartString = localStorage.getItem("cart");

    if(cartString == null)
    {
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h5 class='text-center mt-3'>Cart is Empty</h5>");
        return;
    }

    let cart = JSON.parse(cartString);

    if(cart.length == 0)
    {
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h5 class='text-center mt-3'>Cart is Empty</h5>");
        return;
    }

    $(".cart-items").html("(" + cart.length + ")");

    let table = `
    <table class="table">
        <thead class="table-light">
            <tr>
                <th>Item</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
    `;

    let totalPrice = 0;

    cart.forEach(function(item){

        totalPrice += item.productPrice * item.productQuantity;

        table += `
        <tr>
            <td>${item.productName}</td>
            <td>₹ ${item.productPrice}</td>
            <td>${item.productQuantity}</td>
            <td>₹ ${item.productPrice * item.productQuantity}</td>
            <td>
                <button
                    class="btn btn-danger btn-sm"
                    onclick="deleteItemFromCart(${item.productId})">
                    Remove
                </button>
            </td>
        </tr>
        `;
    });

    table += `
        <tr>
            <td colspan="5" class="text-end fw-bold">
                Total Price : ₹ ${totalPrice}
            </td>
        </tr>
        </tbody>
    </table>
    `;

    $(".cart-body").html(table);
}


// ===================== REMOVE ITEM =====================

function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem("cart"));

    cart = cart.filter(item => item.productId != pid);

    localStorage.setItem("cart", JSON.stringify(cart));

    alert("Product removed.");

    updateCart();
}


// ===================== PAGE LOAD =====================

$(document).ready(function(){

    updateCart();

});


// ===================== CLOSE CART =====================

function closeCart()
{
    let cartModal = document.getElementById("cart");

    let modal = bootstrap.Modal.getInstance(cartModal);

    if(modal)
    {
        modal.hide();
    }

    document.querySelectorAll(".modal-backdrop").forEach(function(item){
        item.remove();
    });

    document.body.classList.remove("modal-open");
}


// ===================== CHECKOUT =====================

function checkout()
{
    let cart = localStorage.getItem("cart");

    if(cart == null || JSON.parse(cart).length == 0)
    {
        alert("Your cart is empty");
    }
    else
    {
        alert("Order placed successfully");

        localStorage.removeItem("cart");

        updateCart();

        closeCart();
    }
}


// ===================== TOAST =====================

function showToast(productName, message)
{
    $("#toastMessage").html(`
        <div>
            <b>${productName}</b>
            <br>
            ${message}
        </div>
    `);

    let toastElement = document.getElementById("cartToast");

    let toast = new bootstrap.Toast(toastElement,{
        delay:2500
    });

    toast.show();
}