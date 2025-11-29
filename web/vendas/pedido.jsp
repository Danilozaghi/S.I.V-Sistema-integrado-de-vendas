<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Venda,model.Cliente,model.Produto,model.Compra,model.Funcionario" %>
<%
    Venda venda = (Venda) request.getAttribute("venda");
    Cliente cliente = (Cliente) request.getAttribute("cliente");
    Produto produto = (Produto) request.getAttribute("produto");
    Compra ultimaCompra = (Compra) request.getAttribute("ultimaCompra");
    Funcionario funcionarioVenda = (Funcionario) request.getAttribute("funcionarioVenda");

    String telefoneCliente = "";
    if (cliente != null && cliente.getTelefone() != null) {
        telefoneCliente = cliente.getTelefone().replaceAll("\\D", "");
    }

    String valorTotalFormatado = "0,00";
    if (venda != null) {
        valorTotalFormatado = String.format(java.util.Locale.US, "%.2f", venda.getTotal());
    }
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Pedido #<%=venda != null ? venda.getId() : "" %> - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    @media print {
      .no-print { display: none !important; }
      body { background: #fff !important; }
    }
  </style>
</head>
<body class="p-4 bg-light">
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3 no-print">
    <h2>Pedido #<%=venda != null ? venda.getId() : "" %></h2>
    <div class="d-flex gap-2">
      <button type="button" class="btn btn-success btn-sm" onclick="enviarWhatsApp()">Enviar via WhatsApp</button>
      <button class="btn btn-primary btn-sm" onclick="window.print()">Imprimir</button>
      <a href="<%=request.getContextPath()%>/vendas" class="btn btn-outline-secondary btn-sm">Voltar</a>
    </div>
  </div>

  <div class="card shadow-sm">
    <div class="card-body">
      <h5 class="mb-3">Dados do Cliente</h5>
      <p class="mb-1"><strong>Nome:</strong> <%=cliente != null ? cliente.getNome() : "" %></p>
      <p class="mb-1"><strong>CPF:</strong> <%=cliente != null ? cliente.getCpf() : "" %></p>
      <p class="mb-3"><strong>Telefone:</strong> <%=cliente != null ? cliente.getTelefone() : "" %></p>

      <h5 class="mb-3">Detalhes da Venda</h5>
      <p class="mb-1"><strong>Data:</strong> <%=venda != null ? venda.getDataVenda() : "" %></p>
      <p class="mb-1"><strong>Produto:</strong> <%=produto != null ? produto.getNome() : "" %></p>
      <p class="mb-1"><strong>Quantidade:</strong> <%=venda != null ? venda.getQuantidade() : 0 %></p>
      <p class="mb-1"><strong>Valor total:</strong>
        R$ <%=valorTotalFormatado%>
      </p>

      <h5 class="mt-4 mb-3">Fornecedor / Compra</h5>
      <p class="mb-1"><strong>Fornecedor:</strong>
        <%=ultimaCompra != null ? ultimaCompra.getFornecedorNome() : "Não informado" %>
      </p>
      <p class="mb-3"><strong>Data da última compra desse produto:</strong>
        <%=ultimaCompra != null ? ultimaCompra.getDataCompra() : "" %>
      </p>

      <h5 class="mt-4 mb-3">Vendedor</h5>
      <p class="mb-1"><strong>Funcionário que realizou a venda:</strong>
        <%=venda != null ? venda.getFuncionarioVendaNome() : (funcionarioVenda != null ? funcionarioVenda.getNome() : "") %>
      </p>
      <p class="mb-0"><strong>Total de vendas no mês (funcionário):</strong>
        <%=venda != null ? venda.getTotalVendasMesFuncionario() : 0 %>
      </p>
    </div>
  </div>
</div>

<script>
  function enviarWhatsApp() {
    var telefone = "<%=telefoneCliente%>";
    if (!telefone) {
      alert("Telefone do cliente não cadastrado ou inválido.");
      return;
    }
    var mensagem = "Olá <%=cliente != null ? cliente.getNome() : "" %>,%0A%0A"
                 + "Segue o resumo do seu pedido #%3A <%=venda != null ? venda.getId() : "" %>%0A"
                 + "Produto: <%=produto != null ? produto.getNome() : "" %>%0A"
                 + "Quantidade: <%=venda != null ? venda.getQuantidade() : 0 %>%0A"
                 + "Valor total: R$ <%=valorTotalFormatado%>%0A%0A"
                 + "Obrigado pela preferência!";
    var url = "https://wa.me/" + telefone + "?text=" + mensagem;
    window.open(url, "_blank");
  }
</script>
</body>
</html>
