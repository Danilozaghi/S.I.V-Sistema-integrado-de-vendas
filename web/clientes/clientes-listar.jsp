
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,model.Cliente" %>
<%
 List<Cliente> lista = (List<Cliente>) request.getAttribute("lista");
%>
<head
    <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Clientes-listar.css">
<h2>Clientes</h2>
<a href="ClienteServlet?acao=novo">Novo Cliente</a> | <a href="../dashboard.jsp">Voltar</a>
<table border="1">
<tr><th>ID</th><th>Nome</th><th>Email</th><th>Telefone</th><th>Ações</th></tr>
<% if (lista != null) for (Cliente c : lista) { %>
<tr>
  <td><%=c.getId()%></td>
  <td><%=c.getNome()%></td>
  <td><%=c.getEmail()%></td>
  <td><%=c.getTelefone()%></td>
  <td>
    <a href="ClienteServlet?acao=editar&id=<%=c.getId()%>">Editar</a>
    <a href="ClienteServlet?acao=excluir&id=<%=c.getId()%>" onclick="return confirm('Excluir?')">Excluir</a>
  </td>
</tr>
<% } %>
</table>
