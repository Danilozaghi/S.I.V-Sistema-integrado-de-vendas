package model.DAO;

import config.ConectaDB;
import model.Venda;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class VendaDAO {

    public void inserir(Venda v) throws Exception {
        String sql = "INSERT INTO venda (cliente_id, produto_id, quantidade, funcionario_venda_id, data_venda, total) " +
                     "VALUES (?,?,?,?,?,?)";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, v.getClienteId());
            ps.setInt(2, v.getProdutoId());
            ps.setInt(3, v.getQuantidade());

            if (v.getFuncionarioVendaId() > 0) {
                ps.setInt(4, v.getFuncionarioVendaId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            ps.setString(5, v.getDataVenda());
            ps.setDouble(6, v.getTotal());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    v.setId(rs.getInt(1));
                }
            }
        }
    }

    public void atualizar(Venda v) throws Exception {
        String sql = "UPDATE venda SET cliente_id=?, produto_id=?, quantidade=?, funcionario_venda_id=?, data_venda=?, total=? " +
                     "WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, v.getClienteId());
            ps.setInt(2, v.getProdutoId());
            ps.setInt(3, v.getQuantidade());

            if (v.getFuncionarioVendaId() > 0) {
                ps.setInt(4, v.getFuncionarioVendaId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            ps.setString(5, v.getDataVenda());
            ps.setDouble(6, v.getTotal());
            ps.setInt(7, v.getId());

            ps.executeUpdate();
        }
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM venda WHERE id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Venda buscarPorId(int id) throws Exception {
        String sql = "SELECT v.*, c.nome AS cliente_nome, p.nome AS produto_nome, f.nome AS funcionario_nome " +
                     "FROM venda v " +
                     "LEFT JOIN clientes c ON c.id = v.cliente_id " +
                     "LEFT JOIN produtos p ON p.id = v.produto_id " +
                     "LEFT JOIN funcionarios f ON f.id = v.funcionario_venda_id " +
                     "WHERE v.id=?";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVenda(rs);
                }
            }
        }
        return null;
    }

    public List<Venda> listar() throws Exception {
        List<Venda> lista = new ArrayList<>();

        String sql = "SELECT v.*, c.nome AS cliente_nome, p.nome AS produto_nome, f.nome AS funcionario_nome " +
                     "FROM venda v " +
                     "LEFT JOIN clientes c ON c.id = v.cliente_id " +
                     "LEFT JOIN produtos p ON p.id = v.produto_id " +
                     "LEFT JOIN funcionarios f ON f.id = v.funcionario_venda_id " +
                     "ORDER BY v.data_venda DESC, v.id DESC";

        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapVenda(rs));
            }
        }
        return lista;
    }

    private Venda mapVenda(ResultSet rs) throws SQLException {
        Venda v = new Venda();
        v.setId(rs.getInt("id"));
        v.setClienteId(rs.getInt("cliente_id"));

        try { v.setProdutoId(rs.getInt("produto_id")); } catch (SQLException e) {}
        try { v.setQuantidade(rs.getInt("quantidade")); } catch (SQLException e) {}
        try { v.setFuncionarioVendaId(rs.getInt("funcionario_venda_id")); } catch (SQLException e) {}

        v.setDataVenda(rs.getString("data_venda"));
        v.setTotal(rs.getDouble("total"));

        try { v.setClienteNome(rs.getString("cliente_nome")); } catch (SQLException e) {}
        try { v.setProdutoNome(rs.getString("produto_nome")); } catch (SQLException e) {}
        try { v.setFuncionarioVendaNome(rs.getString("funcionario_nome")); } catch (SQLException e) {}

        return v;
    }

    // Conta quantas vendas o funcionário fez no mês da data informada
    public int contarVendasFuncionarioNoMes(int funcionarioId, String dataVenda) throws Exception {
        if (dataVenda == null || dataVenda.isEmpty()) return 0;

        java.sql.Date dt = java.sql.Date.valueOf(dataVenda);
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int ano = cal.get(Calendar.YEAR);
        int mes = cal.get(Calendar.MONTH) + 1;

        String sql = "SELECT COUNT(*) FROM venda " +
                     "WHERE funcionario_venda_id = ? " +
                     "AND YEAR(data_venda) = ? AND MONTH(data_venda) = ?";

        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, funcionarioId);
            ps.setInt(2, ano);
            ps.setInt(3, mes);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}
