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
import model.Compra;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompraDAO {

    public void inserir(Compra c) {
        String sql = "INSERT INTO compra (fornecedor_id, produto_id, data_compra, quantidade, preco_unit, valor_total) VALUES (?,?,?,?,?,?)";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getFornecedorId());
            ps.setInt(2, c.getProdutoId());
            ps.setString(3, c.getDataCompra());
            ps.setInt(4, c.getQuantidade());
            ps.setDouble(5, c.getPrecoUnitario());
            ps.setDouble(6, c.getValorTotal());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Compra> listar() {
        List<Compra> lista = new ArrayList<>();
        String sql = "SELECT c.*, f.nome AS fornecedor_nome, p.nome AS produto_nome " +
                     "FROM compra c " +
                     "LEFT JOIN fornecedor f ON f.id = c.fornecedor_id " +
                     "LEFT JOIN produtos p ON p.id = c.produto_id " +
                     "ORDER BY c.id DESC";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Compra c = new Compra();
                c.setId(rs.getInt("id"));
                c.setFornecedorId(rs.getInt("fornecedor_id"));
                c.setProdutoId(rs.getInt("produto_id"));
                c.setDataCompra(rs.getString("data_compra"));
                c.setQuantidade(rs.getInt("quantidade"));
                c.setPrecoUnitario(rs.getDouble("preco_unit"));
                c.setValorTotal(rs.getDouble("valor_total"));
                c.setFornecedorNome(rs.getString("fornecedor_nome"));
                c.setProdutoNome(rs.getString("produto_nome"));
                lista.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    public Compra buscarUltimaPorProduto(int produtoId) throws Exception {
        String sql = "SELECT c.*, f.nome AS fornecedor_nome, p.nome AS produto_nome " +
                     "FROM compra c " +
                     "LEFT JOIN fornecedor f ON f.id = c.fornecedor_id " +
                     "LEFT JOIN produtos p ON p.id = c.produto_id " +
                     "WHERE c.produto_id = ? " +
                     "ORDER BY c.data_compra DESC, c.id DESC LIMIT 1";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, produtoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Compra c = new Compra();
                    c.setId(rs.getInt("id"));
                    c.setFornecedorId(rs.getInt("fornecedor_id"));
                    c.setProdutoId(rs.getInt("produto_id"));
                    c.setDataCompra(rs.getString("data_compra"));
                    c.setQuantidade(rs.getInt("quantidade"));
                    c.setPrecoUnitario(rs.getDouble("preco_unit"));
                    c.setValorTotal(rs.getDouble("valor_total"));
                    c.setFornecedorNome(rs.getString("fornecedor_nome"));
                    c.setProdutoNome(rs.getString("produto_nome"));
                    return c;
                }
            }
        }
        return null;
    }
}
