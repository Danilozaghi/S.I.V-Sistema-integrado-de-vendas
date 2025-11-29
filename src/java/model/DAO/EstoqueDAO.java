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
import model.Estoque;
import java.sql.*;
import java.util.*;
public class EstoqueDAO {
    public void inserir(Estoque e) {
        String sql = "INSERT INTO estoque (produto_id,tipo,quantidade,data_mov,preco) VALUES (?,?,?,?,?)";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, e.getProdutoId());
            ps.setString(2, e.getTipo());
            ps.setInt(3, e.getQuantidade());
            ps.setString(4, e.getDataMov());
            ps.setDouble(5, e.getPreco());
            ps.executeUpdate();
        } catch (Exception ex) { ex.printStackTrace(); }
    }
    public java.util.List<Estoque> listar() {
        java.util.List<Estoque> lista = new java.util.ArrayList<>();
        String sql = "SELECT * FROM estoque ORDER BY data_mov DESC";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Estoque e = new Estoque();
                e.setId(rs.getInt("id"));
                e.setProdutoId(rs.getInt("produto_id"));
                e.setTipo(rs.getString("tipo"));
                e.setQuantidade(rs.getInt("quantidade"));
                e.setDataMov(rs.getString("data_mov"));
                e.setPreco(rs.getDouble("preco"));
                lista.add(e);
            }
        } catch (Exception ex) { ex.printStackTrace(); }
        return lista;
    }
    public int buscarEstoqueAtual(int produtoId) {
    int saldo = 0;

    String sql = 
        "SELECT " +
        "(SELECT COALESCE(SUM(quantidade),0) FROM estoque WHERE produto_id = ? AND tipo = 'ENTRADA') - " +
        "(SELECT COALESCE(SUM(quantidade),0) FROM estoque WHERE produto_id = ? AND tipo = 'SAIDA') AS saldo";

    try (Connection conn = ConectaDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, produtoId);
        ps.setInt(2, produtoId);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            saldo = rs.getInt("saldo");
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }

    return saldo;
}

}
