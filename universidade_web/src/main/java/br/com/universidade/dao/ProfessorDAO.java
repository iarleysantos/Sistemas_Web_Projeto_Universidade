package br.com.universidade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import br.com.universidade.factory.FabricaConexao;
import br.com.universidade.model.Professor;

public class ProfessorDAO {

    // 1. INCLUIR (Item 2.a)
    public void cadastrar(Professor professor) throws Exception {
        String sql = "INSERT INTO Professores (matricula, nome, email, telefone) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, professor.getMatricula());
            pstm.setString(2, professor.getNome());
            pstm.setString(3, professor.getEmail());
            pstm.setString(4, professor.getTelefone());
            pstm.execute();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // 2. CONSULTAR / LISTAR (Item 2.a)
    public List<Professor> listarTodos() throws Exception {
        String sql = "SELECT * FROM Professores";
        List<Professor> lista = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rst = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            rst = pstm.executeQuery();
            while (rst.next()) {
                Professor professor = new Professor();
                professor.setMatricula(rst.getInt("matricula"));
                professor.setNome(rst.getString("nome"));
                professor.setEmail(rst.getString("email"));
                professor.setTelefone(rst.getString("telefone"));
                lista.add(professor);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (rst != null) rst.close();
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
        return lista;
    }

    // 3. ALTERAR (Item 2.a - NOVO)
    public void alterar(Professor professor) throws Exception {
        String sql = "UPDATE Professores SET nome = ?, email = ?, telefone = ? WHERE matricula = ?";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, professor.getNome());
            pstm.setString(2, professor.getEmail());
            pstm.setString(3, professor.getTelefone());
            pstm.setInt(4, professor.getMatricula());
            pstm.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // 4. EXCLUIR (Item 2.a - NOVO)
    public void excluir(int matricula) throws Exception {
        String sql = "DELETE FROM Professores WHERE matricula = ?";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, matricula);
            pstm.execute();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

 // Método para buscar professores aptos por disciplina (Item 2.e)
    public List<Professor> buscarProfessoresAptos(String codigoDisciplina) throws Exception {
        String sql = "SELECT p.* FROM Professores p " +
                     "INNER JOIN Professor_Apto pa ON p.matricula = pa.matricula_professor " +
                     "WHERE pa.codigo_disciplina = ?";
        List<Professor> lista = new ArrayList<>();
        java.sql.Connection conn = null;
        java.sql.PreparedStatement pstm = null;
        java.sql.ResultSet rst = null;
        try {
            conn = br.com.universidade.factory.FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, codigoDisciplina);
            rst = pstm.executeQuery();
            while (rst.next()) {
                Professor p = new Professor();
                p.setMatricula(rst.getInt("matricula"));
                p.setNome(rst.getString("nome"));
                p.setEmail(rst.getString("email"));
                p.setTelefone(rst.getString("telefone"));
                lista.add(p);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (rst != null) rst.close();
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
        return lista;
    }

    // Buscar o histórico e totais de disciplinas ministradas (Item 2.f)
    public List<Map<String, Object>> obterHistoricoMinistrado(int matricula) throws Exception {
        String sql = "SELECT d.nome_disciplina, SUM(d.carga_horaria) AS total_horas, SUM(t.num_alunos) AS total_alunos " +
                     "FROM turmas t " +
                     "INNER JOIN disciplinas d ON t.codigo_disciplina = d.codigo_disciplina " +
                     "WHERE t.matricula_professor = ? " +
                     "GROUP BY d.nome_disciplina";
        List<Map<String, Object>> relatorio = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rst = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, matricula);
            rst = pstm.executeQuery();
            while (rst.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("nome_disciplina", rst.getString("nome_disciplina"));
                linha.put("total_horas", rst.getInt("total_horas"));
                linha.put("total_alunos", rst.getInt("total_alunos"));
                relatorio.add(linha);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (rst != null) rst.close();
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
        return relatorio;
    }
}