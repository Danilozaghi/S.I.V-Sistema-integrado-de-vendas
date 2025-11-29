<%-- 
    Document   : menu
    Created on : 21 de out. de 2025, 21:23:26
    Author     : alunocmc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Empresa</title>
    </head>
    <body>        
        <h1>Menu Principal!</h1>
        <%
            if (session.getAttribute("autorizado").equals("sim")){
                out.println("Autorização: " + session.getAttribute("autorizado"));
            }else{
                out.println("Autorização: " + session.getAttribute("autorizado"));
                response.sendRedirect("index.html");                
            }        
        
        %>
    </body>
</html>
