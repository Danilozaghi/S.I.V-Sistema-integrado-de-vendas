### Modificações aplicadas automaticamente (versão final)
Data: 2025-11-21T00:07:54.377906

O que foi adicionado/ajustado:
- CRUD completo (DAO + Servlet + JSP Bootstrap) para:
  - Clientes: /clientes
  - Funcionários: /funcionarios
  - Produtos: /produtos
- SQL de criação: siv_schema.sql (cria tabelas e usuário admin)
- Filtro de autenticação (preservei o AuthFilter)
- web/WEB-INF/web.xml se ausente
- README_AUTOMATED_UPDATE.md com instruções básicas

Como testar localmente:
1. Importar projeto no NetBeans/Eclipse/IDE.
2. Ajustar `src/java/config/ConectaDB.java` com usuário/senha do MySQL.
3. Executar o script `siv_schema.sql` no MySQL Workbench para criar o banco e tabelas.
4. Deploy no Tomcat. Acesse:
   - /login.jsp para autenticação
   - /clientes, /funcionarios, /produtos para gerenciar entidades (após login)
Notas:
- O sistema ainda usa senhas em texto para login (conforme código original). Recomendo migrar para hashing (BCrypt) futuramente.
- Mantive seus arquivos originais; os novos estão em `src/java/controller` e `src/java/model/DAO` e as páginas em `web/clientes`, `web/funcionarios`, `web/produtos`.

Correção extra: login.jsp agora usa LoginServlet e o dashboard.jsp checa 'usuarioLogado'; Servlets aceitam URLs antigas (ClienteServlet/ProdutoServlet/FuncionarioServlet) e novas (/clientes,/produtos,/funcionarios).