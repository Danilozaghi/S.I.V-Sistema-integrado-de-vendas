package controller;
import model.Cliente;
import model.DAO.ClienteDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="ClienteServlet", urlPatterns={"/ClienteServlet","/clientes", "/cliente-save", "/cliente-edit", "/cliente-delete"})
public class ClienteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String path = req.getServletPath();
            ClienteDAO dao = new ClienteDAO();
            if ("/clientes".equals(path)) {
                List<Cliente> lista = dao.listarTodos();
                req.setAttribute("clientes", lista);
                req.getRequestDispatcher("/clientes/list.jsp").forward(req, resp);
            } else if ("/cliente-edit".equals(path)) {
                String id = req.getParameter("id");
                if (id != null) {
                    Cliente c = dao.buscarPorId(Integer.parseInt(id));
                    req.setAttribute("cliente", c);
                }
                req.getRequestDispatcher("/clientes/form.jsp").forward(req, resp);
            } else if ("/cliente-delete".equals(path)) {
                String id = req.getParameter("id");
                if (id != null) dao.excluir(Integer.parseInt(id));
                resp.sendRedirect(req.getContextPath()+"/clientes");
            } else {
                resp.sendRedirect(req.getContextPath()+"/clientes");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Cliente c = new Cliente();
            String id = req.getParameter("id");
            if (id != null && !id.isEmpty()) c.setId(Integer.parseInt(id));
            c.setNome(req.getParameter("nome"));
            c.setCpf(req.getParameter("cpf"));
            c.setEmail(req.getParameter("email"));
            c.setTelefone(req.getParameter("telefone"));
            c.setEndereco(req.getParameter("endereco"));
            ClienteDAO dao = new ClienteDAO();
            dao.salvar(c);
            resp.sendRedirect(req.getContextPath()+"/clientes");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}