package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String url = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean logado = (session != null && session.getAttribute("usuarioLogado") != null);

        boolean paginaLiberada =
                url.endsWith("login.jsp") ||
                url.contains("LoginServlet") ||
                url.contains("sign-in.css") ||
                url.contains("senhajson") ||
                url.contains("style.css") ||
                url.contains("imagens") ||
                url.contains("assets") ||
                url.contains("style_css");

        if (!logado && !paginaLiberada) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
