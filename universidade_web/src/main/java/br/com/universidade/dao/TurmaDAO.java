package br.com.universidade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import br.com.universidade.factory.FabricaConexao;
import br.com.universidade.model.Turma;
import br.com.universidade.model.Disciplina;

public class TurmaDAO {

    // 1. CADASTRAR TURMA
    public void cadastrarTurma(Turma turma) throws Exception {
        // SQL completo com as 6 colunas exatamente iguais ao phpMyAdmin
        String sql = "INSERT INTO turmas (codigo_turma, matricula_professor, codigo_disciplina, semestre, num_alunos, horario) VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstm = null;
        
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            
            pstm.setString(1, turma.getIdTurma());
            pstm.setInt(2, turma.getProfessor().getMatricula());
            pstm.setString(3, turma.getDisciplina().getCodigoDisciplina());
            pstm.setString(4, turma.getSemestre());
            pstm.setInt(5, turma.getNumAlunos());
            pstm.setString(6, turma.getHorario());
            
            pstm.execute();
            System.out.println("Turma cadastrada com sucesso no banco de dados!");
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // 2. CONSULTAR HISTÓRICO
    public List<Turma> listarHistoricoPorProfessor(int matriculaProfessor) throws Exception {
        String sql = "SELECT d.nome_disciplina, d.carga_horaria, t.num_alunos " +
                     "FROM turmas t " +
                     "INNER JOIN disciplinas d ON t.codigo_disciplina = d.codigo_disciplina " +
                     "WHERE t.matricula_professor = ?";
                     
        List<Turma> lista = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rst = null;
        
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, matriculaProfessor);
            rst = pstm.executeQuery();
            
            while (rst.next()) {
                Turma t = new Turma();
                t.setNumAlunos(rst.getInt("num_alunos"));
                
                Disciplina d = new Disciplina();
                d.setNomeDisciplina(rst.getString("nome_disciplina"));
                d.setCargaHoraria(rst.getInt("carga_horaria"));
                
                t.setDisciplina(d);
                lista.add(t);
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
}