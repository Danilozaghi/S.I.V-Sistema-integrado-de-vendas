<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <title>Login - SIV</title>
  <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      min-height: 100vh;
      background: radial-gradient(circle at top, #0d6efd 0, #020617 45%, #020617 100%);
      color: #e5e7eb;
    }
    .brand-title {
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }
  </style>
</head>
<body class="d-flex align-items-center">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="text-center mb-4 text-light">
        <div class="fw-bold brand-title">SIV</div>
        <div class="small text-secondary">Sistema Integrado de Vendas</div>
      </div>
      <div class="card shadow-lg border-0">
        <div class="card-body p-4">
          <h4 class="mb-3 text-center">Acessar painel</h4>
          <%
             String erro = request.getParameter("erro");
             if ("1".equals(erro)) {
          %>
             <div class="alert alert-danger py-2 small">Login ou senha inválidos.</div>
          <% } %>
          <form method="post" action="<%=request.getContextPath()%>/LoginServlet" class="needs-validation" novalidate>
            <div class="mb-3">
              <label class="form-label">Login</label>
              <input type="text" name="login" class="form-control" required autofocus>
            </div>
            <div class="mb-3">
              <label class="form-label">Senha</label>
              <input type="password" name="senha" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Entrar</button>
          </form>
        </div>
      </div>
      <p class="text-center text-secondary small mt-3 mb-0">
        &copy; <%=new java.util.GregorianCalendar().get(java.util.Calendar.YEAR)%> SIV
      </p>
    </div>
  </div>
</div>
</body>
</html>