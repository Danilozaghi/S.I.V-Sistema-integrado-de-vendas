
package model;
public class VendaItem {
    private int id;
    private int vendaId;
    private int produtoId;
    private int quantidade;
    private double precoUnit;
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getVendaId() { return vendaId; }
    public void setVendaId(int vendaId) { this.vendaId = vendaId; }
    public int getProdutoId() { return produtoId; }
    public void setProdutoId(int produtoId) { this.produtoId = produtoId; }
    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public double getPrecoUnit() { return precoUnit; }
    public void setPrecoUnit(double precoUnit) { this.precoUnit = precoUnit; }
}
