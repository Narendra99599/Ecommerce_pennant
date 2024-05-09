<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="models.ProductsList, models.Product,java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Shopping Cart</title>
    <!-- Include some basic styling -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
.qty {
  height: 40px; /* Set height */
  width: 120px; /* Increase width for better spacing */
  display: flex; /* Use flexbox for alignment */
  justify-content: space-between; /* Distribute space evenly between elements */
  align-items: center; /* Center items vertically */
  border-radius: 10px; /* Smooth corners */
  padding: 5px; /* Add padding for inner space */
  transition: all 0.3s; /* Smooth transitions for hover effects */
}

.incdec {
  background: #4CAF50; /* Green background for increment/decrement buttons */
  padding: 5px 10px; /* Padding for spacing */
  border-radius: 5px; /* Slightly rounded corners */
  font-size: 1rem; /* Font size for readability */
  font-weight: 700; /* Bold text */
  color: white; /* White text color for contrast */
  transition: all 0.3s; /* Smooth transitions for hover effects */
}

.incdec:hover {
  background: #66bb6a; /* Lighter green on hover */
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* Light shadow effect */
  cursor: pointer; /* Change cursor to pointer on hover */
}

.th{
	position: relative;
	left : 70px
}

      
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Your Shopping Cart</h1>
        
        <%
          
            HashMap<Integer,Product> productSet = (HashMap<Integer,Product>) session.getAttribute("productSet");
            HashMap<Integer, Integer> productCount =(HashMap<Integer, Integer>) session.getAttribute("productCount");
            if (productSet == null || productSet.isEmpty()) {
                out.println("<p>Your cart is empty.</p>");
            } else {
        %>
            <table class="table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th class = "th">Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map.Entry< Integer,Product> product : productSet.entrySet()) {
                    %>
                        <tr>
                            <td><%= product.getValue().getPid() %></td>
                            <td><%= product.getValue().getPname() %></td>
                            <td><%= product.getValue().getPrice() %></td>
                            <td><img src="<%= product.getValue().getImage() %>" alt="<%= product.getValue().getPname() %>" width="50" height="50"/></td>
                            <td>
                            <div class="qty">
                                <div><p id="add" class="incdec" onclick="add(<%= product.getKey() %>)">+</p></div>
                                
                                <div><p id="count"><%=productCount.get(product.getKey()) %></p></div>
                                <div><p id="sub" class="incdec" onclick="sub(<%= product.getKey() %>)">-</p></div>
                            </div>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            }
        %>
        
        <!-- Add more UI elements like buttons to proceed to checkout -->
        <form action="CheckServlet" method = "POST">
    	   <div class="form-group">
		    <label for="exampleInputEmail1">Enter the pin code</label>
		    <input type="text" name = "pincode" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter pincode">
		    <small id="emailHelp" class="form-text text-muted">We will check wheather above products is availble in your zone or not</small>
			</div>	
			<button>check</button>
        </form>
        
        <button id="btn" class="btn btn-primary" >Proceed to Checkout</button>
    </div>

    <!-- Include Bootstrap JS for styling -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
    $("#btn").click(function() {
    	
    	
        fetch("checkout")
           
            .catch((error) => {
                console.error("Fetch error:", error); // Log error
                alert("An error occurred. Please try again later."); // Inform the user
            });
        window.location.href = 'checkout.jsp';
    });
    function add(pid){
        var url = "cart?action=add&pid="+pid; // The endpoint URL
        
        fetch(url, {
            method: "PUT", // Use POST method for creating/updating data
        })
        .catch((error) => {
            console.error("Fetch error:", error);
            // Consider adding user-friendly error handling here
        });
        console.log("add is called");
        window.location.href="cart.jsp";
      }
      function sub(pid){
    	
        var url = "cart?action=sub&pid="+pid; // The endpoint URL
        
        fetch(url, {
            method: "PUT", // Use POST method for creating/updating data
            
        })
        .catch((error) => {
            console.error("Fetch error:", error);
            // Consider adding user-friendly error handling here
        });
        window.location.href="cart.jsp";
        console.log("sub is called");
      }
    </script>
</body>
</html>
