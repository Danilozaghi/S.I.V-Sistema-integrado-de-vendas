package SalvarImagem;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Cliente;
import config.ConectaDB;
import java.io.InputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author alunocmc
 */

@WebServlet(name = "SalvarImagem", urlPatterns = {"/SalvarImagem"})
@MultipartConfig(maxFileSize = 16177215) // Tamanho máximo do arquivo (15MB)

public class SalvarImagem extends HttpServlet {

    public static String salvar(Part imagem, String caminho) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Meu Servlet SalvarImagem</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Meu Servlet SalvarImagem at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        // ... (configurações de conexão com o banco de dados)
           
        String message = null;

        //Instância do objeto
        Cliente cli = new Cliente(); 

        cli.setId(Integer.parseInt( request.getParameter("ident")));
        cli.setNome(request.getParameter("cliente"));
        cli.setEmail(request.getParameter("email"));
        cli.setRenda(Float.parseFloat(request.getParameter("renda"))); 
        cli.setCelular(request.getParameter("celular")); //    .parse - Texto p/ data.
        
        try{
            cli.setNasc(new SimpleDateFormat("yyyy-MM-dd").parse( request.getParameter("nascimento")));
        }catch(ParseException ex){
            message = "ERRO: " + ex.getMessage();
        }

        InputStream inputStream = null; // Input stream da imagem

        // Obtém a parte do arquivo do request
        Part filePart = request.getPart("img");
        if (filePart != null) {
            // Obtém o input stream do arquivo selecionado
            inputStream = filePart.getInputStream();
        }       
        
        try {
            // Conecta ao banco de dados
            Connection conn = null;        
                 
            conn = ConectaDB.conectar();          
                    
            String sql = "Insert INTO clientes (nome, email, renda, celular, nasc, imagem) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cli.getNome()); 
            pstmt.setString(2, cli.getEmail());
            pstmt.setDouble(3, cli.getRenda());
            pstmt.setString(4, cli.getCelular());
            pstmt.setString(5, new SimpleDateFormat("yyyy/MM/dd").format(cli.getNasc()));           

            if (inputStream != null) {
                // Define o parâmetro BLOB/LONGBLOB
                pstmt.setBlob(6, inputStream);
            }
            
            // Executa o statement
            int row = pstmt.executeUpdate();//Insert / Delete / Update
            if (row > 0) {
                message = "Imagem salva com sucesso no banco de dados!";
            }
        } catch (SQLException ex) {
            message = "ERRO: " + ex.getMessage();            
        } finally {            
            // Redireciona de volta para uma página de status ou exibe a mensagem
            request.setAttribute("Message", message);
            getServletContext().getRequestDispatcher("/mensagem.jsp").forward(request, response);
        }
    }       
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
