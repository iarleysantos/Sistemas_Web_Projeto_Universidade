package br.com.universidade.model;

public class Disciplina {
    private String codigoDisciplina;
    private String nomeDisciplina;
    private int cargaHoraria;

    // Construtor padrão
    public Disciplina() {
    }

    // Construtor completo
    public Disciplina(String codigoDisciplina, String nomeDisciplina, int cargaHoraria) {
        this.codigoDisciplina = codigoDisciplina;
        this.nomeDisciplina = nomeDisciplina;
        this.cargaHoraria = cargaHoraria;
    }

    // Getters e Setters
    public String getCodigoDisciplina() { return codigoDisciplina; }
    public void setCodigoDisciplina(String codigoDisciplina) { this.codigoDisciplina = codigoDisciplina; }

    public String getNomeDisciplina() { return nomeDisciplina; }
    public void setNomeDisciplina(String nomeDisciplina) { this.nomeDisciplina = nomeDisciplina; }

    public int getCargaHoraria() { return cargaHoraria; }
    public void setCargaHoraria(int cargaHoraria) { this.cargaHoraria = cargaHoraria; }
}