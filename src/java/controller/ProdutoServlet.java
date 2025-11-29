/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package controller;

import model.Produto;
import model.DAO.ProdutoDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet(
    name="ProdutoServlet",
    urlPatterns={
        "/ProdutoServlet",
        "/produtos",
        "/produto-save",
        "/produto-edit",
        "/produto-delete"
    }
)
public class ProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String path = req.getServletPath();
            ProdutoDAO dao = new ProdutoDAO();

            if ("/produtos".equals(path)) {
                List<Produto> lista = dao.listarTodos();
                req.setAttribute("produtos", lista);
                req.getRequestDispatcher("/produtos/list.jsp").forward(req, resp);
            }
            else if ("/produto-edit".equals(path)) {
                String id = req.getParameter("id");
                if (id != null) {
                    Produto p = dao.buscarPorId(Integer.parseInt(id));
                    req.setAttribute("produto", p);
                }
                req.getRequestDispatcher("/produtos/form.jsp").forward(req, resp);
            }

            else if ("/produto-delete".equals(path)) {
                String id = req.getParameter("id");
                if (id != null) dao.excluir(Integer.parseInt(id));
                resp.sendRedirect(req.getContextPath() + "/produtos");
            }

            else {
                resp.sendRedirect(req.getContextPath() + "/produtos");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Produto p = new Produto();
            String id = req.getParameter("id");
            if (id != null && !id.isEmpty())
                p.setId(Integer.parseInt(id));
            p.setNome(req.getParameter("nome"));
            p.setDescricao(req.getParameter("descricao"));
            p.setPreco(Double.parseDouble(req.getParameter("preco")));
            p.setEstoque(Integer.parseInt(req.getParameter("estoque")));
            String fornecedorId = req.getParameter("fornecedorId");
            if (fornecedorId != null && !fornecedorId.isEmpty()) {
                p.setFornecedorId(Integer.parseInt(fornecedorId));
            } else {
                p.setFornecedorId(null);
            }
            ProdutoDAO dao = new ProdutoDAO();
            dao.salvar(p);
            resp.sendRedirect(req.getContextPath() + "/produtos");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
