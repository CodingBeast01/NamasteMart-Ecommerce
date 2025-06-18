<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.namastemart.service.impl.*" %>
<%@ page import="com.namastemart.service.*" %>
<%@ page import="com.namastemart.beans.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
}

.content {
    margin-left: 250px;
    padding: 20px;
    transition: margin-left 0.3s;
}

.sidebar.collapsed ~ .content {
    margin-left: 100px;
}

.card-container {
    padding-bottom: 20px;
}

.card {
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s;
}

.card:hover {
    transform: translateY(-10px);
}

.card-body {
    padding: 20px;
    text-align: center;
}

.card-title {
    font-size: 2rem;
    margin-bottom: 20px;
}

.card-text {
    font-size: 3rem;
    color: red;
}

.card-icon {
    font-size: 6rem;
    margin-bottom: 35px;
    color: green;
}

footer {
    position: relative;
    left: 250px;
    bottom: 0;
    width: calc(100% - 250px);
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px;
    margin-top: 20px;
    transition: left 0.3s, width 0.3s;
}

.sidebar.collapsed ~ .footer {
    left: 60px;
    width: calc(100% - 60px);
}

.charts-container {
    margin-top: 40px;
}

.chart-container {
    margin-bottom: 30px;
}

canvas {
    height: 400px;
    width: 100%;
}
</style>
</head>

<body>
<%@ include file="adminheader.jsp" %>
<div class="content">
<div class="text-center" style="color: black; font-size: 14px; font-weight: bold;">  
<%  
String userName = (String) session.getAttribute("username");  
String password = (String) session.getAttribute("password");  
if (userName == null || password == null) {  
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");  
}  

ProductServiceImpl prodDao = new ProductServiceImpl();  
OrderServiceImpl orderDao = new OrderServiceImpl();  

int totalProducts = prodDao.getTotalProducts();  
int totalOrders = orderDao.getTotalOrders();  
double totalAmount = orderDao.getTotalAmount();  

List<Double> monthlyProfit = orderDao.getMonthlyProfit();
List<Integer> monthlySales = orderDao.getMonthlySales();

Gson gson = new Gson();
String profitJson = gson.toJson(monthlyProfit);
String salesJson = gson.toJson(monthlySales);
%>
</div>

<!-- Start of Card Container -->
<div class="container card-container">
    <div class="row">
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-box card-icon"></i>
                    <h3 class="card-title">Total Products</h3>
                    <p class="card-text"><%= totalProducts %></p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-shopping-cart card-icon"></i>
                    <h3 class="card-title">Total Orders Placed</h3>
                    <p class="card-text"><%= totalOrders %></p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-dollar-sign card-icon"></i>
                    <h3 class="card-title">Total Transactions Amount</h3>
                    <p class="card-text">Rs <%= totalAmount %></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Start of Charts Container -->
<div class="container charts-container">
    <div class="row">
        <div class="col-sm-6 chart-container">
            <h3 class="text-center">Monthly Profit</h3>
            <canvas id="profitChart"></canvas>
        </div>
        <div class="col-sm-6 chart-container">
            <h3 class="text-center">Monthly Sales</h3>
            <canvas id="salesChart"></canvas>
        </div>
    </div>
</div>
<!-- End of Charts Container -->
</div>

<div class="footer">
    <p>NamasteMart &copy; 2024. All Rights Reserved.</p>
</div>

<script>
// Months array  
const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

// JSON data from JSP  
const profitData = <%= profitJson %>;  
const salesData = <%= salesJson %>;

// Check the data in the console  
console.log('Profit Data', profitData);  
console.log('Sales Data', salesData);

// Chart.js code to render the charts  
const ctxProfit = document.getElementById('profitChart').getContext('2d');  
const ctxSales = document.getElementById('salesChart').getContext('2d');

new Chart(ctxProfit, {  
    type: 'bar',
    data: {
        labels: months,
        datasets: [{
            label: 'Monthly Profit',
            data: profitData,
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            x: { beginAtZero: true },
            y: { beginAtZero: true }
        }
    }
});

new Chart(ctxSales, {
    type: 'line',
    data: {
        labels: months,
        datasets: [{
            label: 'Monthly Sales',
            data: salesData,
            backgroundColor: 'rgba(153, 102, 255, 0.2)',
            borderColor: 'rgba(153, 102, 255, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            x: { beginAtZero: true },
            y: { beginAtZero: true }
        }
    }
});
</script>
</body>
</html>