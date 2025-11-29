<%-- 
    Document   : cliente consulta por nome
    Created on : 09 de set. de 2025, 
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
            <h2>Consulta de Clientes - Geral</h2>
            <%            
                ClienteDAO cliDAO = new ClienteDAO();
                List<Cliente> lst = new ArrayList();         


                String nome = request.getParameter("nome");
                lst = cliDAO.consulta_nome(nome);

                int n_reg = 0;
                for (int i=0; i<=lst.size()-1; i++){
                    out.println("<br><br>Identificador....: " + lst.get(i).getId());
                    out.println("<br>Nome do Cliente: " + lst.get(i).getNome());
                    out.println("<br>E-mail.........: " + lst.get(i).getEmail());            
                    out.println("<br>Renda..........: " + lst.get(i).getRenda()); 
                    out.println("<br>Celular........: " + lst.get(i).getCelular());
                    n_reg++;
                }

            %>
        </div>
    </body>
</html>