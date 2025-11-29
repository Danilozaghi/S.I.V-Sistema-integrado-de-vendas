package controller;

import model.Venda;
import model.Estoque;
import model.Produto;
import model.Cliente;
import model.Compra;
import model.DAO.VendaDAO;
import model.DAO.EstoqueDAO;
import model.DAO.ProdutoDAO;
import model.DAO.ClienteDAO;
import model.DAO.CompraDAO;
import model.DAO.FuncionarioDAO;
import model.Funcionario;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="VendaServlet",
        urlPatterns={
                "/VendaServlet",
                "/vendas",
                "/venda-edit",
                "/venda-delete",
                "/venda-pedido"
        })
public class VendaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        VendaDAO vendaDAO = new VendaDAO();

        try {
            if ("/VendaServlet".equals(path)) {
                resp.sendRedirect(req.getContextPath() + "/vendas");
                return;
            }

            if ("/vendas".equals(path)) {
                List<Venda> lista = vendaDAO.listar();
                req.setAttribute("lista", lista);
                req.getRequestDispatcher("/vendas/vendas-listar.jsp").forward(req, resp);

            } else if ("/venda-edit".equals(path)) {
                String id = req.getParameter("id");
                Venda v = null;
                if (id != null && !id.isEmpty())
                    v = vendaDAO.buscarPorId(Integer.parseInt(id));
                if (v == null) v = new Venda();
                ClienteDAO clienteDAO = new ClienteDAO();
                ProdutoDAO produtoDAO = new ProdutoDAO();
                FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
                req.setAttribute("venda", v);
                req.setAttribute("clientes", clienteDAO.listarTodos());
                req.setAttribute("produtos", produtoDAO.listarTodos());
                req.setAttribute("funcionarios", funcionarioDAO.listarTodos());
                req.getRequestDispatcher("/vendas/vendas-add.jsp").forward(req, resp);

            } else if ("/venda-delete".equals(path)) {
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    int vendaId = Integer.parseInt(id);
                    Venda antiga = vendaDAO.buscarPorId(vendaId);
                    if (antiga != null) {
                        EstoqueDAO estoqueDAO = new EstoqueDAO();
                        Estoque e = new Estoque();
                        e.setProdutoId(antiga.getProdutoId());
                        e.setTipo("ENTRADA");
                        e.setQuantidade(antiga.getQuantidade());
                        e.setDataMov(antiga.getDataVenda());
                        e.setPreco(antiga.getTotal() / antiga.getQuantidade());
                        estoqueDAO.inserir(e);
                    }
                    vendaDAO.excluir(vendaId);
                }
                resp.sendRedirect(req.getContextPath() + "/vendas");
            } else if ("/venda-pedido".equals(path)) {
                String id = req.getParameter("id");
                if (id == null || id.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/vendas");
                    return;
                }

                int vendaId = Integer.parseInt(id);
                Venda v = vendaDAO.buscarPorId(vendaId);
                if (v == null) {
                    resp.sendRedirect(req.getContextPath() + "/vendas");
                    return;
                }
                ClienteDAO clienteDAO = new ClienteDAO();
                ProdutoDAO produtoDAO = new ProdutoDAO();
                CompraDAO compraDAO = new CompraDAO();
                FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
                req.setAttribute("venda", v);
                req.setAttribute("cliente", clienteDAO.buscarPorId(v.getClienteId()));
                req.setAttribute("produto", produtoDAO.buscarPorId(v.getProdutoId()));
                req.setAttribute("ultimaCompra", compraDAO.buscarUltimaPorProduto(v.getProdutoId()));
                Funcionario func = null;
                if (v.getFuncionarioVendaId() > 0)
                    func = funcionarioDAO.buscarPorId(v.getFuncionarioVendaId());
                req.setAttribute("funcionarioVenda", func);
                int totalVendasMes = vendaDAO.contarVendasFuncionarioNoMes(
                        v.getFuncionarioVendaId(), v.getDataVenda()
                );
                v.setTotalVendasMesFuncionario(totalVendasMes);
                req.getRequestDispatcher("/vendas/pedido.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = req.getParameter("id") == null || req.getParameter("id").isEmpty()
                    ? 0 : Integer.parseInt(req.getParameter("id"));
            int clienteId = Integer.parseInt(req.getParameter("clienteId"));
            int produtoId = Integer.parseInt(req.getParameter("produtoId"));
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));
            String dataVenda = req.getParameter("dataVenda");
            int funcionarioId = 0;
            if (req.getParameter("funcionarioVendaId") != null &&
                    !req.getParameter("funcionarioVendaId").isEmpty()) {
                funcionarioId = Integer.parseInt(req.getParameter("funcionarioVendaId"));
            }
            ProdutoDAO produtoDAO = new ProdutoDAO();
            Produto produto = produtoDAO.buscarPorId(produtoId);
            double precoCompra = produto.getPreco();  
            double precoVenda = precoCompra * 1.35;    
            double total = precoVenda * quantidade;

            Venda v = new Venda();
            v.setId(id);
            v.setClienteId(clienteId);
            v.setProdutoId(produtoId);
            v.setQuantidade(quantidade);
            v.setFuncionarioVendaId(funcionarioId);
            v.setDataVenda(dataVenda);
            v.setTotal(total);
            VendaDAO vendaDAO = new VendaDAO();
            EstoqueDAO estoqueDAO = new EstoqueDAO();
            CompraDAO compraDAO = new CompraDAO();
            int estoqueAtual = estoqueDAO.buscarEstoqueAtual(produtoId);
            if (estoqueAtual < quantidade) {
                int faltando = quantidade - estoqueAtual;
                Compra compraAuto = new Compra();
                compraAuto.setProdutoId(produtoId);
                compraAuto.setQuantidade(faltando);
                compraAuto.setDataCompra(dataVenda);
                compraAuto.setPrecoUnitario(precoCompra);
                compraAuto.setValorTotal(precoCompra * faltando);
                compraDAO.inserir(compraAuto);
                Estoque entrada = new Estoque();
                entrada.setProdutoId(produtoId);
                entrada.setTipo("ENTRADA");
                entrada.setQuantidade(faltando);
                entrada.setDataMov(dataVenda);
                entrada.setPreco(precoCompra);

                estoqueDAO.inserir(entrada);
            }

            if (id == 0) {

                vendaDAO.inserir(v);
                Estoque saida = new Estoque();
                saida.setProdutoId(produtoId);
                saida.setTipo("SAIDA");
                saida.setQuantidade(quantidade);
                saida.setDataMov(dataVenda);
                saida.setPreco(precoVenda); 

                estoqueDAO.inserir(saida);

            } else {

                Venda antiga = vendaDAO.buscarPorId(id);
                if (antiga != null) {
                    Estoque entrada = new Estoque();
                    entrada.setProdutoId(antiga.getProdutoId());
                    entrada.setTipo("ENTRADA");
                    entrada.setQuantidade(antiga.getQuantidade());
                    entrada.setDataMov(antiga.getDataVenda());
                    entrada.setPreco(antiga.getTotal() / antiga.getQuantidade());
                    estoqueDAO.inserir(entrada);
                }

                vendaDAO.atualizar(v);
                Estoque saida = new Estoque();
                saida.setProdutoId(produtoId);
                saida.setTipo("SAIDA");
                saida.setQuantidade(quantidade);
                saida.setDataMov(dataVenda);
                saida.setPreco(precoVenda);
                estoqueDAO.inserir(saida);
            }

            resp.sendRedirect(req.getContextPath() + "/vendas");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
