package br.com.universidade.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import br.com.universidade.dao.ProfessorDAO;
import br.com.universidade.model.Professor;

@WebServlet("/ProfessorServlet")
public class ProfessorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Captura os dados da tela
            int matricula = Integer.parseInt(request.getParameter("txtMatricula"));
            String nome = request.getParameter("txtNome");
            String email = request.getParameter("txtEmail");
            String telefone = request.getParameter("txtTelefone");
            
            // Cria o objeto professor
            Professor professor = new Professor(matricula, nome, email, telefone);
            ProfessorDAO dao = new ProfessorDAO();
            
            // Verifica se veio uma flag oculta dizendo que é para ALTERAR
            String acao = request.getParameter("acao");
            
            out.println("<html><body>");
            if ("alterar".equals(acao)) {
                dao.alterar(professor);
                out.println("<h2 style='color:green;'>Professor alterado com sucesso!</h2>");
            } else {
                dao.cadastrar(professor);
                out.println("<h2 style='color:green;'>Professor cadastrado com sucesso!</h2>");
            }
            out.println("<a href='index.jsp'>Voltar para o Cadastro</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Erro na operação: " + e.getMessage() + "</h2>");
            out.println("<a href='index.jsp'>Tentar Novamente</a>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // O método doGet agora vai cuidar da EXCLUSÃO e da seleção para EDITAR
        String acao = request.getParameter("acao");
        String matStr = request.getParameter("matricula");
        
        if (acao != null && matStr != null) {
            int matricula = Integer.parseInt(matStr);
            ProfessorDAO dao = new ProfessorDAO();
            
            try {
                if ("excluir".equals(acao)) {
                    dao.excluir(matricula);
                    // Depois de excluir, manda o usuário de volta para a index atualizada
                    response.sendRedirect("index.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("index.jsp");
    }
}