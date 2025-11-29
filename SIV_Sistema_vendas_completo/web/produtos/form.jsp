<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Produto" %>
<%
    Produto p = (Produto) request.getAttribute("produto");
    if (p == null) p = new Produto();
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Produto - Form</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4">
<div class="container">
  <h2><%= p.getId() == 0 ? "Novo Produto" : "Editar Produto" %></h2>
  <form method="post" action="<%=request.getContextPath()%>/produto-save">
    <input type="hidden" name="id" value="<%=p.getId()%>" />
    <div class="mb-3"><label class="form-label">Nome</label><input class="form-control" name="nome" value="<%=p.getNome()%>" required /></div>
    <div class="mb-3"><label class="form-label">Descrição</label><textarea class="form-control" name="descricao"><%=p.getDescricao()%></textarea></div>
    <div class="mb-3"><label class="form-label">Preço</label><input class="form-control" name="preco" value="<%=p.getPreco()%>" required /></div>
    <div class="mb-3"><label class="form-label">Estoque</label><input class="form-control" name="estoque" value="<%=p.getEstoque()%>" required /></div>
    <button class="btn btn-primary" type="submit">Salvar</button>
    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/produtos">Cancelar</a>
  </form>
</div>
</body>
</html>