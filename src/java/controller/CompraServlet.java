/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package controller;

import model.Compra;
import model.Estoque;
import model.Fornecedor;
import model.Produto;

import model.DAO.CompraDAO;
import model.DAO.EstoqueDAO;
import model.DAO.FornecedorDAO;
import model.DAO.ProdutoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="CompraServlet",
        urlPatterns={
                "/CompraServlet",
                "/compras",
                "/compra-add"
        })
public class CompraServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        CompraDAO compraDAO = new CompraDAO();

        try {
            if ("/compras".equals(path) || "/CompraServlet".equals(path)) {
                List<Compra> lista = compraDAO.listar();
                req.setAttribute("lista", lista);
                req.getRequestDispatcher("/compras/compras-listar.jsp")
                        .forward(req, resp);
                return;
            }
            if ("/compra-add".equals(path)) {
                FornecedorDAO fornecedorDAO = new FornecedorDAO();
                ProdutoDAO produtoDAO = new ProdutoDAO();
                req.setAttribute("fornecedores", fornecedorDAO.listar());
                req.setAttribute("produtos", produtoDAO.listarTodos());
                req.getRequestDispatcher("/compras/compras-add.jsp")
                        .forward(req, resp);
                return;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
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
            new CompraDAO().inserir(c);
            Estoque mov = new Estoque();
            mov.setProdutoId(produtoId);
            mov.setTipo("ENTRADA");
            mov.setQuantidade(quantidade);
            mov.setDataMov(dataCompra);
            mov.setPreco(precoUnit);
            new EstoqueDAO().inserir(mov);
            resp.sendRedirect("compras");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

