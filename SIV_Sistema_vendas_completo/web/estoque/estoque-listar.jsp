<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,model.Estoque" %>
<%
    List<Estoque> lista = (List<Estoque>) request.getAttribute("lista");
    if (lista == null) lista = new ArrayList<>();

    double totalCompras = 0.0; // ENTRADA
    double totalVendas  = 0.0; // SAIDA

    for (Estoque e : lista) {
        double totalMov = e.getPreco() * e.getQuantidade();
        if (e.getTipo() != null && e.getTipo().equalsIgnoreCase("ENTRADA")) {
            totalCompras += totalMov;
        } else if (e.getTipo() != null && e.getTipo().equalsIgnoreCase("SAIDA")) {
            totalVendas += totalMov;
        }
    }
    double caixa = totalVendas - totalCompras;
    boolean caixaPositivo = caixa >= 0;
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Estoque / Caixa - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Estoque &amp; Caixa</h2>
    <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">
      Voltar ao painel
    </a>
  </div>

  <div class="row g-3 mb-4">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h6 class="card-title mb-1">Total em Compras</h6>
          <p class="mb-0 text-muted small">(entradas de estoque)</p>
          <h4 class="mt-2 mb-0">R$ <%=String.format(java.util.Locale.US, "%.2f", totalCompras)%></h4>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h6 class="card-title mb-1">Total em Vendas</h6>
          <p class="mb-0 text-muted small">(saídas de estoque)</p>
          <h4 class="mt-2 mb-0">R$ <%=String.format(java.util.Locale.US, "%.2f", totalVendas)%></h4>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h6 class="card-title mb-1">Caixa</h6>
          <p class="mb-0 text-muted small">Vendas - Compras</p>
          <h4 class="mt-2 mb-1 <%=caixaPositivo ? "text-success" : "text-danger"%>">
            <%=caixaPositivo ? "+" : "-"%> R$
            <%=String.format(java.util.Locale.US, "%.2f", Math.abs(caixa))%>
          </h4>
          <span class="badge <%=caixaPositivo ? "bg-success" : "bg-danger"%>">
            <%=caixaPositivo ? "Positivo" : "Negativo"%>
          </span>
        </div>
      </div>
    </div>
  </div>

  <div class="card shadow-sm">
    <div class="card-body">
      <h5 class="card-title mb-3">Movimentações de estoque</h5>
      <table class="table table-striped table-sm align-middle">
        <thead>
        <tr>
          <th>#</th>
          <th>ID Produto</th>
          <th>Tipo</th>
          <th>Quantidade</th>
          <th>Data</th>
          <th>Preço unitário (R$)</th>
          <th>Total mov. (R$)</th>
        </tr>
        </thead>
        <tbody>
        <% for (Estoque e : lista) {
             double totalMov = e.getPreco() * e.getQuantidade();
        %>
          <tr>
            <td><%=e.getId()%></td>
            <td><%=e.getProdutoId()%></td>
            <td>
              <% if (e.getTipo() != null && e.getTipo().equalsIgnoreCase("ENTRADA")) { %>
                Compras
              <% } else if (e.getTipo() != null && e.getTipo().equalsIgnoreCase("SAIDA")) { %>
                Vendas
              <% } else { %>
                <%=e.getTipo()%>
              <% } %>
            </td>
            <td><%=e.getQuantidade()%></td>
            <td><%=e.getDataMov()%></td>
            <td>R$ <%=String.format(java.util.Locale.US, "%.2f", e.getPreco())%></td>
            <td>R$ <%=String.format(java.util.Locale.US, "%.2f", totalMov)%></td>
          </tr>
        <% } %>
        </tbody>
      </table>
      <% if (lista.isEmpty()) { %>
        <p class="text-muted mb-0">Nenhuma movimentação registrada ainda.</p>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>
