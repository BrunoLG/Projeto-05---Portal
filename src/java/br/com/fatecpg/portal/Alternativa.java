package br.com.fatecpg.portal;

import java.util.ArrayList;
import java.util.Collections;

public class Alternativa {
    private long cod;
    private String alternativa;
    private long codQuestao;

    public Alternativa(long cod, String alternativa, long codQuestao) {
        this.cod = cod;
        this.alternativa = alternativa;
        this.codQuestao = codQuestao;
    }
    
    public long getCod() {
        return cod;
    }

    public void setCod(long cod) {
        this.cod = cod;
    }

    public String getAlternativa() {
        return alternativa;
    }

    public void setAlternativa(String alternativa) {
        this.alternativa = alternativa;
    }

    public long getCodQuestao() {
        return codQuestao;
    }

    public void setCodQuestao(long codQuestao) {
        this.codQuestao = codQuestao;
    }
    
    public static ArrayList<Alternativa> getAlternativas(long cod) throws Exception {
        String SQL = "SELECT CD_ALTERNATIVA, NM_ALTERNATIVA, CD_QUESTAO" +
                    " FROM TB_ALTERNATIVA WHERE CD_QUESTAO = ? ";
        ArrayList<Alternativa> alternativas = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Alternativa a = new Alternativa(
                    (long) row[0],
                    (String) row[1], 
                    (long) row[2]);
            alternativas.add(a);
        }
        Collections.shuffle(alternativas);
        return alternativas;
    }
    
    public static void adicionarAlternativa (String alternativa, String questao) throws Exception{
        String SQL = "INSERT INTO TB_ALTERNATIVA VALUES (default, ? " +
                        " (SELECT CD_QUESTAO FROM TB_QUESTAO " +
                            "WHERE NM_QUESTAO = ? ) " +
                      ")";
        Object parameters[] = {alternativa, questao};
        DatabaseConnector.execute(SQL, parameters);
    }
}
