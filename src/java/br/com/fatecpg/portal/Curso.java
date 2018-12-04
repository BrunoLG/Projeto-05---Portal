package br.com.fatecpg.portal;

import java.util.ArrayList;

public class Curso {
    private long cod;
    private String nome;

    public Curso(long cod, String nome) {
        this.cod = cod;
        this.nome = nome;
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
    
    public static ArrayList<Curso> getCursos() throws Exception {
        String SQL = "SELECT CD_CURSO, NM_CURSO FROM TB_CURSO ";
        ArrayList<Curso> cursos = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Curso c = new Curso(
                    (long) row[0],
                    (String) row[1]);
            cursos.add(c);
        }
        return cursos;
    }
    
    public static Curso getCurso(long cod) throws Exception {
        String SQL = "SELECT CD_CURSO, NM_CURSO FROM TB_CURSO WHERE CD_CURSO = ? ";
        Object parameters[] = {cod};
        
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if (list.isEmpty()){
            return null;
        } else {
            Object row[] = list.get(0);
            Curso c = new Curso(
                    (long) row[0],
                    (String) row[1]);
            return c;
        }
    }
    
    public static void adicionarCurso(String curso) throws Exception{
        String SQL = "INSERT INTO TB_CURSO VALUES (default, ? )";
        Object parameters[] = {curso};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void alterarCurso(String curso, long cod) throws Exception{
        String SQL = "UPDATE TB_CURSO SET NM_CURSO = ? WHERE CD_CURSO = ? ";
        Object parameters[] = {curso, cod};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void removerCurso(long id) throws Exception{
        String SQL = "DELETE FROM TB_CURSO WHERE CD_CURSO = ? ";
        Object parameters[] = {id};
        DatabaseConnector.execute(SQL, parameters);
    }
}
