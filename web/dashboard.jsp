<%-- 
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
--%>



<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Cliente,model.Produto,model.Funcionario,model.Fornecedor,model.Venda,model.Compra,model.Estoque" %>
<%@ page import="model.DAO.ClienteDAO,model.DAO.ProdutoDAO,model.DAO.FuncionarioDAO,model.DAO.FornecedorDAO,model.DAO.VendaDAO,model.DAO.CompraDAO,model.DAO.EstoqueDAO" %>
<%
 HttpSession s = request.getSession(false);
 if (s == null || s.getAttribute("usuarioLogado") == null) {
    response.sendRedirect("login.jsp");
    return;
 }
 String usuario = (String) s.getAttribute("usuarioLogado");

 ClienteDAO clienteDAO = new ClienteDAO();
 ProdutoDAO produtoDAO = new ProdutoDAO();
 FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
 FornecedorDAO fornecedorDAO = new FornecedorDAO();
 VendaDAO vendaDAO = new VendaDAO();
 CompraDAO compraDAO = new CompraDAO();
 EstoqueDAO estoqueDAO = new EstoqueDAO();

 List<Cliente> clientes = clienteDAO.listarTodos();
 List<Produto> produtos = produtoDAO.listarTodos();
 List<Funcionario> funcionarios = funcionarioDAO.listarTodos();
 List<Fornecedor> fornecedores = fornecedorDAO.listar();
 List<Venda> vendas = vendaDAO.listar();
 List<Compra> compras = compraDAO.listar();
 List<Estoque> movimentos = estoqueDAO.listar();

 boolean temDados = !clientes.isEmpty() || !produtos.isEmpty() || !funcionarios.isEmpty()
     || !fornecedores.isEmpty() || !vendas.isEmpty() || !compras.isEmpty() || !movimentos.isEmpty();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Dashboard - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Dashboard.css">
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <nav class="col-md-3 col-lg-2 d-md-block sidebar p-3">
      <div class="mb-4 text-center">
        <img src="<%=request.getContextPath()%>/imagens/perfume.png"
             alt="Logo"
             style="max-width:80px; border-radius:999px; box-shadow:0 0 10px rgba(148,163,184,.5);">
        <div class="fw-bold text-light mt-2">SIV</div>
        <div class="small text-secondary">Sistema Integrado de Vendas</div>
      </div>
      <div class="mb-3 sidebar-title">Módulos</div>
      <div class="mb-3">
        <a href="<%=request.getContextPath()%>/clientes">Clientes</a>
        <a href="<%=request.getContextPath()%>/produtos">Produtos</a>
        <a href="<%=request.getContextPath()%>/funcionarios">Funcionários</a>
        <a href="<%=request.getContextPath()%>/EstoqueServlet">Estoque</a>
        <a href="<%=request.getContextPath()%>/VendaServlet">Vendas</a>
        <a href="<%=request.getContextPath()%>/FornecedorServlet">Fornecedores</a>
        <a href="<%=request.getContextPath()%>/CompraServlet">Compras</a>
      </div>
      <div class="border-top border-secondary pt-3 small text-secondary">
        Usuário: <strong><%=usuario%></strong><br/>
        <a href="<%=request.getContextPath()%>/LoginServlet" class="btn btn-sm btn-outline-light mt-2">Sair</a>
      </div>
    </nav>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h2 class="mb-0">Bem-vindo, <%=usuario%></h2>
          <p class="text-secondary mb-0">Use o menu lateral para acessar os módulos.</p>
        </div>
      </div>

      <% if (!temDados) { %>
        <div class="text-secondary">
          Nenhum registro foi inserido ainda. Assim que você começar a cadastrar clientes,
          produtos, vendas, etc., um resumo será mostrado aqui.
        </div>
      <% } else { %>

      <div class="row g-3">
        <div class="col-lg-6">
          <div class="card card-hover mb-3">
            <div class="card-body">
              <h5 class="card-title clients mb-3">
                <span class="icon">👥</span> Últimos clientes
              </h5>
              <table class="tabela">
                <thead>
                <tr>
                  <th>ID</th>
                  <th>Nome</th>
                  <th>Telefone</th>
                </tr>
                </thead>
                <tbody>
                <%
                  int count = 0;
                  for (Cliente c : clientes) {
                    if (count++ >= 5) break;
                %>
                  <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getNome()%></td>
                    <td><%=c.getTelefone()%></td>
                  </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="card card-hover mb-3">
            <div class="card-body">
              <h5 class="card-title products mb-3">
                <span class="icon">📦</span> Últimos produtos
              </h5>
              <table class="tabela">
                <thead>
                <tr>
                  <th>ID</th>
                  <th>Nome</th>
                  <th>Preço</th>
                </tr>
                </thead>
                <tbody>
                <%
                  int countP = 0;
                  for (Produto p : produtos) {
                    if (countP++ >= 5) break;
                %>
                  <tr>
                    <td><%=p.getId()%></td>
                    <td><%=p.getNome()%></td>
                    <td>R$ <%=String.format(java.util.Locale.US, "%.2f", p.getPreco())%></td>
                  </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="card card-hover mb-3">
            <div class="card-body">
              <h5 class="card-title sales mb-3">
                <span class="icon">🛒</span> Últimas vendas
              </h5>

              <table class="tabela">
                <thead>
                <tr>
                  <th>ID</th>
                  <th>Data</th>
                  <th>Total</th>
                </tr>
                </thead>
                <tbody>
                <%
                  int countV = 0;
                  for (Venda v : vendas) {
                    if (countV++ >= 5) break;
                %>
                  <tr>
                    <td><%=v.getId()%></td>
                    <td><%=v.getDataVenda()%></td>
                    <td>R$ <%=String.format(java.util.Locale.US, "%.2f", v.getTotal())%></td>
                  </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="card card-hover mb-3">
            <div class="card-body">
              <h5 class="card-title purchases mb-3">
                <span class="icon">🧾</span> Últimas compras
              </h5>
              <table class="tabela">
                <thead>
                <tr>
                  <th>ID</th>
                  <th>Data</th>
                  <th>Fornecedor</th>
                </tr>
                </thead>
                <tbody>
                <%
                  int countC = 0;
                  for (Compra c : compras) {
                    if (countC++ >= 5) break;
                %>
                  <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getDataCompra()%></td>
                    <td><%=c.getFornecedorNome()%></td>
                  </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div>
      <% } %>
    </main>
  </div>
</div>
</body>
</html>
