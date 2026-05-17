<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.ProfessorDAO" %>
<%@ page import="br.com.universidade.model.Professor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Histórico do Professor</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    form { background: #e8f5e9; padding: 20px; border-radius: 5px; width: 400px; border: 1px solid #c8e6c9; margin-bottom: 20px; }
    select { width: 70%; padding: 8px; box-sizing: border-box; }
    button { background: #2e7d32; color: white; padding: 8px 15px; border: none; cursor: pointer; font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    table, th, td { border: 1px solid #2e7d32; padding: 10px; text-align: left; }
    th { background-color: #2e7d32; color: white; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Cadastrar Professores</a> | 
        <a href="disciplinas.jsp">Cadastrar Disciplinas</a> |
        <a href="aptidao.jsp">Vincular Aptidão</a> |
        <a href="turmas.jsp">Cadastrar Turmas</a> |
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a> |
        <a href="consulta_historico.jsp"><b>Consulta Histórico</b></a>
    </div>

    <h2>Consultar Histórico de Disciplinas por Professor</h2>
    
    <form action="consulta_historico.jsp" method="GET">
        <label>Professor:</label>
        <select name="selProfessor" required>
            <option value="">-- Selecione --</option>
            <%
                try {
                    ProfessorDAO profDAO = new ProfessorDAO();
                    List<Professor> professores = profDAO.listarTodos();
                    for(Professor p : professores) {
                        String strMatricula = String.valueOf(p.getMatricula());
                        String selected = strMatricula.equals(request.getParameter("selProfessor")) ? "selected" : "";
            %>
                        <option value="<%= p.getMatricula() %>" <%= selected %>><%= p.getNome() %></option>
            <%
                    }
                } catch(Exception e) {
                    out.println("<option value=''>Erro ao carregar</option>");
                }
            %>
        </select>
        <button type="submit">Buscar</button>
    </form>

    <%
        String matStr = request.getParameter("selProfessor");
        if (matStr != null && !matStr.isEmpty()) {
            int matricula = Integer.parseInt(matStr);
    %>
        <h3>Histórico e Totais do Professor:</h3>
        <table>
            <tr>
                <th>Disciplina Ministrada</th>
                <th>Carga Horária Total (Acumulada)</th>
                <th>Quantidade Total de Alunos</th>
            </tr>
            <%
                try {
                    ProfessorDAO profDAO = new ProfessorDAO();
                    List<Map<String, Object>> historico = profDAO.obterHistoricoMinistrado(matricula);
                    if(historico.isEmpty()) {
                        out.println("<tr><td colspan='3'>Este professor ainda não ministrou nenhuma turma.</td></tr>");
                    } else {
                        for(Map<String, Object> linha : historico) {
            %>
                            <tr>
                                <td><%= linha.get("nome_disciplina") %></td>
                                <td><%= linha.get("total_horas") %> horas</td>
                                <td><%= linha.get("total_alunos") %> alunos</td>
                            </tr>
            <%
                        }
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='3'>Erro ao processar histórico: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    <%
        }
    %>

</body>
</html>