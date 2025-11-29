<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Produto" %>
<%
    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
    if (produtos == null) produtos = new java.util.ArrayList<>();
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Produtos - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Produtos</h2>
    <a href="<%=request.getContextPath()%>/produto-edit" class="btn btn-primary">Novo Produto</a>
  </div>
  <table class="table table-striped table-hover">
    <thead><tr><th>ID</th><th>Nome</th><th>Descrição</th><th>Preço</th><th>Estoque</th><th>Ações</th></tr></thead>
    <tbody>
    <% for (Produto c : produtos) { %>
      <tr>
        <td><%=c.getId()%></td>
        <td><%=c.getNome()%></td>
        <td><%=c.getDescricao()%></td>
        <td><%=String.format("%.2f", c.getPreco())%></td>
        <td><%=c.getEstoque()%></td>
        <td>
          <a class="btn btn-sm btn-outline-secondary" href="<%=request.getContextPath()%>/produto-edit?id=<%=c.getId()%>">Editar</a>
          <a class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/produto-delete?id=<%=c.getId()%>" onclick="return confirm('Excluir?')">Excluir</a>
        </td>
      </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>