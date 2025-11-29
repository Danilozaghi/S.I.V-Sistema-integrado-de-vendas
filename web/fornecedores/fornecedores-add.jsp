<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Fornecedor" %>

<%
    // Mantém os valores após erro
    Fornecedor f = (Fornecedor) request.getAttribute("fornecedor");
    if (f == null) f = new Fornecedor();
%>

<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Novo Fornecedor - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Fornecedor-Add.css">
</head>
<body>
<div class="container">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Novo Fornecedor</h2>
    <a href="<%=request.getContextPath()%>/FornecedorServlet" class="btn btn-outline-secondary btn-sm">Voltar</a>
  </div>

  <!-- ⚠️ Mensagem de erro -->
  <% if (request.getAttribute("erro") != null) { %>
    <div class="alert alert-danger">
      <%= request.getAttribute("erro") %>
    </div>
  <% } %>

  <div class="card shadow-sm">
    <div class="card-body">
      <form action="../FornecedorServlet" method="post" class="row g-3">

        <div class="col-md-6">
          <label class="form-label">Nome</label>
          <input type="text"
                 name="nome"
                 class="form-control"
                 required
                 value="<%= f.getNome() == null ? "" : f.getNome() %>"
                 oninput="this.value = this.value.replace(/[0-9]/g, '')">
        </div>

        <div class="col-md-6">
          <label class="form-label">CNPJ</label>
          <input type="text"
                 name="cnpj"
                 id="cnpj"
                 maxlength="18"
                 class="form-control"
                 placeholder="00.000.000/0000-00"
                 required
                 value="<%= f.getCnpj() == null ? "" : f.getCnpj() %>">
        </div>

        <div class="col-12">
          <button type="submit" class="btn btn-primary">Salvar</button>
          <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-link">Voltar ao painel</a>
        </div>

      </form>
    </div>
  </div>
</div>

<script>
document.getElementById("cnpj").addEventListener("input", function () {

    let v = this.value.replace(/\D/g, "");

    if (v.length > 14) v = v.slice(0, 14);
    if (v.length >= 3)
        v = v.replace(/(\d{2})(\d)/, "$1.$2");
    if (v.length >= 6)
        v = v.replace(/(\d{2})\.(\d{3})(\d)/, "$1.$2.$3");
    if (v.length >= 9)
        v = v.replace(/\.(\d{3})(\d)/, ".$1/$2");
    if (v.length >= 13)
        v = v.replace(/(\d{4})(\d)/, "$1-$2");

    this.value = v;
});
</script>

</body>
</html>
