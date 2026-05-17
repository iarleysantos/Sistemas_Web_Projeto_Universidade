package br.com.universidade.model;

public class Professor {
    private int matricula;
    private String nome;
    private String email;
    private String telefone;

    // Construtor padrão
    public Professor() {
    }

    // Construtor completo
    public Professor(int matricula, String nome, String email, String telefone) {
        this.matricula = matricula;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
    }

    // Getters e Setters (para o Java conseguir ler e alterar os dados)
    public int getMatricula() { return matricula; }
    public void setMatricula(int matricula) { this.matricula = matricula; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }
}