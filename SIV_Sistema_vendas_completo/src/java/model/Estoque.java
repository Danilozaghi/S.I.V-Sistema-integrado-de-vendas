
package model;
public class Estoque {
    private int id;
    private int produtoId;
    private String tipo;
    private int quantidade;
    private String dataMov;
    private double preco;
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProdutoId() { return produtoId; }
    public void setProdutoId(int produtoId) { this.produtoId = produtoId; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public String getDataMov() { return dataMov; }
    public void setDataMov(String dataMov) { this.dataMov = dataMov; }
    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = preco; }
}
