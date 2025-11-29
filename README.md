# 🛒 S.I.V – Sistema Integrado de Vendas

O **S.I.V (Sistema Integrado de Vendas)** é um projeto acadêmico desenvolvido em **Java Web** com foco em gestão comercial, utilizando **JSP, Servlets, MVC, JDBC, MySQL** e **Bootstrap**.  
O objetivo é simular um sistema real de vendas com módulos de cadastro, controle e autenticação.

---

## 🎯 Objetivo do Projeto

O sistema foi criado para gerenciar:

- Cadastro de clientes
- Cadastro de funcionários
- Cadastro de produtos
- Controle de estoque
- Processo de vendas
- Login com autenticação
- Navegação por módulos através de um dashboard

Foi aplicada a arquitetura **MVC (Model–View–Controller)**, separando bem regras de negócio, acesso a dados e interface.

---

## 🛠 Tecnologias Utilizadas

### 🔧 Backend

- **Java 8+**
- JDK 17 
- **JSP (JavaServer Pages)**
- **Servlets**
- **Padrão MVC**
- **DAO (Data Access Object)**
- **JDBC** para conexão com MySQL
- **Apache Tomcat** (9 ou 10)
- **Apache Ant** para build (NetBeans)

### 🎨 Frontend

- **HTML5**
- **CSS3**
- **Bootstrap** (layout responsivo)
- **JavaScript** (validações básicas e interações simples)

### 🗄 Banco de Dados

- **MySQL Server**
- Modelagem de tabelas como:
  - `clientes`
  - `funcionarios`
  - `produtos`
  - `estoque`
  - `usuarios` (login)
- Script SQL incluso na pasta `sql/` (se aplicável)

---

## 📂 Estrutura do Projeto (resumo esboço)

```text
src/
 ├── config/
 │     └── ConectaDB.java          # Classe de conexão com o MySQL
 │
 ├── model/
 │     ├── Cliente.java
 │     ├── Produto.java
 │     ├── Funcionario.java
 │     └── Usuario.java            # Para autenticação de login
 │
 ├── modelDAO/
 │     ├── ClienteDAO.java
 │     ├── ProdutoDAO.java
 │     ├── FuncionarioDAO.java
 │     └── UsuarioDAO.java
 │
 ├── controller/
 │     ├── ClienteController.java
 │     ├── ProdutoController.java
 │     ├── FuncionarioController.java
 │     └── LoginController.java
 │
web/
 ├── index.jsp                     # Pode redirecionar para login
 ├── login.jsp
 ├── dashboard.jsp
 ├── clientes/
 │     ├── clientes-list.jsp
 │     ├── clientes-add.jsp
 │     └── clientes-edit.jsp
 ├── produtos/
 ├── funcionarios/
 ├── vendas/
 └── includes/
       ├── header.jsp
       ├── menu.jsp
       └── footer.jsp
