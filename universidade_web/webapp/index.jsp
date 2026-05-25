<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.ProfessorDAO" %>
<%@ page import="br.com.universidade.model.Professor" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sistema Universitário - Professores</title>
<style>
    /* Estilização Geral com Paleta Premium */
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0; 
        padding: 0; 
        background-color: #f8fafc; /* Cinza Gelo de Fundo */
        color: #334155;
    }
    
    /* Menu Universal Horizontal Modernizado */
    .nav { 
        background-color: #1e293b; /* Azul Slate Escuro */
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
        border-bottom: 2px solid #3b82f6; 
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
    
    /* Formulários Elegantes */
    form { width: 320px; }
    label { 
        display: block; 
        margin-bottom: 6px; 
        font-weight: 600; 
        font-size: 0.9rem;
        color: #475569;
    }
    input { 
        width: 100%; 
        padding: 10px; 
        margin-bottom: 15px; 
        border: 1px solid #cbd5e1; 
        border-radius: 6px;
        box-sizing: border-box; 
        font-size: 0.95rem;
        transition: border-color 0.3s;
    }
    input:focus {
        border-color: #3b82f6;
        outline: none;
    }
    
    /* Botão Azul Royal Suave */
    .btn-salvar { 
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
    .btn-salvar:hover { 
        background: #2563eb; 
    }
    
    /* Tabela de Consulta Moderna */
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
    
    /* Links de Ações */
    .btn-editar { color: #3b82f6; text-decoration: none; font-weight: 600; margin-right: 15px; }
    .btn-editar:hover { text-decoration: underline; }
    .btn-excluir { color: #ef4444; text-decoration: none; font-weight: 600; }
    .btn-excluir:hover { text-decoration: underline; }
    
    .cancel-link { display: block; text-align: center; margin-top: 15px; color: #64748b; text-decoration: none; font-size: 0.9rem; }
    .cancel-link:hover { text-decoration: underline; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp" class="active">Professores</a>
        <a href="disciplinas.jsp">Disciplinas</a>
        <a href="aptidao.jsp">Vincular Aptidão</a>
        <a href="turmas.jsp">Cadastrar Turmas</a>
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a>
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <div class="main-content">
        <h2>Gerenciamento de Professores</h2>

        <%
            // Lógica para verificar modo edição
            String matEditar = request.getParameter("editMatricula");
            String nomeEditar = "";
            String emailEditar = "";
            String teleEditar = "";
            boolean modoEdicao = false;

            if (matEditar != null && !matEditar.isEmpty()) {
                int mat = Integer.parseInt(matEditar);
                ProfessorDAO dao = new ProfessorDAO();
                List<Professor> lista = dao.listarTodos();
                for(Professor p : lista) {
                    if(p.getMatricula() == mat) {
                        nomeEditar = p.getNome();
                        emailEditar = p.getEmail();
                        teleEditar = p.getTelefone();
                        modoEdicao = true;
                        break;
                    }
                }
            }
        %>

        <div class="container">
            <div class="card">
                <h3><%= modoEdicao ? "Editar Informações" : "Cadastrar Novo Professor" %></h3>
                <form action="ProfessorServlet" method="POST">
                    
                    <% if(modoEdicao) { %>
                        <input type="hidden" name="acao" value="alterar">
                    <% } %>

                    <label>Matrícula</label>
                    <input type="number" name="txtMatricula" value="<%= matEditar != null ? matEditar : "" %>" <%= modoEdicao ? "readonly style='background:#f1f5f9; color:#94a3b8;'" : "" %> required>
                    
                    <label>Nome Completo</label>
                    <input type="text" name="txtNome" value="<%= nomeEditar %>" required>
                    
                    <label>E-mail Corporativo</label>
                    <input type="email" name="txtEmail" value="<%= emailEditar %>" required>
                    
                    <label>Telefone de Contato</label>
                    <input type="text" name="txtTelefone" value="<%= teleEditar %>" placeholder="(85) 99999-9999">
                    
                    <button type="submit" class="btn-salvar">
                        <%= modoEdicao ? "Salvar Alterações" : "Cadastrar Professor" %>
                    </button>
                    
                    <% if(modoEdicao) { %>
                        <a href="index.jsp" class="cancel-link">Cancelar Edição</a>
                    <% } %>
                </form>
            </div>

            <div class="card table-container">
                <h3>Professores Cadastrados</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Matrícula</th>
                            <th>Nome</th>
                            <th>E-mail</th>
                            <th>Telefone</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            ProfessorDAO dao = new ProfessorDAO();
                            List<Professor> professores = dao.listarTodos();
                            if(professores.isEmpty()) {
                                out.println("<tr><td colspan='5' style='text-align:center; color:#94a3b8;'>Nenhum professor registrado até o momento.</td></tr>");
                            } else {
                                for(Professor p : professores) {
                    %>
                                    <tr>
                                        <td><b><%= p.getMatricula() %></b></td>
                                        <td><%= p.getNome() %></td>
                                        <td><%= p.getEmail() %></td>
                                        <td><%= p.getTelefone() != null ? p.getTelefone() : "-" %></td>
                                        <td>
                                            <a class="btn-editar" href="index.jsp?editMatricula=<%= p.getMatricula() %>">Editar</a>
                                            <a class="btn-excluir" href="ProfessorServlet?acao=excluir&matricula=<%= p.getMatricula() %>" onclick="return confirm('Deseja realmente remover este professor?');">Excluir</a>
                                        </td>
                                    </tr>
                    <%
                                }
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='5' style='color:#ef4444;'>Erro ao ler dados: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>