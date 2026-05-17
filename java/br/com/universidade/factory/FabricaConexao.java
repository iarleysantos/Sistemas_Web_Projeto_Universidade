package br.com.universidade.factory;

import java.sql.Connection;
import java.sql.DriverManager;

public class FabricaConexao {
    
    // Configurações do MySQL do seu XAMPP
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // Padrão do XAMPP é vazio
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/universidade?useTimezone=true&serverTimezone=UTC";

    public static Connection criarConexao() throws Exception {
        // Carrega o driver do MySQL na memória do Java
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Abre e retorna a conexão com o banco 'universidade'
        Connection conexao = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
        return conexao;
    }

    public static void main(String[] args) {
        // Teste rápido para ver se o Java consegue falar com o MySQL
        try {
            System.out.println("Tentando conectar ao banco de dados...");
            Connection con = criarConexao();
            
            if (con != null) {
                System.out.println("CONEXÃO REALIZADA COM SUCESSO! O Java e o MySQL estão conversando!");
                con.close(); // Fecha a conexão de teste
            }
        } catch (Exception e) {
            System.out.println("Ops, deu erro ao conectar: " + e.getMessage());
            e.printStackTrace();
        }
    }
}