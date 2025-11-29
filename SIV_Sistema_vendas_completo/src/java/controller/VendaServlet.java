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
            if ("/vendas".equals(path) || "/VendaServlet".equals(path)) {
                List<Venda> lista = vendaDAO.listar();
                req.setAttribute("lista", lista);
                req.getRequestDispatcher("/vendas/vendas-listar.jsp").forward(req, resp);

            } else if ("/venda-edit".equals(path)) {
                String id = req.getParameter("id");
                Venda v = null;
                if (id != null && !id.isEmpty()) {
                    v = vendaDAO.buscarPorId(Integer.parseInt(id));
                }
                if (v == null) v = new Venda();

                ClienteDAO clienteDAO = new ClienteDAO();
                ProdutoDAO produtoDAO = new ProdutoDAO();
                FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
                List<Cliente> clientes = clienteDAO.listarTodos();
                List<Produto> produtos = produtoDAO.listarTodos();
                List<Funcionario> funcionarios = funcionarioDAO.listarTodos();

                req.setAttribute("venda", v);
                req.setAttribute("clientes", clientes);
                req.setAttribute("produtos", produtos);
                req.setAttribute("funcionarios", funcionarios);
                req.getRequestDispatcher("/vendas/vendas-add.jsp").forward(req, resp);

            } else if ("/venda-delete".equals(path)) {
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    int vendaId = Integer.parseInt(id);
                    Venda antiga = vendaDAO.buscarPorId(vendaId);
                    if (antiga != null && antiga.getProdutoId() != 0 && antiga.getQuantidade() > 0) {
                        EstoqueDAO estoqueDAO = new EstoqueDAO();
                        Estoque e = new Estoque();
                        e.setProdutoId(antiga.getProdutoId());
                        e.setTipo("ENTRADA");
                        e.setQuantidade(antiga.getQuantidade());
                        e.setDataMov(antiga.getDataVenda());
                        double precoUnit = antiga.getQuantidade() > 0 ? antiga.getTotal() / antiga.getQuantidade() : 0.0;
                        e.setPreco(precoUnit);
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

                Cliente cliente = clienteDAO.buscarPorId(v.getClienteId());
                Produto produto = produtoDAO.buscarPorId(v.getProdutoId());
                Compra ultimaCompra = compraDAO.buscarUltimaPorProduto(v.getProdutoId());
                Funcionario funcionarioVenda = null;
                if (v.getFuncionarioVendaId() > 0) {
                    funcionarioVenda = funcionarioDAO.buscarPorId(v.getFuncionarioVendaId());
                }

                int totalVendasMes = 0;
                if (v.getFuncionarioVendaId() > 0) {
                    totalVendasMes = vendaDAO.contarVendasFuncionarioNoMes(v.getFuncionarioVendaId(), v.getDataVenda());
                }
                v.setTotalVendasMesFuncionario(totalVendasMes);

                req.setAttribute("venda", v);
                req.setAttribute("cliente", cliente);
                req.setAttribute("produto", produto);
                req.setAttribute("ultimaCompra", ultimaCompra);
                req.setAttribute("funcionarioVenda", funcionarioVenda);

                req.getRequestDispatcher("/vendas/pedido.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        String clienteIdStr = req.getParameter("clienteId");
        String produtoIdStr = req.getParameter("produtoId");
        String quantidadeStr = req.getParameter("quantidade");
        String funcionarioIdStr = req.getParameter("funcionarioVendaId");
        String dataVenda = req.getParameter("dataVenda");

        try {
            int clienteId = Integer.parseInt(clienteIdStr);
            int produtoId = Integer.parseInt(produtoIdStr);
            int quantidade = Integer.parseInt(quantidadeStr);
            int funcionarioId = 0;
            if (funcionarioIdStr != null && !funcionarioIdStr.isEmpty()) {
                funcionarioId = Integer.parseInt(funcionarioIdStr);
            }

            ProdutoDAO produtoDAO = new ProdutoDAO();
            Produto produto = produtoDAO.buscarPorId(produtoId);
            double precoUnit = produto != null ? produto.getPreco() : 0.0;
            double total = precoUnit * quantidade;

            VendaDAO vendaDAO = new VendaDAO();
            EstoqueDAO estoqueDAO = new EstoqueDAO();

            Venda v = new Venda();
            if (idStr != null && !idStr.isEmpty()) {
                v.setId(Integer.parseInt(idStr));
            }
            v.setClienteId(clienteId);
            v.setProdutoId(produtoId);
            v.setQuantidade(quantidade);
            v.setFuncionarioVendaId(funcionarioId);
            v.setDataVenda(dataVenda);
            v.setTotal(total);

            if (v.getId() == 0) {
                vendaDAO.inserir(v);
                Estoque e = new Estoque();
                e.setProdutoId(produtoId);
                e.setTipo("SAIDA");
                e.setQuantidade(quantidade);
                e.setDataMov(dataVenda);
                e.setPreco(precoUnit);
                estoqueDAO.inserir(e);
            } else {
                Venda antiga = vendaDAO.buscarPorId(v.getId());
                if (antiga != null && antiga.getProdutoId() != 0 && antiga.getQuantidade() > 0) {
                    Estoque eEntrada = new Estoque();
                    eEntrada.setProdutoId(antiga.getProdutoId());
                    eEntrada.setTipo("ENTRADA");
                    eEntrada.setQuantidade(antiga.getQuantidade());
                    eEntrada.setDataMov(antiga.getDataVenda());
                    double precoUnitAntigo = antiga.getQuantidade() > 0 ? antiga.getTotal() / antiga.getQuantidade() : 0.0;
                    eEntrada.setPreco(precoUnitAntigo);
                    estoqueDAO.inserir(eEntrada);
                }

                vendaDAO.atualizar(v);

                Estoque eSaida = new Estoque();
                eSaida.setProdutoId(produtoId);
                eSaida.setTipo("SAIDA");
                eSaida.setQuantidade(quantidade);
                eSaida.setDataMov(dataVenda);
                eSaida.setPreco(precoUnit);
                estoqueDAO.inserir(eSaida);
            }

            resp.sendRedirect(req.getContextPath() + "/vendas");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
