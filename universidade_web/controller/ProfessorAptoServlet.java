package br.com.universidade.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import br.com.universidade.dao.ProfessorAptoDAO;
import br.com.universidade.model.Disciplina;
import br.com.universidade.model.Professor;
import br.com.universidade.model.ProfessorApto;

@WebServlet("/ProfessorAptoServlet")
public class ProfessorAptoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Recupere a matrícula e o código selecionados nos drop-downs da tela
            int matricula = Integer.parseInt(request.getParameter("selProfessor"));
            String codigoDisciplina = request.getParameter("selDisciplina");
            
            // Cria os objetos complementares
            Professor prof = new Professor();
            prof.setMatricula(matricula);
            
            Disciplina disc = new Disciplina();
            disc.setCodigoDisciplina(codigoDisciplina);
            
            // Junta tudo no objeto de relacionamento
            ProfessorApto aptidao = new ProfessorApto(prof, disc);
            
            // Manda salvar no banco
            ProfessorAptoDAO dao = new ProfessorAptoDAO();
            dao.cadastrarAptidao(aptidao);
            
            out.println("<html><body>");
            out.println("<h2 style='color:green;'>Aptidão do Professor vinculada com sucesso!</h2>");
            out.println("<a href='aptidao.jsp'>Voltar</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Erro ao vincular aptidão: " + e.getMessage() + "</h2>");
            out.println("<a href='aptidao.jsp'>Tentar Novamente</a>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("aptidao.jsp");
    }
}
