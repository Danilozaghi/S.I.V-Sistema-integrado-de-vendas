<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Fornecedor,model.Produto" %>
<%@ page import="model.DAO.FornecedorDAO,model.DAO.ProdutoDAO" %>
<%
    FornecedorDAO fornecedorDAO = new FornecedorDAO();
    ProdutoDAO produtoDAO = new ProdutoDAO();
    List<Fornecedor> fornecedores = fornecedorDAO.listar();
    List<Produto> produtos = produtoDAO.listar();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Nova Compra - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <h2 class="mb-3">Nova Compra (entrada de mercadoria)</h2>
  <div class="card shadow-sm">
    <div class="card-body">
      <form action="<%=request.getContextPath()%>/CompraServlet" method="post" class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Fornecedor</label>
          <select name="fornecedorId" class="form-select" required>
            <option value="">Selecione...</option>
            <% for (Fornecedor f : fornecedores) { %>
              <option value="<%=f.getId()%>"><%=f.getNome()%> - <%=f.getCnpj()%></option>
            <% } %>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Produto</label>
          <select name="produtoId" class="form-select" required>
            <option value="">Selecione...</option>
            <% for (Produto p : produtos) { %>
              <option value="<%=p.getId()%>"><%=p.getNome()%></option>
            <% } %>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Data da Compra</label>
          <input type="date" name="dataCompra" class="form-control" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Quantidade</label>
          <input type="number" name="quantidade" class="form-control" min="1" value="1" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Preço unitário (R$)</label>
          <input type="number" step="0.01" min="0" name="precoUnitario" class="form-control" required>
        </div>
        <div class="col-12">
          <button type="submit" class="btn btn-primary">Salvar Compra</button>
          <a href="<%=request.getContextPath()%>/CompraServlet" class="btn btn-secondary">Cancelar</a>
          <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-link">Voltar ao painel</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>