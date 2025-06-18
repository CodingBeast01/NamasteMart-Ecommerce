<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
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

<jsp:include page="header.jsp" />

<div class="products" style="background-color: #f1cdf6;">
    <div class="tab" align="center">
        <form>
            <button type="submit" formation="adminViewProduct.jsp">View products</button>
            <br><br>
            <button type="submit" formation="addProduct.jsp">Add products</button>
            <br><br>
            <button type="submit" formation="removeProduct.jsp">Remove Products</button>
            <br><br>
            <button type="submit" formation="updateProductById.jsp">Update Products</button>
            <br><br>
        </form>
    </div>
</div>

<%@ include file="footer.html"%>
</body>
</html>