<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,model.Compra" %>
<%
    List<Compra> lista = (List<Compra>) request.getAttribute("lista");
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Compras - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Compra-Lista.css">

</head>
<body>
<div class="table-container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Compras</h2>
    <div>
      <a href="<%=request.getContextPath()%>/compra-add" class="btn btn-primary btn-sm">Nova Compra</a>
      <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
    </div>
  </div>
    <div class="tabela-wrapper">
      <table class="tabela">
        <thead>
          <tr>
            <th>ID</th>
            <th>Fornecedor</th>
            <th>Produto</th>
            <th>Data</th>
            <th>Quantidade</th>
            <th>Preço Unitário</th>
            <th>Valor Total</th>
          </tr>
        </thead>
        <tbody>
        <% if (lista != null) for (Compra c : lista) { %>
          <tr>
            <td><%=c.getId()%></td>
            <td><%=c.getFornecedorNome()%></td>
            <td><%=c.getProdutoNome()%></td>
            <td><%=c.getDataCompra()%></td>
            <td><%=c.getQuantidade()%></td>
            <td>R$ <%=String.format(java.util.Locale.US, "%.2f", c.getPrecoUnitario())%></td>
            <td>R$ <%=String.format(java.util.Locale.US, "%.2f", c.getValorTotal())%></td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>