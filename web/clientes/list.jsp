<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cliente" %>
<%
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    if (clientes == null) clientes = new java.util.ArrayList<>();
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Clientes - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Clientes-Lista.css">
</head>
<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Clientes</h2>
    <div>
      <a href="<%=request.getContextPath()%>/cliente-edit" class="btn btn-primary btn-sm">Novo Cliente</a>
      <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
    </div>
  </div>
  <table class="tabela">
    <thead><tr><th>ID</th><th>Nome</th><th>CPF</th><th>Email</th><th>Telefone</th><th>Ações</th></tr></thead>
    <tbody>
    <% for (Cliente c : clientes) { %>
      <tr>
        <td><%=c.getId()%></td>
        <td><%=c.getNome()%></td>
        <td><%=c.getCpf()%></td>
        <td><%=c.getEmail()%></td>
        <td><%=c.getTelefone()%></td>
        <td>
          <a class="btn btn-sm btn-outline-secondary" href="<%=request.getContextPath()%>/cliente-edit?id=<%=c.getId()%>">Editar</a>
          <a class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/cliente-delete?id=<%=c.getId()%>" onclick="return confirm('Excluir?')">Excluir</a>
        </td>
      </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>