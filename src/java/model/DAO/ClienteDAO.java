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
import model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    public boolean cpfExiste(String cpf, Integer idAtual) throws Exception {
        String sql = "SELECT id FROM clientes WHERE cpf = ?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cpf);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int idEncontrado = rs.getInt("id");
                    if (idAtual != null && idAtual == idEncontrado) {
                        return false;
                    }

                    return true; 
                }
            }
        }
        return false;
    }
    public void salvar(Cliente c) throws Exception {

        if (cpfExiste(c.getCpf(), c.getId() == 0 ? null : c.getId())) {
            throw new Exception("CPF já cadastrado!");
        }
        String sql = c.getId() == 0 ?
                "INSERT INTO clientes (nome, cpf, email, telefone, endereco) VALUES (?,?,?,?,?)"
                :
                "UPDATE clientes SET nome=?, cpf=?, email=?, telefone=?, endereco=? WHERE id=?";

        try (Connection conn = ConectaDB.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, c.getNome());
                ps.setString(2, c.getCpf());
                ps.setString(3, c.getEmail());
                ps.setString(4, c.getTelefone());
                ps.setString(5, c.getEndereco());
                if (c.getId() != 0) {
                    ps.setInt(6, c.getId());
                }
                ps.executeUpdate();
                if (c.getId() == 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) c.setId(rs.getInt(1));
                    }
                }
            }
        }
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM clientes WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Cliente buscarPorId(int id) throws Exception {
        String sql = "SELECT * FROM clientes WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cliente c = new Cliente();
                    c.setId(rs.getInt("id"));
                    c.setNome(rs.getString("nome"));
                    c.setCpf(rs.getString("cpf"));
                    c.setEmail(rs.getString("email"));
                    c.setTelefone(rs.getString("telefone"));
                    c.setEndereco(rs.getString("endereco"));
                    return c;
                }
            }
        }
        return null;
    }

    public List<Cliente> listarTodos() throws Exception {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes ORDER BY id DESC";

        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setCpf(rs.getString("cpf"));
                c.setEmail(rs.getString("email"));
                c.setTelefone(rs.getString("telefone"));
                c.setEndereco(rs.getString("endereco"));
                lista.add(c);
            }
        }
        return lista;
    }
}
