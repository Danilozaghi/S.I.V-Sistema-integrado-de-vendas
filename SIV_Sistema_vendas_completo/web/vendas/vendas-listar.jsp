<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,model.Venda" %>
<%
  List<Venda> lista = (List<Venda>) request.getAttribute("lista");
  if (lista == null) lista = new java.util.ArrayList<>();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Vendas - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Vendas</h2>
    <div>
      <a href="<%=request.getContextPath()%>/venda-edit" class="btn btn-primary btn-sm">Nova Venda</a>
      <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
    </div>
  </div>
  <div class="card shadow-sm">
    <div class="card-body p-0">
      <table class="table table-striped table-hover mb-0">
        <thead>
          <tr>
            <th>#</th>
            <th>Cliente</th>
            <th>Produto</th>
            <th>Funcionário</th>
            <th>Data</th>
            <th>Quantidade</th>
            <th>Total (R$)</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
        <% for (Venda v : lista) { %>
          <tr>
            <td><%=v.getId()%></td>
            <td><%=v.getClienteNome()%></td>
            <td><%=v.getProdutoNome()%></td>
            <td><%=v.getFuncionarioVendaNome()%></td>
            <td><%=v.getDataVenda()%></td>
            <td><%=v.getQuantidade()%></td>
            <td><%=String.format(java.util.Locale.US, "%.2f", v.getTotal())%></td>
            <td class="text-nowrap">
              <a href="<%=request.getContextPath()%>/venda-edit?id=<%=v.getId()%>" class="btn btn-sm btn-outline-secondary">Editar</a>
              <a href="<%=request.getContextPath()%>/venda-pedido?id=<%=v.getId()%>" class="btn btn-sm btn-info">Pedido</a>
              <a href="<%=request.getContextPath()%>/venda-delete?id=<%=v.getId()%>"
                 class="btn btn-sm btn-danger"
                 onclick="return confirm('Excluir esta venda?');">Excluir</a>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>
      <% if (lista.isEmpty()) { %>
        <p class="text-muted m-3">Nenhuma venda registrada.</p>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>
