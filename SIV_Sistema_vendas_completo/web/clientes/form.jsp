<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cliente" %>
<%
    Cliente c = (Cliente) request.getAttribute("cliente");
    if (c == null) c = new Cliente();
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Cliente - Form</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4">
<div class="container">
  <h2><%= c.getId() == 0 ? "Novo Cliente" : "Editar Cliente" %></h2>
  <form method="post" action="<%=request.getContextPath()%>/cliente-save">
    <input type="hidden" name="id" value="<%=c.getId()%>" />
    <div class="mb-3"><label class="form-label">Nome</label><input class="form-control" name="nome" value="<%=c.getNome()%>" required /></div>
    <div class="mb-3"><label class="form-label">CPF</label><input class="form-control" name="cpf" value="<%=c.getCpf()%>" /></div>
    <div class="mb-3"><label class="form-label">Email</label><input class="form-control" name="email" value="<%=c.getEmail()%>" /></div>
    <div class="mb-3"><label class="form-label">Telefone</label><input class="form-control" name="telefone" value="<%=c.getTelefone()%>" /></div>
    <div class="mb-3"><label class="form-label">Endereço</label><textarea class="form-control" name="endereco"><%=c.getEndereco()%></textarea></div>
    <button class="btn btn-primary" type="submit">Salvar</button>
    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/clientes">Cancelar</a>
  </form>
</div>
</body>
</html>