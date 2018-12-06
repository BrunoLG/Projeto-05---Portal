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
    
    public static Aula getAula(long cod) throws Exception {
        String SQL = "SELECT CD_AULA, NM_AULA, DS_CONTEUDO, " +
                        " (SELECT D.NM_DISCIPLINA FROM TB_DISCIPLINA D " +
                            " WHERE A.CD_DISCIPLINA = D.CD_DISCIPLINA) " +
                    " FROM TB_AULA A WHERE CD_AULA = ? ";
        Object parameters[] = {cod};
        
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if (list.isEmpty()){
            return null;
        } else {
            Object row[] = list.get(0);
            Aula a = new Aula(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2], 
                    (String) row[3]);
            return a;
        }
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
    
    public static void adicionarAula (String nome, String conteudo, String disciplina) throws Exception{
        String SQL = "INSERT INTO TB_AULA VALUES (default, ?, ?, " +
                        " (SELECT CD_DISCIPLINA FROM TB_DISCIPLINA " +
                            "WHERE NM_DISCIPLINA = ? ) " +
                      ")";
        Object parameters[] = {nome, conteudo, disciplina};
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
    
    public static void alterarAula(String nome, String conteudo, long cod_disciplina, long cod_aula) throws Exception{
        String SQL = "UPDATE TB_AULA SET NM_AULA = ? , DS_CONTEUDO = ? , CD_DISCIPLINA = ? WHERE CD_AULA = ? ";
        Object parameters[] = {nome, conteudo, cod_disciplina, cod_aula};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void removerAula(long cod) throws Exception{
        String SQL = " DELETE FROM TB_AULA WHERE CD_AULA = ? ";
        Object parameters[] = {cod};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static ArrayList<Aula> listarAulas (long cod)throws Exception{
        String SQL = "select cd_aula, nm_aula, ds_conteudo, nm_disciplina from tb_usuario U join tb_curso C " + 
                "on U.cd_curso = C.cd_curso join tb_disciplina D on C.cd_curso = D.cd_curso join " +
                "tb_aula A on D.cd_disciplina = A.cd_disciplina where cd_usuario = ? ";
        ArrayList<Aula> aulas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
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
}
