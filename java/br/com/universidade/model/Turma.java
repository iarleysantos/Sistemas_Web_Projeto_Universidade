package br.com.universidade.model;

public class Turma {
    private String idTurma;
    private Disciplina disciplina;
    private Professor professor;
    private String semestre;
    private int numAlunos; // Nova coluna mapeada
    private String horario;   // Nova coluna mapeada

    // Construtor padrão
    public Turma() {
    }

    // Construtor completo com todos os dados
    public Turma(String idTurma, Disciplina disciplina, Professor professor, String semestre, int numAlunos, String horario) {
        this.idTurma = idTurma;
        this.disciplina = disciplina;
        this.professor = professor;
        this.semestre = semestre;
        this.numAlunos = numAlunos;
        this.horario = horario;
    }

    // Getters e Setters
    public String getIdTurma() { return idTurma; }
    public void setIdTurma(String idTurma) { this.idTurma = idTurma; }

    public Disciplina getDisciplina() { return disciplina; }
    public void setDisciplina(Disciplina disciplina) { this.disciplina = disciplina; }

    public Professor getProfessor() { return professor; }
    public void setProfessor(Professor professor) { this.professor = professor; }

    public String getSemestre() { return semestre; }
    public void setSemestre(String semestre) { this.semestre = semestre; }

    public int getNumAlunos() { return numAlunos; }
    public void setNumAlunos(int numAlunos) { this.numAlunos = numAlunos; }

    public String getHorario() { return horario; }
    public void setHorario(String horario) { this.horario = horario; }
}