<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Novo Produto - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Novo Produto</h2>
    <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">
      Voltar ao painel
    </a>
  </div>
  <form action="../ProdutoServlet" method="post" enctype="multipart/form-data" class="row g-3">
    <div class="col-md-6">
      <label class="form-label">Nome</label>
      <input type="text" name="nome" class="form-control" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Preço</label>
      <input type="text" name="preco" class="form-control" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Quantidade</label>
      <input type="number" name="quantidade" class="form-control" required>
    </div>
    <div class="col-md-6">
      <label class="form-label">Imagem</label>
      <input type="file" name="imagem" class="form-control">
    </div>
    <div class="col-12">
      <button type="submit" class="btn btn-primary">Salvar</button>
      <a href="produtos-listar.jsp" class="btn btn-secondary">Voltar à lista</a>
    </div>
  </form>
</div>
</body>
</html>
