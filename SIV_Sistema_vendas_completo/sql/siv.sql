-- SIV schema (MySQL) - compatível com os DAOs atuais + módulos de Compras/Vendas com funcionários

CREATE DATABASE IF NOT EXISTS siv
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE siv;

-- Usuários (login)
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  login VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL
);

-- usuários padrão
INSERT INTO usuarios (login, senha) VALUES
  ('Danilo', 'admin'),
  ('Raynan maciel', 'admin'),
  ('Lucas', 'admin');

---------------------------------------------------
-- Clientes
---------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome     VARCHAR(150) NOT NULL,
  cpf      VARCHAR(30),
  email    VARCHAR(150),
  telefone VARCHAR(40),
  endereco VARCHAR(255)
);

---------------------------------------------------
-- Produtos
---------------------------------------------------
CREATE TABLE IF NOT EXISTS produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome      VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco     DECIMAL(10,2) DEFAULT 0.00,
  estoque   INT DEFAULT 0
);

---------------------------------------------------
-- Funcionários
---------------------------------------------------
CREATE TABLE IF NOT EXISTS funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome     VARCHAR(150) NOT NULL,
  cpf      VARCHAR(30),
  email    VARCHAR(150),
  telefone VARCHAR(40),
  cargo    VARCHAR(100),
  imagem   VARCHAR(255)
);

---------------------------------------------------
-- Fornecedores
---------------------------------------------------
CREATE TABLE IF NOT EXISTS fornecedor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cnpj VARCHAR(30)
);

---------------------------------------------------
-- Estoque (movimentações)
-- Gerado automaticamente por Compras (ENTRADA)
-- e por Vendas (SAIDA)
---------------------------------------------------
CREATE TABLE IF NOT EXISTS estoque (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produto_id INT NOT NULL,
  tipo       VARCHAR(20) NOT NULL, -- ENTRADA ou SAIDA
  quantidade INT NOT NULL,
  data_mov   DATE,
  preco      DECIMAL(10,2),
  CONSTRAINT fk_estoque_produto FOREIGN KEY (produto_id)
    REFERENCES produtos(id) ON DELETE CASCADE
);

---------------------------------------------------
-- Vendas
---------------------------------------------------
CREATE TABLE IF NOT EXISTS venda (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  produto_id INT,
  quantidade INT,
  funcionario_venda_id INT,
  data_venda DATE,
  total      DECIMAL(10,2),
  CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id)
    REFERENCES clientes(id) ON DELETE SET NULL,
  CONSTRAINT fk_venda_produto FOREIGN KEY (produto_id)
    REFERENCES produtos(id) ON DELETE SET NULL,
  CONSTRAINT fk_venda_funcionario FOREIGN KEY (funcionario_venda_id)
    REFERENCES funcionarios(id) ON DELETE SET NULL
);

---------------------------------------------------
-- Compras
---------------------------------------------------
CREATE TABLE IF NOT EXISTS compra (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fornecedor_id INT,
  produto_id    INT,
  funcionario_compra_id INT,
  data_compra   DATE,
  quantidade    INT,
  preco_unit    DECIMAL(10,2),
  valor_total   DECIMAL(10,2),
  CONSTRAINT fk_compra_fornecedor FOREIGN KEY (fornecedor_id)
    REFERENCES fornecedor(id) ON DELETE SET NULL,
  CONSTRAINT fk_compra_produto FOREIGN KEY (produto_id)
    REFERENCES produtos(id) ON DELETE CASCADE,
  CONSTRAINT fk_compra_funcionario FOREIGN KEY (funcionario_compra_id)
    REFERENCES funcionarios(id) ON DELETE SET NULL
);

ALTER TABLE clientes
  ADD COLUMN renda DECIMAL(10,2) NULL,
  ADD COLUMN celular VARCHAR(40) NULL,
  ADD COLUMN nasc DATE NULL;
