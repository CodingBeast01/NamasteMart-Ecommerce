<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, com.namastemart.service.TransService, com.namastemart.service.impl.TransServiceImpl, com.namastemart.beans.TransactionBean, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Transaction Management</title>
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
    padding: 20px;
}

.footer {
    position: fixed;
    left: 250px;
    bottom: 0;
    width: calc(100% - 250px);
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px;
    transition: left 0.3s, width 0.3s;
}

.sidebar.collapsed ~ .footer {
    left: 60px;
    width: calc(100% - 60px);
}

.btn {
    margin: 5px;
}

.table-bordered>tbody>tr>td,
.table-bordered>tbody>tr>th,
.table-bordered>tbody>tr>td,
.table-bordered>tbody>tr>th,
.table-bordered>tbody>tr>td,
.table-bordered>tbody>tr>th {
    border: 1px solid black !important;
}

.alert {
    margin-top: 20px;
}

.alert-info {
    color: black;
    background-color: #008000ac;
    border-color: black;
    font-size: x-large;
}
</style>
</head>
<body>

<%
String userType = (String) session.getAttribute("usertype");
String userName = (String) session.getAttribute("username");
String password = (String) session.getAttribute("password");

if (userType == null || !userType.equals("admin")) {
    response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    return;
} else if (userName == null || password == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    return;
}

TransService transactionService = new TransServiceImpl();
List<TransactionBean> transactionList = transactionService.getAllTransactions();

// Handle refund action
String action = request.getParameter("action");
String transactionId = request.getParameter("transactionId");
String refundMessage = "";

if ("refund".equals(action) && transactionId != null) {
    refundMessage = transactionService.refundTransaction(transactionId);
    // Reload the transaction list after refund
    transactionList = transactionService.getAllTransactions();
}
%>

<%@ include file="adminheader.jsp" %>
<div class="content">
    <div class="table-container">
        <h2 class="text-center" style="color: black; font-size: 24px; font-weight: bold;">Transaction List</h2>
        
        <% if (!refundMessage.isEmpty()) { %>
            <div class="alert alert-success">
			<strong>Info:</strong>
			<%= refundMessage %></div>
        <% } %>
        
        <!-- Transaction Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead style="background-color: #b341ab; color: white; font-size: 18px;">
                    <tr>
                        <th>Transaction ID</th>
                        <th>User Name</th>
                        <th>Amount</th>
                        <th>Date Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody style="background-color: #f1cdf6; font-size: 16px;">
                    <% for (TransactionBean transaction : transactionList) { %>
                    <tr>
                        <td><%= transaction.getTransactionId() %></td>
                        <td><%= transaction.getUserName() %></td>
                        <td><%= transaction.getTransAmount() %></td>
                        <td><%= transaction.getTransDateTime() %></td>
                        <td><%= transaction.getStatus() %></td>
                        <td>
                            <% if (!"refunded".equals(transaction.getStatus())) { %>  
                                <form action="" method="get" style="display:inline;">
                                    <input type="hidden" name="transactionId" value="<%= transaction.getTransactionId() %>">
                                    <button type="submit" name="action" value="refund" class="btn btn-warning">
                                        Refund
                                    </button>
                                </form>
                            <% } %>  
                        </td>
                    </tr>
                    <% } %>
                    <% if (transactionList.size() == 0) { %>
                        <tr style="background-color: rgba(255, 0, 0, 0.704); color: white;">
                            <td colspan="6" style="text-align: center;">No Transactions Available</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="footer">
    <p>NamasteMart &copy; 2024. All Rights Reserved.</p>
</div>
</body>
</html>