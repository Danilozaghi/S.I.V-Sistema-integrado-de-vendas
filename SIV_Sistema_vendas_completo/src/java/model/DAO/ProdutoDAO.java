package model.DAO;

import config.ConectaDB;
import model.Produto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
    public void salvar(Produto p) throws Exception {
        String sql = p.getId() == 0 ? "INSERT INTO produtos (nome, descricao, preco, estoque) VALUES (?,?,?,?)"
                                   : "UPDATE produtos SET nome=?, descricao=?, preco=?, estoque=? WHERE id=?";
        try (Connection conn = ConectaDB.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, p.getNome());
                ps.setString(2, p.getDescricao());
                ps.setDouble(3, p.getPreco());
                ps.setInt(4, p.getEstoque());
                if (p.getId() != 0) ps.setInt(5, p.getId());
                ps.executeUpdate();
                if (p.getId() == 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) p.setId(rs.getInt(1));
                    }
                }
            }
        }
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM produtos WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Produto buscarPorId(int id) throws Exception {
        String sql = "SELECT * FROM produtos WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Produto p = new Produto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescricao(rs.getString("descricao"));
                    p.setPreco(rs.getDouble("preco"));
                    p.setEstoque(rs.getInt("estoque"));
                    return p;
                }
            }
        }
        return null;
    }

    public List<Produto> listarTodos() throws Exception {
        List<Produto> lista = new ArrayList<>();
        String sql = "SELECT * FROM produtos ORDER BY id DESC";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Produto p = new Produto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setDescricao(rs.getString("descricao"));
                p.setPreco(rs.getDouble("preco"));
                p.setEstoque(rs.getInt("estoque"));
                lista.add(p);
            }
        }
        return lista;
    }
}