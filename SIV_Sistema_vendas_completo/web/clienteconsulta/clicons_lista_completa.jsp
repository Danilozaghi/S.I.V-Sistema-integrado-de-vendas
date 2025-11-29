<%-- 
    Document   : cliente consulta geral
    Created on : 02 de set. de 2025, 
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
        <link href="../style_css/relatrio2.css" rel="stylesheet" type="text/css"/>   
        
    </head>
    <body>
        <div class="container">
            <h2>Consulta de Clientes - Lista Completa</h2>
            <%            
                ClienteDAO cliDAO = new ClienteDAO();
                List<Cliente> lst = new ArrayList();         
                lst = cliDAO.consulta_geral();
            %>
            <table borde="1">
                <tr>
                    <th>Identificador</th>
                    <th>Nome do Cliente</th>
                    <th>E-mail</th>
                    <th>Renda</th>
                    <th>Celular</th>
                    <th>Alterar</th>
                    <th>Consultar</th>
                    <th>Apagar</th>                                      
                </tr>

            <%    
                int n_reg = 0;
                for (int i=0; i<=lst.size()-1; i++){
            %>        
                <tr>
                    <td><%=lst.get(i).getId()%></td>
                    <td><%=lst.get(i).getNome()%></td>
                    <td><%=lst.get(i).getEmail()%></td>
                    <td><%=lst.get(i).getRenda()%></td>
                    <td><%=lst.get(i).getCelular()%></td>
                    <td><a href="../clientealterar/cli_cons_alt.jsp?ident=<%=lst.get(i).getId()%>">📝</a></td>                
                    <td><a href="../clienteconsulta/cli_cons_id.jsp?ident=<%=lst.get(i).getId()%>">🔍</a></td>                
                    <td><a href="../clienteapagar/cli_apagar.jsp?ident=<%=lst.get(i).getId()%>">🔥</a></td>                
                </tr>
            <%
                    n_reg++;
                }

            %>
            <tfoot>
                <tr>
                    <th>Registros</th>
                    <th><%=n_reg%></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </tfoot>

            </table>
        </div>
    </body>
</html>