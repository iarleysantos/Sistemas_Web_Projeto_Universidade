<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.ProfessorDAO" %>
<%@ page import="br.com.universidade.dao.DisciplinaDAO" %>
<%@ page import="br.com.universidade.model.Professor" %>
<%@ page import="br.com.universidade.model.Disciplina" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Turmas</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    form { background: #d4edda; padding: 20px; border-radius: 5px; width: 400px; border: 1px solid #c3e6cb; }
    input, select { width: 100%; padding: 8px; margin: 6px 0 12px 0; box-sizing: border-box; }
    button { background: #28a745; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; font-weight: bold; }
    button:hover { background: #218838; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Cadastrar Professores</a> | 
        <a href="disciplinas.jsp">Cadastrar Disciplinas</a> |
        <a href="aptidao.jsp">Vincular Aptidão</a> |
        <a href="turmas.jsp"><b>Cadastrar Turmas</b></a> |
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a> |
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <h2>Cadastro de Nova Turma</h2>
    
    <form action="TurmaServlet" method="POST">
        
        <label>Código/Identificador da Turma (Ex: T-ADS-01):</label>
        <input type="text" name="txtIdTurma" required>
        
        <label>Selecione a Disciplina:</label>
        <select name="selDisciplina" required>
            <option value="">-- Selecione --</option>
            <%
                try {
                    DisciplinaDAO discDAO = new DisciplinaDAO();
                    List<Disciplina> disciplinas = discDAO.listarTodas();
                    for(Disciplina d : disciplinas) {
            %>
                        <option value="<%= d.getCodigoDisciplina() %>"><%= d.getNomeDisciplina() %></option>
            <%
                    }
                } catch(Exception e) {
                    out.println("<option value=''>Erro ao carregar disciplinas</option>");
                }
            %>
        </select>
        
        <label>Selecione o Professor Responsável:</label>
        <select name="selProfessor" required>
            <option value="">-- Selecione --</option>
            <%
                try {
                    ProfessorDAO profDAO = new ProfessorDAO();
                    List<Professor> professores = profDAO.listarTodos();
                    for(Professor p : professores) {
            %>
                        <option value="<%= p.getMatricula() %>"><%= p.getNome() %></option>
            <%
                    }
                } catch(Exception e) {
                    out.println("<option value=''>Erro ao carregar professores</option>");
                }
            %>
        </select>
        
        <label>Semestre/Ano Letivo:</label>
        <input type="text" name="txtSemestre" placeholder="Ex: 2026.1" required>

        <label>Quantidade de Alunos:</label>
        <input type="number" name="txtNumAlunos" min="0" placeholder="Ex: 30" required>
        
        <label>Horário/Turno das Aulas:</label>
        <select name="txtHorario" required>
            <option value="">-- Selecione o Turno --</option>
            <option value="Manhã">Manhã</option>
            <option value="Tarde">Tarde</option>
            <option value="Noite">Noite</option>
        </select>
        
        <button type="submit">Salvar Turma</button>
    </form>

</body>
</html>