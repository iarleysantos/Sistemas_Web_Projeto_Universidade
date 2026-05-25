package br.com.universidade.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import br.com.universidade.dao.TurmaDAO;
import br.com.universidade.model.Disciplina;
import br.com.universidade.model.Professor;
import br.com.universidade.model.Turma;

@WebServlet("/TurmaServlet")
public class TurmaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String idTurma = request.getParameter("txtIdTurma");
            String codigoDisciplina = request.getParameter("selDisciplina");
            int matricula = Integer.parseInt(request.getParameter("selProfessor"));
            String semestre = request.getParameter("txtSemestre");
            String horario = request.getParameter("txtHorario"); 
            
            // CORRIGIDO: Agora pega dinamicamente o valor que você digita no formulário!
            int numAlunos = Integer.parseInt(request.getParameter("txtNumAlunos"));
            
            Disciplina disc = new Disciplina();
            disc.setCodigoDisciplina(codigoDisciplina);
            
            Professor prof = new Professor();
            prof.setMatricula(matricula);
            
            // Passa todos os parâmetros corrigidos para o construtor
            Turma turma = new Turma(idTurma, disc, prof, semestre, numAlunos, horario);
            
            TurmaDAO dao = new TurmaDAO();
            dao.cadastrarTurma(turma);
            
            out.println("<html><body>");
            out.println("<h2 style='color:green;'>Turma cadastrada com sucesso com todos os dados!</h2>");
            out.println("<a href='turmas.jsp'>Voltar</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h2 style='color:red;'>Erro ao cadastrar turma: " + e.getMessage() + "</h2>");
            out.println("<a href='turmas.jsp'>Tentar Novamente</a>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("turmas.jsp");
    }
}