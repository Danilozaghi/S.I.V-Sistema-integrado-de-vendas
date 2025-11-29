<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cliente" %>
<%
    Cliente c = (Cliente) request.getAttribute("cliente");
    if (c == null) {
        c = new Cliente();
    }
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Cliente - Form</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Clientes-form.css">
</head>
<body class="p-4">
<div class="container">
  <h2><%= c.getId() == 0 ? "Novo Cliente" : "Editar Cliente" %></h2>
  <% if (request.getAttribute("erro") != null) { %>
      <div style="background:#ff4d4d; 
                  padding:12px; 
                  color:white; 
                  border-radius:8px; 
                  margin-bottom:18px; 
                  font-weight:bold;
                  text-align:center;
                  box-shadow:0 0 10px rgba(255,70,70,0.5);">
        <%= request.getAttribute("erro") %>
      </div>
  <% } %>
  <form method="post" action="<%=request.getContextPath()%>/cliente-save">
    <input type="hidden" name="id" value="<%=c.getId()%>" />

    <div class="mb-3">
      <label class="form-label">Nome</label>
      <input class="form-control"
             name="nome"
             required
             value="<%= c.getNome() == null ? "" : c.getNome() %>"
             oninvalid="this.setCustomValidity('Favor preencher o nome do cliente.')"
             oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^a-zA-ZÀ-ÿ\s]/g, '');" />
    </div>

    <div class="mb-3">
      <label class="form-label">CPF</label>
      <input class="form-control"
             name="cpf"
             required
             maxlength="11"
             value="<%= c.getCpf() == null ? "" : c.getCpf() %>"
             oninvalid="this.setCustomValidity('Favor preencher o CPF.')"
             oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9]/g, '');" />
    </div>

    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email"
             class="form-control"
             name="email"
             required
             value="<%= c.getEmail() == null ? "" : c.getEmail() %>"
             oninvalid="this.setCustomValidity('Favor informar um email válido.')"
             oninput="this.setCustomValidity('')" />
    </div>

    <div class="mb-3">
      <label class="form-label">Telefone</label>
      <input class="form-control"
             name="telefone"
             required
             maxlength="11"
             value="<%= c.getTelefone() == null ? "" : c.getTelefone() %>"
             oninvalid="this.setCustomValidity('Favor informar o telefone.')"
             oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9]/g, '');" />
    </div>

    <div class="mb-3">
      <label class="form-label">Endereço</label>
      <textarea class="form-control"
                name="endereco"
                required
                oninvalid="this.setCustomValidity('Favor preencher o endereço.')"
                oninput="this.setCustomValidity('')"><%= c.getEndereco() == null ? "" : c.getEndereco() %></textarea>
    </div>
    <button class="btn btn-primary" type="submit">Salvar</button>
    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/clientes">Cancelar</a>
  </form>
</div>
</body>
</html>
