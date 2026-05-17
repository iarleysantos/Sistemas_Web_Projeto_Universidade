package br.com.universidade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import br.com.universidade.factory.FabricaConexao;
import br.com.universidade.model.ProfessorApto;

public class ProfessorAptoDAO {

    // Método para vincular a aptidão no banco
    public void cadastrarAptidao(ProfessorApto aptidao) throws Exception {
        String sql = "INSERT INTO professor_apto (matricula_professor, codigo_disciplina) VALUES (?, ?)";
        
        Connection conn = null;
        PreparedStatement pstm = null;
        
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            
            // Pega a matrícula de dentro do objeto Professor que está dentro de Aptidao
            pstm.setInt(1, aptidao.getProfessor().getMatricula());
            // Pega o código de dentro do objeto Disciplina que está dentro de Aptidao
            pstm.setString(2, aptidao.getDisciplina().getCodigoDisciplina());
            
            pstm.execute();
            System.out.println("Aptidão vinculada com sucesso!");
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }
}