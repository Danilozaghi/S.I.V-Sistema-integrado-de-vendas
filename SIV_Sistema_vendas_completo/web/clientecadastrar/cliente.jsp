<%-- 
    Document   : cliente
    Created on : 21 de ago. de 2025, 21:12:36
    Author     : alunocmc
--%>

<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page import="java.text.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
        <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
            <h2>Controle de Clientes</h2>
            <%
                //Instância do objeto
                Cliente cli = new Cliente();

                cli.setId(Integer.parseInt( request.getParameter("ident")));
                cli.setNome(request.getParameter("cliente"));
                cli.setEmail(request.getParameter("email"));
                cli.setRenda(Float.parseFloat(request.getParameter("renda"))); 
                cli.setCelular(request.getParameter("celular"));
                                                        //    .parse - Texto p/ data.
                cli.setNasc(new SimpleDateFormat("yyyy-MM-dd").parse( request.getParameter("nascimento")));
                
                //Sáida
                out.println("Identificador....: " + cli.getId());
                out.println("<br>Nome do Cliente: " + cli.getNome());
                out.println("<br>E-mail.........: " + cli.getEmail());            
                out.println("<br>Renda..........: " + cli.getRenda()); 
                out.println("<br>Celular........: " + cli.getCelular()); 
                out.println("<br>Nascimento.....: " + cli.getNasc()); 

                //Salvar
                ClienteDAO cliDAO = new ClienteDAO();
                if (cliDAO.cadastrar(cli)) {
                    out.println("<br> Cliente inserido com sucesso!!!");
                }else{
                    out.println("<br> Cliente inserido não cadastrado!");            
                }

            %>
            <p> <button onclick="document.location='../'" class="voltar-btn">Voltar</button> </p>
        </div>
    </body>
</html>
