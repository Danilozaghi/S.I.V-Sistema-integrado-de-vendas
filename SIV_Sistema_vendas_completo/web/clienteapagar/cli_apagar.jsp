<%-- 
    Document   : cliente apagar
    Created on : 09 de set. de 2025, 21:12:36
    Author     : alunocmc
--%>

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
            <h2>Controle de Clientes - Apagar</h2>
            <%
                //Instância do objeto                        
                int id = Integer.parseInt( request.getParameter("ident"));

                //Excluir
                ClienteDAO cliDAO = new ClienteDAO();
                if (cliDAO.excluir(id)) {
                    out.println("<br> Cliente excluído com sucesso!!!");
                }else{
                    out.println("<br> Cliente não excluído!");            
                }

            %>
        </div>
    </body>
</html>
