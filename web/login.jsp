<%-- 
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
--%>



<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <title>Login - SIV</title>
    <link href="<%=request.getContextPath()%>/assets/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style_css/Login.css">
</head>
<body>
<div class="bolha"></div>

<div class="login-container d-flex justify-content-center align-items-center">
    <div class="login-box">
        <div class="text-center mb-4">
            <div class="brand-title">SIV</div>
            <div class="subtitle">Sistema Integrado de Vendas</div>
        </div>
        <%
            String erro = request.getParameter("erro");
            if ("1".equals(erro)) {
        %>
            <div class="alert-erro">Login ou senha inválidos.</div>
        <% } %>
        <form method="post" action="<%=request.getContextPath()%>/LoginServlet">
            <div class="input-group">
                <label>Login</label>
                <input type="text" name="login" required autofocus>
            </div>
            <div class="input-group">
                <label>Senha</label>
                <input type="password" name="senha" required>
            </div>
            <button type="submit" class="btn">Entrar</button>
        </form>
        <div class="footer mt-3 text-center">
            &copy; <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> SIV
        </div>
    </div>
</div>
</body>
</html>
