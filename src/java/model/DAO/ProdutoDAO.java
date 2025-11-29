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
import model.Produto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {

    public void salvar(Produto p) throws Exception {

        String sql;

        if (p.getId() == 0) {
            sql = "INSERT INTO produtos (nome, descricao, preco, estoque, fornecedor_id) " +
                  "VALUES (?,?,?,?,?)";
        } else {
            sql = "UPDATE produtos SET nome=?, descricao=?, preco=?, estoque=?, fornecedor_id=? " +
                  "WHERE id=?";
        }
        try (Connection conn = ConectaDB.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, p.getNome());
                ps.setString(2, p.getDescricao());
                ps.setDouble(3, p.getPreco());
                ps.setInt(4, p.getEstoque());
                if (p.getFornecedorId() != null)
                    ps.setInt(5, p.getFornecedorId());
                else
                    ps.setNull(5, Types.INTEGER);
                if (p.getId() != 0) {
                    ps.setInt(6, p.getId());
                }
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

                    int fornecedorId = rs.getInt("fornecedor_id");
                    p.setFornecedorId(rs.wasNull() ? null : fornecedorId);

                    return p;
                }
            }
        }
        return null;
    }



    public List<Produto> listarTodos() throws Exception {
    List<Produto> lista = new ArrayList<>();

    String SQL =
        "SELECT p.*, f.nome AS fornecedor_nome " +
        "FROM produtos p " +
        "LEFT JOIN fornecedor f ON p.fornecedor_id = f.id " +
        "ORDER BY p.id DESC";

    try (Connection conn = ConectaDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(SQL);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Produto p = new Produto();
            p.setId(rs.getInt("id"));
            p.setNome(rs.getString("nome"));
            p.setDescricao(rs.getString("descricao"));
            p.setPreco(rs.getDouble("preco"));
            p.setEstoque(rs.getInt("estoque"));
            Integer fornecedorId = (Integer) rs.getObject("fornecedor_id");
            p.setFornecedorId(fornecedorId);

            p.setFornecedorNome(rs.getString("fornecedor_nome"));

            lista.add(p);
        }
    }
    return lista;
}}
