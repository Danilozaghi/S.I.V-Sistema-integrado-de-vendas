<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Produto" %>
<%@ page import="model.Fornecedor" %>
<%@ page import="model.DAO.FornecedorDAO" %>
<%@ page import="java.util.List" %>

<%
    Produto p = (Produto) request.getAttribute("produto");
    if (p == null) {
        p = new Produto();
    }

    FornecedorDAO fornecedorDAO = new FornecedorDAO();
    List<Fornecedor> fornecedores = fornecedorDAO.listar();

    Integer fornecedorId = p.getFornecedorId() == null ? 0 : p.getFornecedorId();
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Produto - Form</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Produto-Form.css">
</head>
<body class="p-4">
<div class="container">
  <h2><%= p.getId() == 0 ? "Novo Produto" : "Editar Produto" %></h2>
  <form method="post" action="<%=request.getContextPath()%>/produto-save">
    <input type="hidden" name="id" value="<%= p.getId() %>" />

    <div class="mb-3">
      <label class="form-label">Fornecedor</label>
      <select class="form-select"
              name="fornecedorId"
              required
              oninvalid="this.setCustomValidity('Favor selecionar um fornecedor.')"
              oninput="this.setCustomValidity('')">
        <option value="">Selecione...</option>

        <% for (Fornecedor f : fornecedores) { %>
          <option value="<%=f.getId()%>"
                  <%= (f.getId() == fornecedorId) ? "selected" : "" %>>
            <%= f.getNome() %> - <%= f.getCnpj() %>
          </option>
        <% } %>

      </select>
    </div>
        
     <div class="mb-3">
  <label class="form-label">Nome</label>
  <input class="form-control"
         name="nome"
         required
         value="<%= p.getNome() == null ? "" : p.getNome() %>"
         oninvalid="this.setCustomValidity('Favor preencher o nome do produto.')"
         oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^a-zA-ZÀ-ÿ\s]/g, '');" />
</div>
         
<div class="mb-3">
  <label class="form-label">Descrição</label>
  <textarea class="form-control"
            name="descricao"
            required
            oninvalid="this.setCustomValidity('Favor preencher a descrição do produto.')"
            oninput="this.setCustomValidity('')"><%= p.getDescricao() == null ? "" : p.getDescricao() %></textarea>
</div>

<div class="mb-3">
  <label class="form-label">Preço</label>
  <input class="form-control"
         name="preco"
         required
         value="<%= p.getPreco() == 0 ? "" : p.getPreco() %>"
         oninvalid="this.setCustomValidity('Favor informar o preço.')"
         oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9.,]/g, '');" />
</div>

<div class="mb-3">
  <label class="form-label">Estoque</label>
  <input class="form-control"
         name="estoque"
         required
         value="<%= p.getEstoque() == 0 ? "" : p.getEstoque() %>"
         oninvalid="this.setCustomValidity('Favor informar o estoque.')"
         oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9]/g, '');" />
</div>

<button class="btn btn-primary" type="submit">Salvar</button>
<a class="btn btn-secondary" href="<%=request.getContextPath()%>/produtos">Cancelar</a>

        
        
    

