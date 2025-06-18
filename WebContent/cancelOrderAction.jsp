<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.namastemart.service.OrderService,com.namastemart.service.impl.OrderServiceImpl,com.namastemart.beans.OrderDetails,com.namastemart.utility.MailMessage" %>

<%
  //Retrive orderId from request parameters
  String orderId = request.getParameter("orderId");
  
  //Retrive other details from form or session if needed
  String accountNumber = request.getParameter("accountNumber");
  String bank = request.getParameter("bank");
  String ifscCode = request.getParameter("ifscCode");
  
  OrderService orderService = new OrderServiceImpl();
  OrderDetails orderDetails = orderService.getOrderDetailsById(orderId);
  
  String message;
  if(orderDetails != null)
  {
  try{
  //convert amount from String to double
  double refundAmount = Double.parseDouble(orderDetails.getAmount());
  boolean isCancelled = orderService.cancelOrder(orderId,accountNumber,bank,ifscCode);
  
  if(isCancelled){
  // send email notifications
  String userEmail = (String) session.getAttribute("username");
  MailMessage.orderCancelled(userEmail,orderDetails.getProdName(),orderId,refundAmount);
  message = "Your refund request has been received.It will Process Shortly."

}else{
message = "Failed to cancel the order.Please try again";
}

}catch(NumberFormatException e){
message = "Error processing the refund amount.please contact Support.";
}

}else{
message = "Order not Found"; 
}

//Set the message Attribute and forward to a confirmation page
request.setAttribute("message",message);
request.getRequestDispatcher("orderCancelConfirmation.jsp").forward(request,response);

%> 