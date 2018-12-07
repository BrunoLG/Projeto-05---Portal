package br.com.fatecpg.portal;

import java.util.ArrayList;

public class Disciplina {
    private long cod;
    private String nome;
    private String curso;

    public Disciplina(long cod, String nome, String curso) {
        this.cod = cod;
        this.nome = nome;
        this.curso = curso;
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

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }
    
    public static ArrayList<Disciplina> getDisciplinas() throws Exception {
        String SQL = "SELECT CD_DISCIPLINA, NM_DISCIPLINA, " +
                        " (SELECT C.NM_CURSO FROM TB_CURSO C " +
                            "WHERE D.CD_CURSO = C.CD_CURSO) " +
                    " FROM TB_DISCIPLINA D ";
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Disciplina d = new Disciplina(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2]);
            disciplinas.add(d);
        }
        return disciplinas;
    }
    
    public static ArrayList<Disciplina> getDisciplinaAluno(long cod) throws Exception {
        String SQL = "select cd_disciplina, nm_disciplina, nm_usuario "
                + "from tb_disciplina D join tb_curso C on D.cd_curso "
                + " = C.cd_curso join tb_usuario U on C.cd_curso "
                + " = U.cd_curso where cd_usuario = ?";
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Disciplina d = new Disciplina(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2]);
            disciplinas.add(d);
        }
        return disciplinas;
    }
    
    public static ArrayList<Disciplina> getDisciplinasCurso(long cod) throws Exception {
        String SQL = "SELECT CD_DISCIPLINA, NM_DISCIPLINA, " +
                        " (SELECT C.NM_CURSO FROM TB_CURSO C " +
                            "WHERE D.CD_CURSO = C.CD_CURSO) " +
                    " FROM TB_DISCIPLINA D WHERE D.CD_CURSO = ?";
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Disciplina d = new Disciplina(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2]);
            disciplinas.add(d);
        }
        return disciplinas;
    }
    public static ArrayList<Disciplina> getDisciplina(long cod) throws Exception {
        String SQL = "SELECT CD_DISCIPLINA, NM_DISCIPLINA, " +
                        " (SELECT C.NM_CURSO FROM TB_CURSO C " +
                            "WHERE D.CD_CURSO = C.CD_CURSO) " +
                    " FROM TB_DISCIPLINA D WHERE D.CD_DISCIPLINA = ?";
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Disciplina d = new Disciplina(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2]);
            disciplinas.add(d);
        }
        return disciplinas;
    }
}
