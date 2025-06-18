<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="com.namastemart.service.impl.*, com.namastemart.service.*, com.namastemart.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*" %>
<!DOCTYPE html>
<html>


<head>
<title>Product Stocks</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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

.table-container {
    background-color: #f1cdf6;
    padding-bottom: 20px;
}

.footer {
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

.table>tbody>tr>td, .table>tbody>tr>th, 
.table>tfoot>tr>td, .table>tfoot>tr>th, 
.table>thead>tr>td, .table>thead>tr>th {
    border: 1px solid black !important;
}
</style>
</head>
<body>

<% /* Checking the user credentials */
String userType = (String) session.getAttribute("usertype");
String userName = (String) session.getAttribute("username");
String password = (String) session.getAttribute("password");

if (userType == null || !userType.equals("admin")) {
    response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
} else if (userName == null || password == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
}
%>

<%@ include file="adminheader.jsp" %>

<div class="content">
    <div class="table-container">
        <div class="text-center" style="color: black; font-size: 24px; font-weight: bold;">  
            Stock Products  
        </div>  
        <div class="container-fluid">
            <div class="table-responsive">
                <table class="table table-hover table-sm">
                    <thead style="background-color: #b341ab; color: white; font-size: 18px;"> 
                        <tr>
                            <th>Image</th>
                            <th>ProductId</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Price</th>
                            <th>Sold Qty</th>
                            <th>Stock Qty</th>
                            <th colspan="2" style="text-align: center">Actions</th>
                        </tr>
                    </thead>
                    <tbody style="background-color: #f1cdf6; font-size: 16px;"> 
                        <%
                        ProductServiceImpl productDao = new ProductServiceImpl();
                        List<ProductBean> products = new ArrayList<ProductBean>();
						products = productDao.getAllProducts();
						
                        for (ProductBean product : products) {
                        %>
                        <tr>
                            <td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
                            <td><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>"><%=product.getProdId()%></a></td>
                            <%
                            String name = product.getProdName();
                            name = name.substring(0, Math.min(name.length(), 25)) + "..";
                            %>
                            <td><%=name%></td>
                            <td><%=product.getProdType().toUpperCase()%></td>
                            <td><%=product.getProdPrice()%></td>
                            <td><%=new OrderServiceImpl().countSoldItem(product.getProdId())%></td>
                            <td><%=product.getProdQuantity()%></td>
                            <td>
                                <form method="post">
                                    <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-success">Update</button>
                                </form>
                            </td>
                            <td>
                                <form method="post">
                                    <button type="submit" formaction="./RemoveProductSrv?product=<%=product.getProdId()%>" class="btn btn-danger">Remove</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        <% if (products.size() == 0) { %>
                            <tr style="background-color: rgba(255, 0, 0, 0.704); color: white;">
                                <td colspan="7" style="text-align: center;">No Items Available</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <p>NamasteMart &copy; 2024. All Rights Reserved.</p>
</div>
</body>
</html>