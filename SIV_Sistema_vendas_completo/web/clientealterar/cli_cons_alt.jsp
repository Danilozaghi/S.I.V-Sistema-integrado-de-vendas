<%-- 
    Document   : cliente consulta geral
    Created on : 04 de set. de 2025, 
    Author     : Adilson Lima   
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
        <link href="../style_css/geral.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
        <h2>Alterar Clientes</h2>
        <%            
            Cliente cli = new Cliente();
            ClienteDAO cliDAO = new ClienteDAO();            
          
            cli.setId(Integer.parseInt(request.getParameter("ident")));            
            cli = cliDAO.consulta_id(cli); // Chamada da consulta por ID.
            if (cli == null){
                out.println("Cliente não localizado!");                                   
            }else{
        %>
                <form method="post" action="cli_alt.jsp">
                    Identificador: <input type="number" name="ident" value="<%=cli.getId()%>" readonly="true"> <p>
                    Nome do Cliente: <input type="text" name="cliente" value="<%=cli.getNome()%>"> <p>
                    E-mail: <input type="email" name="email" value="<%=cli.getEmail()%>"> <p>                
                    Renda: <input type="number" name="renda" step="0.05" value="<%=cli.getRenda()%>"> <p>
                    Celular: <input type="text" name="celular" value="<%=cli.getCelular()%>"> <p>                
                        
                    <div class="buttons">
                        <button type="submit" class="submit-btn">Salvar Alteração</button>
                    </div>                                        
                </form> 
        <%    
            }                                 
        %>
        </div>
    </body>
</html>