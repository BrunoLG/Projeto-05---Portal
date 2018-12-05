package br.com.fatecpg.portal;

public class Teste {
    private long cod;
    private String nome;
    private String disciplina;

    public Teste(long cod, String nome, String disciplina) {
        this.cod = cod;
        this.nome = nome;
        this.disciplina = disciplina;
    }

    public String getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(String disciplina) {
        this.disciplina = disciplina;
    }

    public long getCod() {
        return cod;
    }

    public void setCod(long cod) {
        this.cod = cod;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
}
