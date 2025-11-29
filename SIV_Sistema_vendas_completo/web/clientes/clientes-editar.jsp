
<%@ page import="model.Cliente" %>
<%
 Cliente c = (Cliente) request.getAttribute("cliente");
%>
<h2>Editar Cliente</h2>
<form action="../ClienteServlet" method="post">
  <input type="hidden" name="id" value="<%=c.getId()%>">
  Nome: <input type="text" name="nome" value="<%=c.getNome()%>"><br>
  Email: <input type="text" name="email" value="<%=c.getEmail()%>"><br>
  Telefone: <input type="text" name="telefone" value="<%=c.getTelefone()%>"><br>
  <button type="submit">Salvar</button>
</form>
<a href="clientes-listar.jsp">Voltar</a>
