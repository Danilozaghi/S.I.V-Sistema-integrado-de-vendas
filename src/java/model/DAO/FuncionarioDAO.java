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
import model.Funcionario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDAO {
    public void salvar(Funcionario f) throws Exception {
        String sql;
        if (f.getId() == 0) {
            sql = "INSERT INTO funcionarios (nome, cpf, cargo, email, telefone, imagem) VALUES (?,?,?,?,?,?)";
        } else {
            sql = "UPDATE funcionarios SET nome=?, cpf=?, cargo=?, email=?, telefone=?, imagem=? WHERE id=?";
        }
        try (Connection conn = ConectaDB.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, f.getNome());
                ps.setString(2, f.getCpf());
                ps.setString(3, f.getCargo());
                ps.setString(4, f.getEmail());
                ps.setString(5, f.getTelefone());
                ps.setString(6, f.getImagem());
                if (f.getId() != 0) {
                    ps.setInt(7, f.getId());
                }
                ps.executeUpdate();

                if (f.getId() == 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            f.setId(rs.getInt(1));
                        }
                    }
                }
            }
        }
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM funcionarios WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Funcionario buscarPorId(int id) throws Exception {
        String sql = "SELECT * FROM funcionarios WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Funcionario f = new Funcionario();
                    f.setId(rs.getInt("id"));
                    f.setNome(rs.getString("nome"));
                    try { f.setCpf(rs.getString("cpf")); } catch (Exception e) {}
                    f.setCargo(rs.getString("cargo"));
                    f.setEmail(rs.getString("email"));
                    f.setTelefone(rs.getString("telefone"));
                    try { f.setImagem(rs.getString("imagem")); } catch (Exception e) {}
                    return f;
                }
            }
        }
        return null;
    }

    public List<Funcionario> listarTodos() throws Exception {
        List<Funcionario> lista = new ArrayList<>();
        String sql = "SELECT * FROM funcionarios ORDER BY id DESC";

        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Funcionario f = new Funcionario();
                f.setId(rs.getInt("id"));
                f.setNome(rs.getString("nome"));
                try { f.setCpf(rs.getString("cpf")); } catch (Exception e) {}
                f.setCargo(rs.getString("cargo"));
                f.setEmail(rs.getString("email"));
                f.setTelefone(rs.getString("telefone"));
                try { f.setImagem(rs.getString("imagem")); } catch (Exception e) {}

                lista.add(f);
            }
        }
        return lista;
    }
}
