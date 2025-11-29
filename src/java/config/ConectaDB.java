package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConectaDB {

    // AJUSTE AQUI se o nome do banco for outro
    private static final String URL = "jdbc:mysql://localhost:3306/siv?useSSL=false&serverTimezone=UTC";

    // AJUSTE AQUI pro usuário/senha que você usa no MySQL Workbench
    private static final String USER = "root";      // ex: "root"
    private static final String PASSWORD = "";      // ex: "" se não tiver senha

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✔ Conectado ao banco SIV!");
        } catch (Exception e) {
            System.out.println("✘ ERRO AO CONECTAR NO BANCO:");
            e.printStackTrace();
        }
        return conn;
    }

    // compatível com código antigo (ClienteDAO, SalvarImagem etc.)
    public static Connection conectar() {
        return getConnection();
    }
}
