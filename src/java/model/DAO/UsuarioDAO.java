/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package model.DAO;

import config.ConectaDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {

    public boolean autenticar(String login, String senha) {
        String sql = "SELECT * FROM usuarios WHERE login=? AND senha=?";

        try (Connection conn = ConectaDB.getConnection()) {
            System.out.println("DEBUG DAO conn = " + conn);

            if (conn == null) {
                System.out.println("✘ ConectaDB.getConnection() retornou null");
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, login);
                ps.setString(2, senha);
                System.out.println("DEBUG DAO tentando login=" + login + " senha=" + senha);

                try (ResultSet rs = ps.executeQuery()) {
                    boolean existe = rs.next();
                    System.out.println("DEBUG DAO resultado rs.next() = " + existe);
                    return existe;
                }
            }
        } catch (Exception e) {
            System.out.println("✘ ERRO NO UsuarioDAO.autenticar:");
            e.printStackTrace();
        }

        return false;
    }
}
