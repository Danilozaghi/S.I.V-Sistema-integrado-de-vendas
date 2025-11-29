<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Novo Fornecedor - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Novo Fornecedor</h2>
    <a href="<%=request.getContextPath()%>/FornecedorServlet" class="btn btn-outline-secondary btn-sm">Voltar</a>
  </div>
  <div class="card shadow-sm">
    <div class="card-body">
      <form action="../FornecedorServlet" method="post" class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Nome</label>
          <input type="text" name="nome" class="form-control" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">CNPJ</label>
          <input type="text" name="cnpj" class="form-control" placeholder="00.000.000/0000-00">
        </div>
        <div class="col-12">
          <button type="submit" class="btn btn-primary">Salvar</button>
          <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-link">Voltar ao painel</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
