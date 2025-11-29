<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Funcionario" %>
<%
    Funcionario f = (Funcionario) request.getAttribute("funcionario");
    if (f == null) f = new Funcionario();
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Funcionário - Formulário</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Funcionarios-Form.css">
</head>
<body class="p-4">
<div class="container">
  <h2><%= f.getId() == 0 ? "Novo Funcionário" : "Editar Funcionário" %></h2>
  <form method="post"
        action="<%=request.getContextPath()%>/funcionario-save"
        enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%=f.getId()%>" />
    <input type="hidden" name="imagemAtual" value="<%=f.getImagem()%>" />
    <div class="row">
      <div class="col-md-8">
        <div class="mb-3">
          <label class="form-label">Nome</label>
          <input class="form-control"
                 name="nome"
                 required
                 value="<%= f.getNome() == null ? "" : f.getNome() %>"
                 oninvalid="this.setCustomValidity('Favor preencher o nome do funcionário.')"
                 oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^a-zA-ZÀ-ÿ\s]/g, '');" />
        </div>

        <div class="mb-3">
          <label class="form-label">CPF</label>
          <input class="form-control"
                 name="cpf"
                 required
                 maxlength="11"
                 value="<%= f.getCpf() == null ? "" : f.getCpf() %>"
                 oninvalid="this.setCustomValidity('Favor informar o CPF.')"
                 oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9]/g, '');" />
        </div>

        <div class="mb-3">
          <label class="form-label">Cargo</label>
          <input class="form-control"
                 name="cargo"
                 required
                 value="<%= f.getCargo() == null ? "" : f.getCargo() %>"
                 oninvalid="this.setCustomValidity('Favor informar o cargo.')"
                 oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^a-zA-ZÀ-ÿ\s]/g, '');" />
        </div>
                 
        <div class="mb-3">
          <label class="form-label">Email</label>
          <input class="form-control"
                 type="email"
                 name="email"
                 required
                 value="<%= f.getEmail() == null ? "" : f.getEmail() %>"
                 oninvalid="this.setCustomValidity('Favor informar um email válido.')"
                 oninput="this.setCustomValidity('')" />
        </div>
                 
        <div class="mb-3">
          <label class="form-label">Telefone</label>
          <input class="form-control"
                 name="telefone"
                 required
                 maxlength="11"
                 value="<%= f.getTelefone() == null ? "" : f.getTelefone() %>"
                 oninvalid="this.setCustomValidity('Favor informar o telefone.')"
                 oninput="this.setCustomValidity(''); this.value = this.value.replace(/[^0-9]/g, '');" />
        </div>

      </div>
      <div class="col-md-4">
        <div class="mb-3 text-center">
          <label class="form-label d-block">Foto</label>

          <% if (f.getImagem() != null && !f.getImagem().isEmpty()) { %>
            <img src="<%=request.getContextPath()%>/<%=f.getImagem()%>"
                 alt="Foto"
                 style="width:140px;height:140px;object-fit:cover;border-radius:50%;display:block;margin:0 auto 10px;">
          <% } %>
          <input type="file" name="foto" class="form-control" accept="image/*" />
          <small style="color: #ffffff;">Se não selecionar nada, mantém a foto padrão.</small>

        </div>
      </div>
    </div>
    <button class="btn btn-primary" type="submit">Salvar</button>
    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/funcionarios">Cancelar</a>
  </form>
</div>
</body>
</html>
