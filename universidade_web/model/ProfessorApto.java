package br.com.universidade.model;

public class ProfessorApto {
    private Professor professor;
    private Disciplina disciplina;

    // Construtor padrão
    public ProfessorApto() {
    }

    // Construtor completo
    public ProfessorApto(Professor professor, Disciplina disciplina) {
        this.professor = professor;
        this.disciplina = disciplina;
    }

    // Getters e Setters
    public Professor getProfessor() { return professor; }
    public void setProfessor(Professor professor) { this.professor = professor; }

    public Disciplina getDisciplina() { return disciplina; }
    public void setDisciplina(Disciplina disciplina) { this.disciplina = disciplina; }
}