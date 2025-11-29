
<h2>Nova Movimentação de Estoque</h2>
<form action="../EstoqueServlet" method="post">
  ID Produto: <input type="text" name="produtoId"><br>
  Tipo (ENTRADA/SAIDA): <input type="text" name="tipo"><br>
  Quantidade: <input type="text" name="quantidade"><br>
  Data (AAAA-MM-DD): <input type="text" name="dataMov"><br>
  Preço: <input type="text" name="preco"><br>
  <button type="submit">Salvar</button>
</form>
<a href="estoque-listar.jsp">Voltar</a>
