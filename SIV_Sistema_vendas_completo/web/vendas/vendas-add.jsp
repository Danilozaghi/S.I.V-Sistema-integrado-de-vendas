<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Venda,model.Cliente,model.Produto,model.Funcionario" %>
<%
    Venda venda = (Venda) request.getAttribute("venda");
    if (venda == null) venda = new Venda();
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
    List<Funcionario> funcionarios = (List<Funcionario>) request.getAttribute("funcionarios");
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Nova Venda - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2><%=venda.getId() == 0 ? "Nova Venda" : "Editar Venda"%></h2>
    <a href="<%=request.getContextPath()%>/vendas" class="btn btn-outline-secondary btn-sm">Voltar</a>
  </div>
  <div class="card shadow-sm">
    <div class="card-body">
      <form action="<%=request.getContextPath()%>/VendaServlet" method="post" class="row g-3">
        <input type="hidden" name="id" value="<%=venda.getId()%>"/>

        <div class="col-md-4">
          <label class="form-label">Cliente</label>
          <select name="clienteId" class="form-select" required>
            <option value="">Selecione...</option>
            <% if (clientes != null) for (Cliente c : clientes) { %>
              <option value="<%=c.getId()%>" <%=c.getId() == venda.getClienteId() ? "selected" : ""%>>
                <%=c.getNome()%>
              </option>
            <% } %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Produto</label>
          <select name="produtoId" class="form-select" required>
            <option value="">Selecione...</option>
            <% if (produtos != null) for (Produto p : produtos) { %>
              <option value="<%=p.getId()%>" <%=p.getId() == venda.getProdutoId() ? "selected" : ""%>>
                <%=p.getNome()%>
              </option>
            <% } %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Funcionário (vendedor)</label>
          <select name="funcionarioVendaId" class="form-select">
            <option value="">Selecione...</option>
            <% if (funcionarios != null) for (Funcionario f : funcionarios) { %>
              <option value="<%=f.getId()%>" <%=f.getId() == venda.getFuncionarioVendaId() ? "selected" : ""%>>
                <%=f.getNome()%>
              </option>
            <% } %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Data da Venda</label>
          <input type="date" name="dataVenda" class="form-control"
                 value="<%=venda.getDataVenda() != null ? venda.getDataVenda() : ""%>" required>
        </div>

        <div class="col-md-4">
          <label class="form-label">Quantidade</label>
          <input type="number" name="quantidade" min="1" class="form-control"
                 value="<%=venda.getQuantidade() > 0 ? venda.getQuantidade() : 1%>" required>
        </div>

        <div class="col-12">
          <button type="submit" class="btn btn-primary">Salvar Venda</button>
          <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-link">Voltar ao painel</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
