package br.com.fatecpg.portal;

import java.util.ArrayList;
import java.util.Collections;

public class Questao {
    private long cod;
    private String questao;
    private String resposta;
    private long codTeste;

    public Questao(long cod, String questao, String resposta, long codTeste) {
        this.cod = cod;
        this.questao = questao;
        this.resposta = resposta;
        this.codTeste = codTeste;
    }
    
    public long getCod() {
        return cod;
    }

    public void setCod(long cod) {
        this.cod = cod;
    }

    public String getQuestao() {
        return questao;
    }

    public void setQuestao(String questao) {
        this.questao = questao;
    }

    public String getResposta() {
        return resposta;
    }

    public void setResposta(String resposta) {
        this.resposta = resposta;
    }

    public long getCodTeste() {
        return codTeste;
    }

    public void setCodTeste(long codTeste) {
        this.codTeste = codTeste;
    }
    
    public static ArrayList<Questao> getQuestoes(long cod) throws Exception {
        String SQL = "SELECT CD_QUESTAO, DS_QUESTAO, NM_RESPOSTA, CD_TESTE" +
                    " FROM TB_QUESTAO WHERE CD_TESTE = ? ";
        ArrayList<Questao> questoes = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{cod});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Questao q = new Questao(
                    (long) row[0],
                    (String) row[1],
                    (String) row[2],
                    (long) row[3]);
            questoes.add(q);
        }
        Collections.shuffle(questoes);
        return questoes;
    }
    
    public static void adicionarQuestao (String enunciado, String resposta, String teste) throws Exception{
        String SQL = "INSERT INTO TB_QUESTAO VALUES (default, ?, ? " +
                        " (SELECT CD_TESTE FROM TB_TESTE " +
                            "WHERE NM_TESTE = ? ) " +
                      ")";
        Object parameters[] = {enunciado, resposta, teste};
        DatabaseConnector.execute(SQL, parameters);
    }
}
