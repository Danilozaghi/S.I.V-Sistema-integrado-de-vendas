<%-- 
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
--%>



<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,model.Produto" %>
<%
 List<Produto> lista = (List<Produto>) request.getAttribute("lista");
 if (lista == null) lista = new ArrayList<>();
%>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Produtos - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4 bg-light">
<div class="container">
<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Produtos</h2>
    <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
  </div>
<table class="table table-striped table-sm">
<thead><tr><th>ID</th><th>Nome</th><th>Preço</th><th>Qtd</th><th>Imagem</th><th>Ações</th></tr></thead>
<tbody>
<% for (Produto p : lista) { %>
<tr>
  <td><%=p.getId()%></td>
  <td><%=p.getNome()%></td>
  <td>R$ <%=p.getPreco()%></td>
  <td><%=p.getQuantidade()%></td>
  <td><%=p.getImagem()%></td>
  <td>
    <a href="produtos-add.jsp?id=<%=p.getId()%>" class="btn btn-sm btn-outline-secondary">Editar</a>
    <a href="../ProdutoServlet?acao=excluir&id=<%=p.getId()%>" class="btn btn-sm btn-danger"
       onclick="return confirm('Excluir este produto?');">Excluir</a>
  </td>
</tr>
<% } %>
</tbody>
</table>
<a href="produtos-add.jsp" class="btn btn-primary btn-sm">Novo Produto</a>
</div>
</body>
</html>
