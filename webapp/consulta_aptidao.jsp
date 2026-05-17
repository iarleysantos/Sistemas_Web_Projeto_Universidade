<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.DisciplinaDAO" %>
<%@ page import="br.com.universidade.dao.ProfessorDAO" %>
<%@ page import="br.com.universidade.model.Disciplina" %>
<%@ page import="br.com.universidade.model.Professor" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Consulta de Professores Aptos</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    form { background: #e0f7fa; padding: 20px; border-radius: 5px; width: 400px; border: 1px solid #b2ebf2; margin-bottom: 20px; }
    select { width: 70%; padding: 8px; box-sizing: border-box; }
    button { background: #00838f; color: white; padding: 8px 15px; border: none; cursor: pointer; font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    table, th, td { border: 1px solid #00838f; padding: 10px; text-align: left; }
    th { background-color: #00838f; color: white; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Cadastrar Professores</a> | 
        <a href="disciplinas.jsp">Cadastrar Disciplinas</a> |
        <a href="aptidao.jsp">Vincular Aptidão</a> |
        <a href="turmas.jsp">Cadastrar Turmas</a> |
        <a href="consulta_aptidao.jsp"><b>Consulta Aptidão</b></a> |
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <h2>Consultar Professores Aptos por Disciplina</h2>
    
    <form action="consulta_aptidao.jsp" method="GET">
        <label>Disciplina:</label>
        <select name="selDisciplina" required>
            <option value="">-- Selecione --</option>
            <%
                try {
                    DisciplinaDAO discDAO = new DisciplinaDAO();
                    List<Disciplina> disciplinas = discDAO.listarTodas();
                    for(Disciplina d : disciplinas) {
                        String selected = d.getCodigoDisciplina().equals(request.getParameter("selDisciplina")) ? "selected" : "";
            %>
                        <option value="<%= d.getCodigoDisciplina() %>" <%= selected %>><%= d.getNomeDisciplina() %></option>
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
        String codDisc = request.getParameter("selDisciplina");
        if (codDisc != null && !codDisc.isEmpty()) {
    %>
        <h3>Professores Aptos Cadastrados:</h3>
        <table>
            <tr>
                <th>Matrícula</th>
                <th>Nome</th>
                <th>E-mail</th>
                <th>Telefone</th>
            </tr>
            <%
                try {
                    ProfessorDAO profDAO = new ProfessorDAO();
                    List<Professor> aptos = profDAO.listarAptosPorDisciplina(codDisc);
                    if(aptos.isEmpty()) {
                        out.println("<tr><td colspan='4'>Nenhum professor apto vinculado a esta disciplina ainda.</td></tr>");
                    } else {
                        for(Professor p : aptos) {
            %>
                            <tr>
                                <td><%= p.getMatricula() %></td>
                                <td><%= p.getNome() %></td>
                                <td><%= p.getEmail() %></td>
                                <td><%= p.getTelefone() %></td>
                            </tr>
            <%
                        }
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='4'>Erro ao buscar dados: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    <%
        }
    %>

</body>
</html>