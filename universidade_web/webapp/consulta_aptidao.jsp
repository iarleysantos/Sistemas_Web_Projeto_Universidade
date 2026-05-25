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
<title>Sistema Universitário - Consultar Aptidão</title>
<style>
    /* Estilização Geral com Paleta Premium Unificada */
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0; 
        padding: 0; 
        background-color: #f8fafc; /* Mesmo Cinza Gelo */
        color: #334155;
    }
    
    /* Menu Universal Horizontal */
    .nav { 
        background-color: #1e293b; /* Mesmo Azul Slate Escuro */
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
        border-bottom: 2px solid #3b82f6; /* Destaque Azul Royal para Consultas */
        padding-bottom: 5px; 
    }

    /* Conteúdo Principal */
    .main-content {
        padding: 30px;
    }
    h2 {
        color: #0f172a;
        margin-top: 0;
        margin-bottom: 25px;
        font-weight: 600;
    }
    
    /* Container dos Cards */
    .container { 
        display: flex; 
        gap: 30px; 
        align-items: flex-start; 
    }
    
    /* Estilo dos Cards (Efeito Flutuante) */
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
    
    /* Formulário de Busca */
    form { width: 300px; }
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
        border-color: #3b82f6;
        outline: none;
    }
    
    /* Botão de Busca Executivo */
    .btn-buscar { 
        background: #3b82f6; 
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
        background: #2563eb; 
    }
    
    /* Tabela de Resultados */
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
        <a href="consulta_aptidao.jsp" class="active">Consulta Aptidão</a>
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <div class="main-content">
        <h2>Consultar Professores Aptos por Disciplina</h2>

        <div class="container">
            <div class="card">
                <h3>Selecionar Filtro</h3>
                <form action="consulta_aptidao.jsp" method="GET">
                    <label>Escolha a Disciplina:</label>
                    <select name="selDisciplina" required>
                        <option value="">-- Escolha uma Disciplina --</option>
                        <%
                            try {
                                DisciplinaDAO discDAO = new DisciplinaDAO();
                                List<Disciplina> disciplinas = discDAO.listarTodas();
                                String codSelecionado = request.getParameter("selDisciplina");
                                for(Disciplina d : disciplinas) {
                                    String selected = (codSelecionado != null && codSelecionado.equals(d.getCodigoDisciplina())) ? "selected" : "";
                        %>
                                    <option value="<%= d.getCodigoDisciplina() %>" <%= selected %>>
                                        <%= d.getNomeDisciplina() %>
                                    </option>
                        <%
                                }
                            } catch(Exception e) {
                                out.println("<option disabled>Erro ao carregar disciplinas</option>");
                            }
                        %>
                    </select>
                    <button type="submit" class="btn-buscar">Filtrar Professores</button>
                </form>
            </div>

            <div class="card table-container">
                <h3>Professores Habilitados</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Matrícula</th>
                            <th>Nome do Professor</th>
                            <th>E-mail</th>
                            <th>Telefone</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        String codDisciplina = request.getParameter("selDisciplina");
                        if(codDisciplina == null || codDisciplina.isEmpty()) {
                            out.println("<tr><td colspan='4' style='text-align:center; color:#94a3b8;'>Selecione uma disciplina ao lado para pesquisar.</td></tr>");
                        } else {
                            try {
                                ProfessorDAO profDAO = new ProfessorDAO();
                                // Chama o método buscarAptos que criamos no DAO passando o código da tela
                                List<Professor> aptos = profDAO.buscarProfessoresAptos(codDisciplina);
                                if(aptos.isEmpty()) {
                                    out.println("<tr><td colspan='4' style='text-align:center; color:#ef4444; font-weight:500;'>Nenhum professor com aptidão vinculada para esta disciplina.</td></tr>");
                                } else {
                                    for(Professor p : aptos) {
                    %>
                                        <tr>
                                            <td><b><%= p.getMatricula() %></b></td>
                                            <td><%= p.getNome() %></td>
                                            <td><%= p.getEmail() %></td>
                                            <td><%= p.getTelefone() != null ? p.getTelefone() : "-" %></td>
                                        </tr>
                    <%
                                    }
                                }
                            } catch(Exception e) {
                                out.println("<tr><td colspan='4' style='color:#ef4444;'>Erro ao processar consulta: " + e.getMessage() + "</td></tr>");
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