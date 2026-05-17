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
<title>Vincular Aptidão</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    form { background: #e2e3e5; padding: 20px; border-radius: 5px; width: 400px; border: 1px solid #d6d8db; }
    select { width: 100%; padding: 8px; margin: 6px 0 12px 0; box-sizing: border-box; }
    button { background: #6c757d; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; font-weight: bold; }
    button:hover { background: #5a6268; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Cadastrar Professores</a> | 
        <a href="disciplinas.jsp">Cadastrar Disciplinas</a> |
        <a href="aptidao.jsp"><b>Vincular Aptidão</b></a> |
        <a href="turmas.jsp">Cadastrar Turmas</a> |
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a> |
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <h2>Vincular Aptidão de Professor</h2>
    
    <form action="ProfessorAptoServlet" method="POST">
        <label>Selecione o Professor:</label>
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
        
        <button type="submit">Salvar Vinculo</button>
    </form>

</body>
</html>