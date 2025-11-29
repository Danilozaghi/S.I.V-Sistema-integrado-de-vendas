
package controller;
import model.Fornecedor;
import model.DAO.FornecedorDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name="FornecedorServlet", urlPatterns={"/FornecedorServlet"})
public class FornecedorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        FornecedorDAO dao = new FornecedorDAO();
        java.util.List<Fornecedor> lista = dao.listar();
        req.setAttribute("lista", lista);
        req.getRequestDispatcher("fornecedores/fornecedores-listar.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nome = req.getParameter("nome");
        String cnpj = req.getParameter("cnpj");
        Fornecedor f = new Fornecedor();
        f.setNome(nome);
        f.setCnpj(cnpj);
        FornecedorDAO dao = new FornecedorDAO();
        dao.inserir(f);
        resp.sendRedirect("FornecedorServlet");
    }
}
