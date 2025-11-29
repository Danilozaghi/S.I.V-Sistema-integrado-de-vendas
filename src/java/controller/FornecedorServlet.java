/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        FornecedorDAO dao = new FornecedorDAO();
        List<Fornecedor> lista = dao.listar();
        req.setAttribute("lista", lista);
        req.getRequestDispatcher("fornecedores/fornecedores-listar.jsp")
                .forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String nome = req.getParameter("nome");
            String cnpj = req.getParameter("cnpj");
            Fornecedor f = new Fornecedor();
            f.setNome(nome);
            f.setCnpj(cnpj);
            FornecedorDAO dao = new FornecedorDAO();
            dao.inserir(f);
            resp.sendRedirect("FornecedorServlet");
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            Fornecedor f = new Fornecedor();
            f.setNome(req.getParameter("nome"));
            f.setCnpj(req.getParameter("cnpj"));
            req.setAttribute("fornecedor", f);
            req.getRequestDispatcher("fornecedores/fornecedores-add.jsp")
                    .forward(req, resp);
        }
    }
}
