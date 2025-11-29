
package controller;
import model.Estoque;
import model.DAO.EstoqueDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name="EstoqueServlet", urlPatterns={"/EstoqueServlet"})
public class EstoqueServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EstoqueDAO dao = new EstoqueDAO();
        java.util.List<Estoque> lista = dao.listar();
        req.setAttribute("lista", lista);
        req.getRequestDispatcher("estoque/estoque-listar.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int produtoId = Integer.parseInt(req.getParameter("produtoId"));
        String tipo = req.getParameter("tipo");
        int quantidade = Integer.parseInt(req.getParameter("quantidade"));
        String dataMov = req.getParameter("dataMov");
        double preco = Double.parseDouble(req.getParameter("preco"));
        Estoque e = new Estoque();
        e.setProdutoId(produtoId);
        e.setTipo(tipo);
        e.setQuantidade(quantidade);
        e.setDataMov(dataMov);
        e.setPreco(preco);
        EstoqueDAO dao = new EstoqueDAO();
        dao.inserir(e);
        resp.sendRedirect("EstoqueServlet");
    }
}
