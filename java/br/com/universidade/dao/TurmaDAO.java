package br.com.universidade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import br.com.universidade.factory.FabricaConexao;
import br.com.universidade.model.Turma;

public class TurmaDAO {

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
}