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
import model.Fornecedor;
import java.sql.*;
import java.util.*;
public class FornecedorDAO {
    public boolean cnpjExiste(String cnpj) throws Exception {
        String sql = "SELECT id FROM fornecedor WHERE cnpj = ?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cnpj);
            ResultSet rs = ps.executeQuery();

            return rs.next(); 
        }
    }
    public void inserir(Fornecedor f) throws Exception {

        if (cnpjExiste(f.getCnpj())) {
            throw new Exception("CNPJ já cadastrado!");
        }
        String sql = "INSERT INTO fornecedor (nome, cnpj) VALUES (?,?)";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getNome());
            ps.setString(2, f.getCnpj());
            ps.executeUpdate();

        }
    }

    public List<Fornecedor> listar() {
        List<Fornecedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM fornecedor ORDER BY nome";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Fornecedor f = new Fornecedor();
                f.setId(rs.getInt("id"));
                f.setNome(rs.getString("nome"));
                f.setCnpj(rs.getString("cnpj"));
                lista.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
