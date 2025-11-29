<%-- 
    Document   : cliente
    Created on : 21 de ago. de 2025, 21:12:36
    Author     : alunocmc
--%>

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
        <h2>Controle de Clientes - Alterar</h2>
        <%
            //Instância do objeto
            Cliente cli = new Cliente();
            
            cli.setId(Integer.parseInt( request.getParameter("ident")));
            cli.setNome(request.getParameter("cliente"));
            cli.setEmail(request.getParameter("email"));
            cli.setRenda(Float.parseFloat(request.getParameter("renda")));            
            cli.setCelular(request.getParameter("celular"));
            
            //Sáida
            out.println("Identificador....: " + cli.getId());
            out.println("<br>Nome do Cliente: " + cli.getNome());
            out.println("<br>E-mail.........: " + cli.getEmail());            
            out.println("<br>Renda..........: " + cli.getRenda()); 
            out.println("<br>Celular........: " + cli.getCelular()); 

            //Salvar a Alteração
            ClienteDAO cliDAO = new ClienteDAO();
            if (cliDAO.alterar(cli)) {
                out.println("<br> Cliente alterado com sucesso!!!");
            }else{
                out.println("<br> Cliente alterado não cadastrado!");            
            }
            
        %>
        </div>
    </body>
</html>
