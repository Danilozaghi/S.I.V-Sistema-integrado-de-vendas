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
        
        <style>
            body {
              font-family: 'Roboto', sans-serif;
              background-color: #f4f6f9;
              margin: 0;
              padding: 0;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 100vh;
            }

            .container {
              background-color: #fff;
              padding: 30px 40px;
              border-radius: 8px;
              box-shadow: 0 4px 12px rgba(0,0,0,0.1);
              width: 100%;
              max-width: 600px;
            }

            h2 {
              margin-bottom: 20px;
              color: #1a73e8;
              font-size: 24px;
              text-align: center;
            }

            label {
              display: block;
              margin-bottom: 6px;
              font-weight: 500;
              color: #1B68B5;
            }

            input[type="text"], input[type="email"],
            input[type="number"] {
              width: 100%;
              padding: 10px;
              margin-bottom: 20px;
              border: 1px solid #dcdfe3;
              border-radius: 4px;
              font-size: 16px;
              transition: border-color 0.3s;
            }

            input:focus {
              border-color: #1a73e8;
              outline: none;
            }

            .buttons {
              display: flex;
              justify-content: space-between;
            }

            button {
              padding: 10px 20px;
              font-size: 16px;
              border: none;
              border-radius: 4px;
              cursor: pointer;
              transition: background-color 0.3s;
            }

            .submit-btn {
              background-color: #1a73e8;
              color: white;
            }

            .submit-btn:hover {
              background-color: #155ab6;
            }

            .reset-btn {
              background-color: #e0e0e0;
              color: #333;
            }

            .reset-btn:hover {
              background-color: #c2c2c2;
            }
          </style>        
        
    </head>
    <body>
        <div class="container">
            <h2>Consulta de Clientes - Lista Simples</h2>
            <%            
                ClienteDAO cliDAO = new ClienteDAO();
                List<Cliente> lst = new ArrayList();         
                lst = cliDAO.consulta_geral();

                out.println("<br><br> <b>Identificador | Nome do Cliente | E-mail | Renda </b>" );
                //out.println("<br><br> <b>Identificador; Nome do Cliente; E-mail; Renda </b>" );
                int n_reg = 0;
                for (int i=0; i<=lst.size()-1; i++){
                    out.println("<br>" + lst.get(i).getId() + " - " + lst.get(i).getNome() + " - " + lst.get(i).getEmail() + " - " + lst.get(i).getRenda()+ " - " + lst.get(i).getCelular());
                    //out.println("<br>" + lst.get(i).getId() + ";" + lst.get(i).getNome() + ";" + lst.get(i).getEmail() + "; " + lst.get(i).getRenda());
                    n_reg++;
                }

            %>
        </div>
    </body>
</html>