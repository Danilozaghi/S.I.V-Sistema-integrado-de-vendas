package controller;

import model.Compra;
import model.Estoque;
import model.DAO.CompraDAO;
import model.DAO.EstoqueDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="CompraServlet", urlPatterns={"/CompraServlet"})
public class CompraServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CompraDAO dao = new CompraDAO();
        List<Compra> lista = dao.listar();
        req.setAttribute("lista", lista);
        req.getRequestDispatcher("compras/compras-listar.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int fornecedorId = Integer.parseInt(req.getParameter("fornecedorId"));
            int produtoId = Integer.parseInt(req.getParameter("produtoId"));
            String dataCompra = req.getParameter("dataCompra");
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));
            double precoUnit = Double.parseDouble(req.getParameter("precoUnitario"));

            double valorTotal = quantidade * precoUnit;

            Compra c = new Compra();
            c.setFornecedorId(fornecedorId);
            c.setProdutoId(produtoId);
            c.setDataCompra(dataCompra);
            c.setQuantidade(quantidade);
            c.setPrecoUnitario(precoUnit);
            c.setValorTotal(valorTotal);

            CompraDAO compraDAO = new CompraDAO();
            compraDAO.inserir(c);

            // movimentação de ENTRADA no estoque
            Estoque mov = new Estoque();
            mov.setProdutoId(produtoId);
            mov.setTipo("ENTRADA");
            mov.setQuantidade(quantidade);
            mov.setDataMov(dataCompra);
            mov.setPreco(precoUnit);

            EstoqueDAO estoqueDAO = new EstoqueDAO();
            estoqueDAO.inserir(mov);

            resp.sendRedirect("CompraServlet");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}