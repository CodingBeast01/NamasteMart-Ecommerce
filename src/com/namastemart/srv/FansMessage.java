package com.namastemart.srv;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.namastemart.utility.MailMessage;

@WebServlet("/fansMessage")
public class FansMessage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String comments = request.getParameter("comments");

        String htmlTextMessage = "<html><body>" +
            "<h2 style='color:green;'>Message from NamasteMart</h2>" +
            "Customer Message Received!<br/><br/>Name: " + name + ", " + 
            "<br/><br/>Email Id: " + email + "<br/><br/>" + 
            "Comment: <span style='color:grey;'>" + comments + "</span>" +
            "<br/><br/>We are glad that Customer are choosing us! <br/><br/>Thanks & " +
            "Regards<br/><br/><strong>NamasteMart Team</strong>" +
            "</body></html>";

        String message = MailMessage.sendMessage("rajsingh993590@gmail.com", 
            "Customer Message | " + name + " | " + email, htmlTextMessage);
        
        if ("SUCCESS".equals(message)) {
            message = "Comments Sent Successfully";
        } else {
            message = "Failed: Please Configure mailer.email and password in application.properties first";
        }

        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.include(request, response);
        response.getWriter().print("<script>alert('" + message + "')</script>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}