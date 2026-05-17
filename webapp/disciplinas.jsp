<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.universidade.dao.DisciplinaDAO" %>
<%@ page import="br.com.universidade.model.Disciplina" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sistema Universitário - Disciplinas</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    .container { display: flex; gap: 40px; align-items: flex-start; }
    form { background: #f8f9fa; padding: 20px; border-radius: 5px; width: 350px; border: 1px solid #ced4da; }
    input { width: 100%; padding: 8px; margin: 6px 0 12px 0; box-sizing: border-box; }
    .btn-salvar { background: #28a745; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; font-weight: bold; }
    .btn-salvar:hover { background: #218838; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    table, th, td { border: 1px solid #ced4da; padding: 10px; text-align: left; }
    th { background-color: #28a745; color: white; }
    .btn-excluir { color: red; text-decoration: none; font-weight: bold; margin-left: 10px; }
    .btn-editar { color: #007bff; text-decoration: none; font-weight: bold; }
    .nav { margin-bottom: 20px; }
</style>
</head>
<body>

    <div class="nav">
        <a href="index.jsp">Cadastrar Professores</a> | 
        <a href="disciplinas.jsp"><b>Cadastrar Disciplinas</b></a> |
        <a href="aptidao.jsp">Vincular Aptidão</a> |
        <a href="turmas.jsp">Cadastrar Turmas</a> |
        <a href="consulta_aptidao.jsp">Consulta Aptidão</a> |
        <a href="consulta_historico.jsp">Consulta Histórico</a>
    </div>

    <h2>Gerenciamento de Disciplinas</h2>

    <%
        // Lógica para verificar se o utilizador clicou em "Editar" alguma disciplina
        String codEditar = request.getParameter("editCodigo");
        String nomeEditar = "";
        String cargaEditar = "";
        boolean modoEdicao = false;

        if (codEditar != null && !codEditar.isEmpty()) {
            DisciplinaDAO dao = new DisciplinaDAO();
            List<Disciplina> lista = dao.listarTodas();
            for(Disciplina d : lista) {
                if(d.getCodigoDisciplina().equals(codEditar)) {
                    nomeEditar = d.getNomeDisciplina();
                    cargaEditar = String.valueOf(d.getCargaHoraria());
                    modoEdicao = true;
                    break;
                }
            }
        }
    %>

    <div class="container">
        <div>
            <h3><%= modoEdicao ? "Editar Disciplina" : "Cadastrar Nova Disciplina" %></h3>
            <form action="DisciplinaServlet" method="POST">
                
                <% if(modoEdicao) { %>
                    <input type="hidden" name="acao" value="alterar">
                <% } %>

                <label>Código da Disciplina:</label>
                <input type="text" name="txtCodigo" value="<%= codEditar != null ? codEditar : "" %>" <%= modoEdicao ? "readonly style='background:#e9ecef;'" : "" %> required>
                
                <label>Nome da Disciplina:</label>
                <input type="text" name="txtNomeDisciplina" value="<%= nomeEditar %>" required>
                
                <label>Carga Horária (em horas):</label>
                <input type="number" name="txtCargaHoraria" value="<%= cargaEditar %>" required>
                
                <button type="submit" class="btn-salvar">
                    <%= modoEdicao ? "Salvar Alterações" : "Salvar Disciplina" %>
                </button>
                
                <% if(modoEdicao) { %>
                    <br><br>
                    <a href="disciplinas.jsp" style="display:block; text-align:center;">Cancelar Edição</a>
                <% } %>
            </form>
        </div>

        <div style="flex-grow: 1;">
            <h3>Disciplinas Cadastradas (Consulta)</h3>
            <table>
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nome da Disciplina</th>
                        <th>Carga Horária</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        DisciplinaDAO dao = new DisciplinaDAO();
                        List<Disciplina> disciplinas = dao.listarTodas();
                        if(disciplinas.isEmpty()) {
                            out.println("<tr><td colspan='4'>Nenhuma disciplina encontrada.</td></tr>");
                        } else {
                            for(Disciplina d : disciplinas) {
                %>
                                <tr>
                                    <td><%= d.getCodigoDisciplina() %></td>
                                    <td><%= d.getNomeDisciplina() %></td>
                                    <td><%= d.getCargaHoraria() %> horas</td>
                                    <td>
                                        <a class="btn-editar" href="disciplinas.jsp?editCodigo=<%= d.getCodigoDisciplina() %>">Editar</a>
                                        <a class="btn-excluir" href="DisciplinaServlet?acao=excluir&codigo=<%= d.getCodigoDisciplina() %>" onclick="return confirm('Tem certeza de que deseja excluir esta disciplina?');">Excluir</a>
                                    </td>
                                </tr>
                <%
                            }
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='4'>Erro ao listar: " + e.getMessage() + "</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>