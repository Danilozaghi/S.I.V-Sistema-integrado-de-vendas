/*
    UMC - Universidade Mogi Das Cruzes
    Author     : Danilo zaghi curan RGM: 11241104139
                 Lucas Flamini Santos RGM: 11241104080
                 Raynan Maciel Oliveira RGM: 11241101964

    Professor: Adilson Lima da Silva

    Projeto: SIV - Sistema Integrado de Vendas
                 
*/



package model;

public class Venda {
    private int id;
    private int clienteId;
    private int produtoId;
    private int quantidade;
    private int funcionarioVendaId;
    private String dataVenda;
    private double total;
    private String clienteNome;
    private String produtoNome;
    private String funcionarioVendaNome;
    private int totalVendasMesFuncionario;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getClienteId() {
        return clienteId;
    }
    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
    }
    public int getProdutoId() {
        return produtoId;
    }
    public void setProdutoId(int produtoId) {
        this.produtoId = produtoId;
    }
    public int getQuantidade() {
        return quantidade;
    }
    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }
    public int getFuncionarioVendaId() {
        return funcionarioVendaId;
    }
    public void setFuncionarioVendaId(int funcionarioVendaId) {
        this.funcionarioVendaId = funcionarioVendaId;
    }
    public String getDataVenda() {
        return dataVenda;
    }
    public void setDataVenda(String dataVenda) {
        this.dataVenda = dataVenda;
    }
    public double getTotal() {
        return total;
    }
    public void setTotal(double total) {
        this.total = total;
    }
    public String getClienteNome() {
        return clienteNome;
    }
    public void setClienteNome(String clienteNome) {
        this.clienteNome = clienteNome;
    }
    public String getProdutoNome() {
        return produtoNome;
    }
    public void setProdutoNome(String produtoNome) {
        this.produtoNome = produtoNome;
    }
    public String getFuncionarioVendaNome() {
        return funcionarioVendaNome;
    }
    public void setFuncionarioVendaNome(String funcionarioVendaNome) {
        this.funcionarioVendaNome = funcionarioVendaNome;
    }
    public int getTotalVendasMesFuncionario() {
        return totalVendasMesFuncionario;
    }
    public void setTotalVendasMesFuncionario(int totalVendasMesFuncionario) {
        this.totalVendasMesFuncionario = totalVendasMesFuncionario;
    }
}
