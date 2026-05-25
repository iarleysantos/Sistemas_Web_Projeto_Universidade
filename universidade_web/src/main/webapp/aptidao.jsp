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
<title>Sistema Universitário - Vincular Aptidão</title>
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
        border-bottom: 2px solid #6366f1; /* Destaque Índigo/Roxo Moderno para Aptidão */
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
    
    /* Centralizador do Card */
    .container { 
        display: flex; 
        justify-content: flex-start;
    }
    
    /* Estilo do Card (Efeito Flutuante) */
    .card {
        background: #ffffff; 
        padding: 30px; 
        border-radius: 8px; 
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        border: 1px solid #e2e8f0;
        width: 400px; /* Largura confortável para os selects */
    }
    .card h3 {
        margin-top: 0;
        margin-bottom: 25px;
        color: #1e293b;
        font-size: 1.2rem;
        border-bottom: 2px solid #f1f5f9;
        padding-bottom: 10px;
    }
    
    /* Formulários e Selects Elegantes */
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
        margin-bottom: 25px; 
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
        border-color: #6366f1; /* Foco Índigo */
        outline: none;
    }
    
    /* Botão Roxo/Índigo Moderno */
    .btn-salvar { 
        background: #6366f1; 
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
    .btn-salvar:hover { 
        background: #4f46e5; 
    }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Professores</a>
        <a href="disciplinas.jsp">Disciplinas</a>
        <a href="aptidao.jsp" class="active">Vincular Aptidão</a>
        <a href="turmas.jsp">Cadastrar Turmas</a>
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a>
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <div class="main-content">
        <h2>Vincular Aptidão de Professor</h2>

        <div class="container">
            <div class="card">
                <h3>Mapear Competência Docente</h3>
                <form action="ProfessorAptoServlet" method="POST">
                    
                    <label>Selecione o Professor:</label>
                    <select name="selProfessor" required>
                        <option value="">-- Escolha um Professor --</option>
                        <%
                            try {
                                ProfessorDAO profDAO = new ProfessorDAO();
                                List<Professor> professores = profDAO.listarTodos();
                                for(Professor p : professores) {
                        %>
                                    <option value="<%= p.getMatricula() %>">
                                        <%= p.getMatricula() %> - <%= p.getNome() %>
                                    </option>
                        <%
                                }
                            } catch(Exception e) {
                                out.println("<option disabled>Erro ao carregar professores</option>");
                            }
                        %>
                    </select>
                    
                    <label>Selecione a Disciplina:</label>
                    <select name="selDisciplina" required>
                        <option value="">-- Escolha uma Disciplina --</option>
                        <%
                            try {
                                DisciplinaDAO discDAO = new DisciplinaDAO();
                                List<Disciplina> disciplinas = discDAO.listarTodas();
                                for(Disciplina d : disciplinas) {
                        %>
                                    <option value="<%= d.getCodigoDisciplina() %>">
                                        <%= d.getCodigoDisciplina() %> - <%= d.getNomeDisciplina() %>
                                    </option>
                        <%
                                }
                            } catch(Exception e) {
                                out.println("<option disabled>Erro ao carregar disciplinas</option>");
                            }
                        %>
                    </select>
                    
                    <button type="submit" class="btn-salvar">Salvar Vínculo de Aptidão</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>