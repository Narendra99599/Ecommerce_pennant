<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="models.ProductsList, models.Product,java.util.*" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="ISO-8859-1">
            <title>Shopping Cart</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        </head>

        <body>
            <div class="container mt-5">


                <% HashMap<Integer,Product> productSet = (HashMap<Integer,Product>) session.getAttribute("productSet");
                        HashMap<Integer, Integer> productCount =(HashMap<Integer, Integer>)
                                session.getAttribute("productCount");
                                int oid = (int) session.getAttribute("order_id");
                                String cid =( (String) session.getAttribute("customer_name")).toUpperCase();
                                int total = (int) session.getAttribute("cart_total");
                                %>
                                <h3 style="color:green; display:inline;">
                                    <%= cid %> ,Your Order is successful with order id:
                                </h3>
                                <h3 style="color:green; display:inline;">
                                    <%= oid %>
                                </h3>

                                <h3 style="color:green" >Total payable amount is: <span class = "totalamount"><%= total %> </span>
                               </h3>


                                <!-- Button to trigger modal -->
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                    data-target="#cartModal">View Order items</button>



                                <!-- Modal Structure -->
                                <div class="modal fade" id="cartModal" tabindex="-1" role="dialog"
                                    aria-labelledby="cartModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="cartModalLabel">Items</h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- Table with cart items -->
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Product ID</th>
                                                            <th>Product Name</th>
                                                            <th>Price</th>
                                                            <th>Image</th>
                                                            <th>Qty</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Map.Entry< Integer,Product> product :
                                                            productSet.entrySet()) {
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= product.getValue().getPid() %>
                                                                </td>
                                                                <td>
                                                                    <%= product.getValue().getPname() %>
                                                                </td>
                                                                <td>
                                                                    <%= product.getValue().getPrice() %>
                                                                </td>
                                                                <td><img src="<%= product.getValue().getImage() %>"
                                                                        alt="<%= product.getValue().getPname() %>"
                                                                        width="50" height="50" /></td>
                                                                <td>
                                                                    <%= productCount.get(product.getKey()) %>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <button onclick="createRazorpayOrder()">Pay with Razorpay</button>
            </div>
            <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
			<script>
    function createRazorpayOrder() {
    	let amount = $(".totalamount").text();
    	console.log(amount)
        fetch('OrderCreation?amount='+amount)
            .then(response => response.json())
            .then(data => {
               
                var options = {
                    "key": "rzp_test_oylZTllNukvCHh",
                    "amount": data.amount,
                    "currency": "INR",
                    "name": "Acme Corp",
                    "description": "Test Transaction",
                    "image": "https://example.com/your_logo",
                    "order_id": data.id,
                    "handler": function (response) {
                  
                    },
                    "prefill": {
                        "name": "Gaurav Kumar",
                        "email": "gaurav.kumar@example.com",
                        "contact": "9000090000"
                    },
                    "notes": {
                        "address": "Razorpay Corporate Office"
                    },
                    "theme": {
                        "color": "#0000FF"
                    }
                };
                var rzp1 = new Razorpay(options);
                rzp1.open();
            })
            .catch(error => {
                console.error('Error creating Razorpay order:', error);
            });
    }
    
    function handleRazorpayResponse(response) {
        fetch('OrderCreation', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(response)
        })
        .then(response => response.text())
        .then(data => {
            console.log('Payment verification response:', data);
        })
        .catch(error => {
            console.error('Error verifying payment:', error);
        });
    }
</script>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        </body>

        </html>