<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,model.Fornecedor,model.DAO.FornecedorDAO" %>

<%
    FornecedorDAO fdao = new FornecedorDAO();
    List<Fornecedor> fornecedores = fdao.listar();
%>

<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Novo Produto - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Produto-Add.css">
</head>

<body>
<div class="container">

  <h2 class="mb-3">Novo Produto</h2>

  <div class="card shadow-sm">
    <div class="card-body">

      <form action="../ProdutoServlet" method="post" enctype="multipart/form-data" class="row g-3">

        <!-- Nome -->
        <div class="col-md-6">
          <label class="form-label">Nome</label>
          <input type="text" 
                 name="nome" 
                 class="form-control"
                 required
                 oninput="this.value = this.value.replace(/[0-9]/g, '')">
        </div>

        <!-- Fornecedor -->
        <div class="col-md-6">
          <label class="form-label">Fornecedor</label>
          <select name="fornecedorId" class="form-select" required>
            <option value="">Selecione...</option>
            <% for (Fornecedor f : fornecedores) { %>
                <option value="<%=f.getId()%>"><%=f.getNome()%> - <%=f.getCnpj()%></option>
            <% } %>
          </select>
        </div>

        <!-- Descrição -->
        <div class="col-md-12">
          <label class="form-label">Descrição</label>
          <textarea name="descricao" class="form-control" rows="3"></textarea>
        </div>

        <!-- Preço -->
        <div class="col-md-4">
          <label class="form-label">Preço</label>
          <input type="text" 
                 name="preco"
                 id="preco"
                 class="form-control"
                 required>
        </div>

        <!-- Estoque -->
        <div class="col-md-4">
          <label class="form-label">Estoque</label>
          <input type="number" 
                 name="estoque" 
                 class="form-control"
                 min="0"
                 required>
        </div>

        <!-- Foto -->
        <div class="col-md-4">
          <label class="form-label">Imagem</label>
          <input type="file" name="imagem" class="form-control">
        </div>

        <!-- Botões -->
        <div class="col-12">
          <button type="submit" class="btn btn-primary">Salvar</button>
          <a href="produtos-listar.jsp" class="btn btn-secondary">Cancelar</a>
        </div>

      </form>

    </div>
  </div>

</div>

<script>
document.getElementById("preco").addEventListener("input", function () {
    let valor = this.value.replace(/\D/g, "");
    if (valor.length === 0) {
        this.value = "";
        return;
    }
    valor = (parseInt(valor) / 100).toFixed(2);
    valor = valor.replace(".", ",");
    this.value = valor;
});
</script>

</body>
</html>
