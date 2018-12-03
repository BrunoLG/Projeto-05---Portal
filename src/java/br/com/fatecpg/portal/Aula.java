package br.com.fatecpg.portal;

import java.util.ArrayList;

public class Aula {
    private long cod;
    private String nome;
    private String conteudo;
    private String disciplina;

    public Aula(long cod, String nome, String conteudo, String disciplina) {
        this.cod = cod;
        this.nome = nome;
        this.conteudo = conteudo;
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

    public String getConteudo() {
        return conteudo;
    }

    public void setConteudo(String conteudo) {
        this.conteudo = conteudo;
    }

    public String getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(String disciplina) {
        this.disciplina = disciplina;
    }
    
    public static ArrayList<Aula> getAulas() throws Exception {
        String SQL = "SELECT CD_AULA, NM_AULA, DS_CONTEUDO, " +
                        " (SELECT D.NM_DISCIPLINA FROM TB_DISCIPLINA D " +
                            " WHERE A.CD_DISCIPLINA = D.CD_DISCIPLINA) " +
                    " FROM TB_AULA A ";
        ArrayList<Aula> aulas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Aula a = new Aula(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2], 
                    (String) row[3]);
            aulas.add(a);
        }
        return aulas;
    }
    
    public static void adicionarAula (String nome, String login, long senha, String curso, String permissao) throws Exception{
        String SQL = "INSERT INTO TB_USUARIO VALUES (default, ?, ?, ?, " +
                        " (SELECT CD_CURSO FROM TB_CURSO " +
                            "WHERE NM_CURSO = ? ), " +
                        " (SELECT CD_PERMISSAO FROM TB_PERMISSAO " +
                            " WHERE NM_PERMISSAO = ? ) " +
                      ")";
        Object parameters[] = {nome, login, senha, curso, permissao};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void adicionarAulaHistorico (long cod_aula, long cod_usuario) throws Exception{
        String SQL = "SELECT * FROM TB_HISTORICO_AULA WHERE CD_AULA = ? AND CD_USUARIO = ? ";
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod_aula, cod_usuario});
        if (list.isEmpty()){
            SQL = "INSERT INTO TB_HISTORICO_AULA VALUES (default, ? , ? )";
            Object parameters[] = {cod_aula, cod_usuario};
            DatabaseConnector.execute(SQL, parameters);
        }  
    }
    
    public static void removerUsuario(long id) throws Exception{
        String SQL = " DELETE FROM TB_USUARIO WHERE CD_USUARIO = ? ";
        Object parameters[] = {id};
        DatabaseConnector.execute(SQL, parameters);
    }
}
