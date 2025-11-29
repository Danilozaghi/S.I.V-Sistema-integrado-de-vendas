<%-- 
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
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
