/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package controller;
import model.DAO.UsuarioDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet(name="LoginServlet", urlPatterns={"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String senha = req.getParameter("senha");
        UsuarioDAO dao = new UsuarioDAO();
        if (dao.autenticar(login, senha)) {
            HttpSession sess = req.getSession();
            sess.setAttribute("usuarioLogado", login);
            resp.sendRedirect("dashboard.jsp");
        } else {
            resp.sendRedirect("login.jsp?erro=1");
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sess = req.getSession(false);
        if (sess != null) sess.invalidate();
        resp.sendRedirect("login.jsp");
    }
}
