<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Fornecedor,model.Produto" %>
<%@ page import="model.DAO.FornecedorDAO,model.DAO.ProdutoDAO" %>
<%
    FornecedorDAO fornecedorDAO = new FornecedorDAO();
    ProdutoDAO produtoDAO = new ProdutoDAO();
    List<Fornecedor> fornecedores = fornecedorDAO.listar();
    List<Produto> produtos = produtoDAO.listarTodos();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Nova Compra - SIV</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/bootstrap.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Compra-Add.css">
</head>

<body>
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
          <select name="produtoId" class="form-select" id="produto" required>
            <option value="">Selecione...</option>
            <% for (Produto p : produtos) { %>
              <option 
                value="<%=p.getId()%>"
                data-preco="<%=p.getPreco()%>"
                data-fornecedor="<%=p.getFornecedorId()%>"
                data-estoque="<%=p.getEstoque()%>"
              >
                <%=p.getNome()%>
              </option>
            <% } %>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Data da Compra</label>
          <input type="date" name="dataCompra" class="form-control" required>
        </div>
        <div class="col-md-4">
          <label class="form-label">Quantidade</label>
          <input type="number" name="quantidade" id="quantidade" class="form-control" min="1" value="1" required onkeypress="return false;">

        </div>
        <div class="col-md-4">
          <label class="form-label">Estoque atual</label>
          <input type="number" id="estoqueAtual" class="form-control" readonly>
        </div>
        <div class="col-md-4">
          <label class="form-label">Preço unitário (R$)</label>
          <input type="number" step="0.01" min="0" id="precoUnitario" name="precoUnitario" class="form-control" required readonly>
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

        
        
<script>
document.addEventListener("DOMContentLoaded", () => {
    const fornecedorSelect = document.querySelector("select[name='fornecedorId']");
    const produtoSelect = document.querySelector("#produto");
    const inputPreco = document.querySelector("#precoUnitario");
    const inputQtd = document.querySelector("#quantidade");
    const inputEstoque = document.querySelector("#estoqueAtual");
    const todasOpcoesProduto = Array.from(produtoSelect.querySelectorAll("option[data-fornecedor]"));
    fornecedorSelect.addEventListener("change", function () {
        const fornecedorId = this.value;
        produtoSelect.innerHTML = '<option value="">Selecione...</option>';
        inputPreco.value = "";
        inputQtd.value = 1;
        inputQtd.removeAttribute("max");
        inputQtd.placeholder = "";
        inputEstoque.value = "";
        if (!fornecedorId) return;
        todasOpcoesProduto.forEach(opt => {
            if (opt.dataset.fornecedor == fornecedorId) {
                produtoSelect.appendChild(opt.cloneNode(true));
            }
        });
    });
    produtoSelect.addEventListener("change", function () {
        const opt = this.selectedOptions[0];
        if (!opt || !opt.value) return;
        const preco = opt.dataset.preco;
        const estoque = opt.dataset.estoque;
        inputPreco.value = preco;
        inputQtd.max = estoque;
        inputQtd.placeholder = "Máx: " + estoque;
        inputEstoque.value = estoque;
        if (parseInt(inputQtd.value) > parseInt(estoque)) {
            inputQtd.value = estoque;
        }
    });
});
</script>
</body>
</html>
