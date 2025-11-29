
package model.DAO;
import config.ConectaDB;
import model.Fornecedor;
import java.sql.*;
import java.util.*;
public class FornecedorDAO {
    public void inserir(Fornecedor f) {
        String sql = "INSERT INTO fornecedor (nome,cnpj) VALUES (?,?)";
        try (Connection conn = ConectaDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getNome());
            ps.setString(2, f.getCnpj());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    public java.util.List<Fornecedor> listar() {
        java.util.List<Fornecedor> lista = new java.util.ArrayList<>();
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
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
