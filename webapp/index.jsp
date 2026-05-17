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
    body { font-family: Arial, sans-serif; margin: 30px; }
    .container { display: flex; gap: 40px; align-items: flex-start; }
    form { background: #f8f9fa; padding: 20px; border-radius: 5px; width: 350px; border: 1px solid #ced4da; }
    input { width: 100%; padding: 8px; margin: 6px 0 12px 0; box-sizing: border-box; }
    .btn-salvar { background: #007bff; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; font-weight: bold; }
    .btn-salvar:hover { background: #0069d9; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    table, th, td { border: 1px solid #ced4da; padding: 10px; text-align: left; }
    th { background-color: #007bff; color: white; }
    .btn-excluir { color: red; text-decoration: none; font-weight: bold; margin-left: 10px; }
    .btn-editar { color: #007bff; text-decoration: none; font-weight: bold; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp"><b>Cadastrar Professores</b></a> | 
        <a href="disciplinas.jsp">Cadastrar Disciplinas</a> |
        <a href="aptidao.jsp">Vincular Aptidão</a> |
        <a href="turmas.jsp">Cadastrar Turmas</a> |
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a> |
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <h2>Gerenciamento de Professores</h2>

    <%
        // Lógica para verificar se o usuário clicou em "Editar" algum professor da tabela
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
        <div>
            <h3><%= modoEdicao ? "Editar Professor" : "Cadastrar Novo Professor" %></h3>
            <form action="ProfessorServlet" method="POST">
                
                <% if(modoEdicao) { %>
                    <input type="hidden" name="acao" value="alterar">
                <% } %>

                <label>Matrícula:</label>
                <input type="number" name="txtMatricula" value="<%= matEditar != null ? matEditar : "" %>" <%= modoEdicao ? "readonly style='background:#e9ecef;'" : "" %> required>
                
                <label>Nome Completo:</label>
                <input type="text" name="txtNome" value="<%= nomeEditar %>" required>
                
                <label>E-mail:</label>
                <input type="email" name="txtEmail" value="<%= emailEditar %>" required>
                
                <label>Telefone:</label>
                <input type="text" name="txtTelefone" value="<%= teleEditar %>">
                
                <button type="submit" class="btn-salvar">
                    <%= modoEdicao ? "Salvar Alterações" : "Salvar Professor" %>
                </button>
                
                <% if(modoEdicao) { %>
                    <br><br>
                    <a href="index.jsp" style="display:block; text-align:center;">Cancelar Edição</a>
                <% } %>
            </form>
        </div>

        <div style="flex-grow: 1;">
            <h3>Professores Cadastrados (Consulta)</h3>
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
                            out.println("<tr><td colspan='5'>Nenhum professor encontrado.</td></tr>");
                        } else {
                            for(Professor p : professores) {
                %>
                                <tr>
                                    <td><%= p.getMatricula() %></td>
                                    <td><%= p.getNome() %></td>
                                    <td><%= p.getEmail() %></td>
                                    <td><%= p.getTelefone() != null ? p.getTelefone() : "" %></td>
                                    <td>
                                        <a class="btn-editar" href="index.jsp?editMatricula=<%= p.getMatricula() %>">Editar</a>
                                        <a class="btn-excluir" href="ProfessorServlet?acao=excluir&matricula=<%= p.getMatricula() %>" onclick="return confirm('Tem certeza de que deseja excluir este professor?');">Excluir</a>
                                    </td>
                                </tr>
                <%
                            }
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='5'>Erro ao listar: " + e.getMessage() + "</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>