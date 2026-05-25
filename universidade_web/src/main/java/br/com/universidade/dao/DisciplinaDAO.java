package br.com.universidade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import br.com.universidade.factory.FabricaConexao;
import br.com.universidade.model.Disciplina;

public class DisciplinaDAO {

    // 1. INCLUIR (Item 2.b)
    public void cadastrar(Disciplina disciplina) throws Exception {
        String sql = "INSERT INTO Disciplinas (codigo_disciplina, nome_disciplina, carga_horaria) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, disciplina.getCodigoDisciplina());
            pstm.setString(2, disciplina.getNomeDisciplina());
            pstm.setInt(3, disciplina.getCargaHoraria());
            pstm.execute();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // 2. CONSULTAR / LISTAR (Item 2.b)
    public List<Disciplina> listarTodas() throws Exception {
        String sql = "SELECT * FROM Disciplinas";
        List<Disciplina> lista = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rst = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            rst = pstm.executeQuery();
            while (rst.next()) {
                Disciplina d = new Disciplina();
                d.setCodigoDisciplina(rst.getString("codigo_disciplina"));
                d.setNomeDisciplina(rst.getString("nome_disciplina"));
                d.setCargaHoraria(rst.getInt("carga_horaria"));
                lista.add(d);
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

    // 3. ALTERAR (Item 2.b - O que o Servlet estava sentindo falta!)
    public void alterar(Disciplina disciplina) throws Exception {
        String sql = "UPDATE Disciplinas SET nome_disciplina = ?, carga_horaria = ? WHERE codigo_disciplina = ?";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, disciplina.getNomeDisciplina());
            pstm.setInt(2, disciplina.getCargaHoraria());
            pstm.setString(3, disciplina.getCodigoDisciplina());
            pstm.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // 4. EXCLUIR (Item 2.b - O outro que o Servlet estava procurando!)
    public void excluir(String codigoDisciplina) throws Exception {
        String sql = "DELETE FROM Disciplinas WHERE codigo_disciplina = ?";
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            conn = FabricaConexao.criarConexao();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, codigoDisciplina);
            pstm.execute();
        } catch (Exception e) {
            throw e;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }
}