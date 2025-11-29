
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,model.Funcionario" %>
<%
 java.util.List<Funcionario> lista = (java.util.List<Funcionario>) request.getAttribute("lista");
%>
<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Funcionários</h2>
    <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary btn-sm">Voltar ao painel</a>
  </div>
<a href="funcionarios-add.jsp">Novo Funcionário</a> | <a href="../dashboard.jsp">Voltar</a>
<table border="1">
<tr><th>ID</th><th>Nome</th><th>Cargo</th><th>Salário</th><th>Imagem</th></tr>
<% if (lista != null) for (Funcionario f : lista) { %>
<tr>
  <td><%=f.getId()%></td>
  <td><%=f.getNome()%></td>
  <td><%=f.getCargo()%></td>
  <td><%=f.getSalario()%></td>
  <td><%=f.getImagem()%></td>
</tr>
<% } %>
</table>
