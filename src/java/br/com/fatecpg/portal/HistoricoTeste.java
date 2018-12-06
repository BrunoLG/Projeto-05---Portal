package br.com.fatecpg.portal;

import java.util.ArrayList;
import java.util.Date;

public class HistoricoTeste {
    private long cod;
    private double nota;
    private Date data;
    private String curso;
    private String teste;

    public HistoricoTeste(long cod, double nota, Date data, String curso, String teste) {
        this.cod = cod;
        this.nota = nota;
        this.data = data;
        this.curso = curso;
        this.teste = teste;
    }
    
    public long getCod() {
        return cod;
    }

    public void setCod(long cod) {
        this.cod = cod;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }
    
    public String getTeste() {
        return teste;
    }

    public void setTeste(String teste) {
        this.teste = teste;
    }
    
    public static ArrayList<HistoricoTeste> getTesteHistorico() throws Exception {
        String SQL = "SELECT CD_HISTORICO, CD_NOTA, DT_TESTE, " +
            "(SELECT C.NM_CURSO FROM TB_USUARIO U " +
            "JOIN TB_CURSO C ON U.CD_CURSO = C.CD_CURSO " +
            "WHERE H.CD_USUARIO = U.CD_USUARIO), " +
            "(SELECT U.NM_USUARIO FROM TB_USUARIO U " +
            "WHERE U.CD_USUARIO = H.CD_USUARIO) " +
            "FROM TB_HISTORICO_TESTE H ORDER BY CD_NOTA DESC";
        ArrayList<HistoricoTeste> historicoTestes = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            HistoricoTeste ht = new HistoricoTeste(
                    (long) row[0],
                    (Double) row[1],
                    (Date) row[2], 
                    (String) row[3],
                    (String) row[4]);
            historicoTestes.add(ht);
        }
        return historicoTestes;
    }
    public static ArrayList<HistoricoTeste> listarTestes (long cod)throws Exception{
        String SQL = "select cd_historico, cd_nota, dt_teste, nm_disciplina, nm_usuario from tb_historico_teste H " +
                "join tb_teste T on H.cd_teste = T.cd_teste join tb_disciplina D "
                + " on T.cd_disciplina = D.cd_disciplina join tb_usuario U on U.cd_usuario = H.cd_usuario where H.cd_usuario = ?";
        ArrayList<HistoricoTeste> testes = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            HistoricoTeste t = new HistoricoTeste(
                    (long) row[0],
                    (double) row[1],
                    (Date) row[2],
                    (String) row[3],
                    (String) row[4]);
            testes.add(t);
        }
        return testes;
    }
}
