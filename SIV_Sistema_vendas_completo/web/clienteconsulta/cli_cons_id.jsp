<%-- 
    Document   : cliente consulta geral
    Created on : 04 de set. de 2025, 
    Author     : Adilson Lima   
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
            <h2>Consulta de Clientes - Geral</h2>
            <%            
                Cliente cli = new Cliente();
                ClienteDAO cliDAO = new ClienteDAO();            

                cli.setId(Integer.parseInt(request.getParameter("ident")));            
                cli = cliDAO.consulta_id(cli); // Chamada da consulta por ID.
                if (cli == null){
                    out.println("Cliente não localizado!");
                }else{
                    //Foto
                    out.println("<img src=" + cli.getUrl_imagem() + ">");
                
                    out.println("<br><br>Identificador....: " + cli.getId());
                    out.println("<br>Nome do Cliente: " + cli.getNome());
                    out.println("<br>E-mail.........: " + cli.getEmail());            
                    out.println("<br>Renda..........: " + cli.getRenda()); 
                    out.println("<br>Celular........: " + cli.getCelular()); 
                                                                                            // .format - Data p/ texto.
                    out.println("<br>Nascimento.....: " + new SimpleDateFormat("dd/MMMM/yyyy").format(cli.getNasc())); 
                }

            %>
        </div>
    </body>
</html>