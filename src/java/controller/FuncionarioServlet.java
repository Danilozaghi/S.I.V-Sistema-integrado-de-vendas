/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package controller;

import model.Funcionario;
import model.DAO.FuncionarioDAO;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name="FuncionarioServlet",
        urlPatterns={
                "/FuncionarioServlet",      
                "/funcionarios",
                "/funcionario-save",
                "/funcionario-edit",
                "/funcionario-delete"
        })
@MultipartConfig(maxFileSize = 16177215) 
public class FuncionarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();
        FuncionarioDAO dao = new FuncionarioDAO();

        try {
            if ("/funcionarios".equals(path) || "/FuncionarioServlet".equals(path)) {
                List<Funcionario> lista = dao.listarTodos();
                req.setAttribute("funcionarios", lista);
                req.getRequestDispatcher("/funcionarios/list.jsp").forward(req, resp);

            } else if ("/funcionario-edit".equals(path)) {
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    Funcionario f = dao.buscarPorId(Integer.parseInt(id));
                    req.setAttribute("funcionario", f);
                }
                req.getRequestDispatcher("/funcionarios/form.jsp").forward(req, resp);

            } else if ("/funcionario-delete".equals(path)) {
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    dao.excluir(Integer.parseInt(id));
                }
                resp.sendRedirect(req.getContextPath() + "/funcionarios");

            } else {
                resp.sendRedirect(req.getContextPath() + "/funcionarios");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            Funcionario f = new Funcionario();
            String id = req.getParameter("id");
            if (id != null && !id.isEmpty()) {
                f.setId(Integer.parseInt(id));
            }
            f.setNome(req.getParameter("nome"));
            f.setCpf(req.getParameter("cpf"));
            f.setCargo(req.getParameter("cargo"));
            f.setEmail(req.getParameter("email"));
            f.setTelefone(req.getParameter("telefone"));
            String imagemAtual = req.getParameter("imagemAtual");
            Part fotoPart = req.getPart("foto");
            String caminhoImagem = imagemAtual;
            if (fotoPart != null && fotoPart.getSize() > 0) {
                String fileName = Paths.get(fotoPart.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int dot = fileName.lastIndexOf('.');
                if (dot > 0) {
                    ext = fileName.substring(dot);
                }
                String novoNome = "func_" + System.currentTimeMillis() + ext;
                String uploadPath = getServletContext().getRealPath("") +
                        File.separator + "imagens" + File.separator + "funcionarios";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                File file = new File(uploadDir, novoNome);
                try (InputStream in = fotoPart.getInputStream();
                     FileOutputStream out = new FileOutputStream(file)) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
                caminhoImagem = "imagens/funcionarios/" + novoNome;
            }
            f.setImagem(caminhoImagem);
            FuncionarioDAO dao = new FuncionarioDAO();
            dao.salvar(f);
            resp.sendRedirect(req.getContextPath() + "/funcionarios");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
