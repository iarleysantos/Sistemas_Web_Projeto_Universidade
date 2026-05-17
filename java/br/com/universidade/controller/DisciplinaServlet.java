package br.com.universidade.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import br.com.universidade.dao.DisciplinaDAO;
import br.com.universidade.model.Disciplina;

@WebServlet("/DisciplinaServlet")
public class DisciplinaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Captura os dados vindos do formulário
            String codigo = request.getParameter("txtCodigo");
            String nome = request.getParameter("txtNomeDisciplina");
            int cargaHoraria = Integer.parseInt(request.getParameter("txtCargaHoraria"));
            
            // Monta o objeto Disciplina
            Disciplina disciplina = new Disciplina(codigo, nome, cargaHoraria);
            DisciplinaDAO dao = new DisciplinaDAO();
            
            // Verifica se veio a flag oculta de alteração
            String acao = request.getParameter("acao");
            
            out.println("<html><body>");
            if ("alterar".equals(acao)) {
                dao.alterar(disciplina);
                out.println("<h2 style='color:green;'>Disciplina alterada com sucesso!</h2>");
            } else {
                dao.cadastrar(disciplina);
                out.println("<h2 style='color:green;'>Disciplina cadastrada com sucesso!</h2>");
            }
            out.println("<a href='disciplinas.jsp'>Voltar para as Disciplinas</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Erro na operação: " + e.getMessage() + "</h2>");
            out.println("<a href='disciplinas.jsp'>Tentar Novamente</a>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cuida da EXCLUSÃO via link GET
        String acao = request.getParameter("acao");
        String codigo = request.getParameter("codigo");
        
        if (acao != null && codigo != null) {
            DisciplinaDAO dao = new DisciplinaDAO();
            try {
                if ("excluir".equals(acao)) {
                    dao.excluir(codigo);
                    // Deleta e já joga o usuário de volta para a tela de disciplinas atualizada
                    response.sendRedirect("disciplinas.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("disciplinas.jsp");
    }
}