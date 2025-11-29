<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,model.Fornecedor" %>
<%
  List<Fornecedor> lista = (List<Fornecedor>) request.getAttribute("lista");
  if (lista == null) lista = new java.util.ArrayList<>();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Fornecedores - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Fornecedor-Lista.css">
</head>
<body>
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Fornecedores</h2>
    <div>
      <a href="<%=request.getContextPath()%>/fornecedores/fornecedores-add.jsp" class="btn btn-primary btn-sm"> Novo Fornecedor</a>
      <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
    </div>
  </div>
  <div class="card shadow-sm">
    <div class="card-body p-0">
      <table class="tabela">
        <thead>
        <tr>
          <th>#</th>
          <th>Nome</th>
          <th>CNPJ</th>
        </tr>
        </thead>
        <tbody>
        <% for (Fornecedor f : lista) { %>
          <tr>
            <td><%=f.getId()%></td>
            <td><%=f.getNome()%></td>
            <td><%=f.getCnpj()%></td>
          </tr>
        <% } %>
        </tbody>
      </table>
      <% if (lista.isEmpty()) { %>
        <p class="text-muted m-3">Nenhum fornecedor cadastrado.</p>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>
