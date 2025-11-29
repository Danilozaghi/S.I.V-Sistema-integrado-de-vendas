package model.DAO;

import config.ConectaDB;
import model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    public void salvar(Cliente c) throws Exception {
        String sql = c.getId() == 0 ? "INSERT INTO clientes (nome, cpf, email, telefone, endereco) VALUES (?,?,?,?,?)"
                                   : "UPDATE clientes SET nome=?, cpf=?, email=?, telefone=?, endereco=? WHERE id=?";
        try (Connection conn = ConectaDB.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, c.getNome());
                ps.setString(2, c.getCpf());
                ps.setString(3, c.getEmail());
                ps.setString(4, c.getTelefone());
                ps.setString(5, c.getEndereco());
                if (c.getId() != 0) ps.setInt(6, c.getId());
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