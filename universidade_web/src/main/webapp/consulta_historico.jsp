<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.ProfessorDAO" %>
<%@ page import="br.com.universidade.dao.TurmaDAO" %>
<%@ page import="br.com.universidade.model.Professor" %>
<%@ page import="br.com.universidade.model.Turma" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sistema Universitário - Histórico Docente</title>
<style>
    /* Estilização Geral com Paleta Premium Unificada */
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0; 
        padding: 0; 
        background-color: #f8fafc; 
        color: #334155;
    }
    
    /* Menu Universal Horizontal */
    .nav { 
        background-color: #1e293b; 
        padding: 15px 30px; 
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .nav a { 
        color: #94a3b8; 
        text-decoration: none; 
        margin-right: 20px; 
        font-weight: 500;
        transition: color 0.3s;
    }
    .nav a:hover { 
        color: #f8fafc; 
    }
    .nav a.active { 
        color: #ffffff; 
        border-bottom: 2px solid #ea580c; /* Destaque Laranja para Histórico */
        padding-bottom: 5px; 
    }

    .main-content {
        padding: 30px;
    }
    h2 {
        color: #0f172a;
        margin-top: 0;
        margin-bottom: 25px;
        font-weight: 600;
    }
    
    .container { 
        display: flex; 
        gap: 30px; 
        align-items: flex-start; 
    }
    
    .card {
        background: #ffffff; 
        padding: 25px; 
        border-radius: 8px; 
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        border: 1px solid #e2e8f0;
    }
    .card h3 {
        margin-top: 0;
        margin-bottom: 20px;
        color: #1e293b;
        font-size: 1.2rem;
        border-bottom: 2px solid #f1f5f9;
        padding-bottom: 10px;
    }
    
    form { width: 320px; }
    label { 
        display: block; 
        margin-bottom: 8px; 
        font-weight: 600; 
        font-size: 0.9rem;
        color: #475569;
    }
    select { 
        width: 100%; 
        padding: 11px; 
        margin-bottom: 20px; 
        border: 1px solid #cbd5e1; 
        border-radius: 6px;
        background-color: #ffffff;
        box-sizing: border-box; 
        font-size: 0.95rem;
        color: #334155;
        transition: border-color 0.3s;
        cursor: pointer;
    }
    select:focus {
        border-color: #ea580c;
        outline: none;
    }
    
    .btn-buscar { 
        background: #ea580c; 
        color: white; 
        padding: 12px; 
        border: none; 
        border-radius: 6px;
        width: 100%; 
        cursor: pointer; 
        font-weight: bold; 
        font-size: 0.95rem;
        transition: background 0.3s;
    }
    .btn-buscar:hover { 
        background: #c2410c; 
    }
    
    .table-container { flex-grow: 1; }
    table { 
        width: 100%; 
        border-collapse: collapse; 
    }
    table th, table td { 
        padding: 14px; 
        text-align: left; 
        border-bottom: 1px solid #e2e8f0;
    }
    table th { 
        background-color: #f1f5f9; 
        color: #475569; 
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 0.05em;
    }
    table tr:hover {
        background-color: #f8fafc;
    }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Professores</a>
        <a href="disciplinas.jsp">Disciplinas</a>
        <a href="aptidao.jsp">Vincular Aptidão</a>
        <a href="turmas.jsp">Cadastrar Turmas</a>
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a>
        <a href="consulta_historico.jsp" class="active">Consulta Histórico</a>
    </div>

    <div class="main-content">
        <h2>Consultar Histórico de Disciplinas por Professor</h2>

        <div class="container">
            <div class="card">
                <h3>Selecionar Docente</h3>
                <form action="consulta_historico.jsp" method="GET">
                    <label>Escolha o Professor:</label>
                    <select name="selProfessor" required>
                        <option value="">-- Escolha um Professor --</option>
                        <%
                            try {
                                ProfessorDAO profDAO = new ProfessorDAO();
                                List<Professor> professores = profDAO.listarTodos();
                                String profSelecionado = request.getParameter("selProfessor");
                                for(Professor p : professores) {
                                    String selected = (profSelecionado != null && profSelecionado.equals(String.valueOf(p.getMatricula()))) ? "selected" : "";
                        %>
                                    <option value="<%= p.getMatricula() %>" <%= selected %>>
                                        <%= p.getNome() %>
                                    </option>
                        <%
                                }
                            } catch(Exception e) {
                                out.println("<option disabled>Erro ao carregar professores</option>");
                            }
                        %>
                    </select>
                    <button type="submit" class="btn-buscar">Gerar Relatório</button>
                </form>
            </div>

            <div class="card table-container">
                <h3>Histórico Académico</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Disciplina Ministrada</th>
                            <th>Carga Horária</th>
                            <th>Alunos Atendidos</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        String matriculaStr = request.getParameter("selProfessor");
                        if(matriculaStr == null || matriculaStr.isEmpty()) {
                            out.println("<tr><td colspan='3' style='text-align:center; color:#94a3b8;'>Selecione um professor ao lado para gerar o relatório.</td></tr>");
                        } else {
                            try {
                                int matricula = Integer.parseInt(matriculaStr);
                                TurmaDAO turmaDAO = new TurmaDAO();
                                List<Turma> historico = turmaDAO.listarHistoricoPorProfessor(matricula);
                                
                                if(historico.isEmpty()) {
                                    out.println("<tr><td colspan='3' style='text-align:center; color:#ef4444; font-weight:500;'>Este professor ainda não possui turmas registradas.</td></tr>");
                                } else {
                                    for(Turma t : historico) {
                    %>
                                        <tr>
                                            <td><b><%= t.getDisciplina().getNomeDisciplina() %></b></td>
                                            <td><%= t.getDisciplina().getCargaHoraria() %> horas</td>
                                            <td><%= t.getNumAlunos() %> alunos</td>
                                        </tr>
                    <%
                                    }
                                }
                            } catch(Exception e) {
                                out.println("<tr><td colspan='3' style='color:#ef4444;'>Erro ao processar histórico: " + e.getMessage() + "</td></tr>");
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>