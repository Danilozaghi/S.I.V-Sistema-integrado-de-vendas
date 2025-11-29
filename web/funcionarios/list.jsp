<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Funcionario" %>
<%
    List<Funcionario> funcionarios = (List<Funcionario>) request.getAttribute("funcionarios");
    if (funcionarios == null) funcionarios = new java.util.ArrayList<>();
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Funcionários - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Funcionarios-Lista.css">
</head>
<body class="p-4">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Funcionários</h2>
    <div>
      <a href="<%=request.getContextPath()%>/funcionario-edit" class="btn btn-primary btn-sm">Novo Funcionário</a>
      <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
    </div>
  </div>
  <table class="tabela">
    <thead>
      <tr>
        <th>Foto</th>
        <th>ID</th>
        <th>Nome</th>
        <th>Cargo</th>
        <th>Email</th>
        <th>Telefone</th>
        <th>Ações</th>
      </tr>
    </thead>
    <tbody>
    <% for (Funcionario f : funcionarios) { %>
      <tr>
        <td>
          <% if (f.getImagem() != null && !f.getImagem().isEmpty()) { %>
            <img src="<%=request.getContextPath()%>/<%=f.getImagem()%>"
                 alt="Foto"
                 style="width:60px;height:60px;object-fit:cover;border-radius:50%;">
          <% } else { %>
            -
          <% } %>
        </td>
        <td><%=f.getId()%></td>
        <td><%=f.getNome()%></td>
        <td><%=f.getCargo()%></td>
        <td><%=f.getEmail()%></td>
        <td><%=f.getTelefone()%></td>
        <td>
          <a class="btn btn-sm btn-outline-secondary"
             href="<%=request.getContextPath()%>/funcionario-edit?id=<%=f.getId()%>">Editar</a>
          <a class="btn btn-sm btn-danger"
             href="<%=request.getContextPath()%>/funcionario-delete?id=<%=f.getId()%>"
             onclick="return confirm('Excluir este funcionário?')">
             Excluir
          </a>
        </td>
      </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
