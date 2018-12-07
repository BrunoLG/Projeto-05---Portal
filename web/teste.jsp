<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="br.com.fatecpg.portal.Alternativa"%>
<%@page import="br.com.fatecpg.portal.Questao"%>
<%@page import="br.com.fatecpg.portal.Teste"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Teste - Portal</title>
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <%
            DecimalFormat decimalFormat = new DecimalFormat("#.#");
            long d = Long.parseLong(request.getParameter("disciplina"));
            Usuario usuario = (Usuario) session.getAttribute("usuario_logado");
            int contador = 1;
            String erro = null;
            double resultado = 0;
            int qtQuestoes = 0;
            if (request.getParameter("formEnviarTeste") != null) {
                long codTeste = Long.parseLong(request.getParameter("codigoTeste"));
                for (Teste t : Teste.getTeste(d)) {
                    for (Questao q : Questao.getQuestoes(t.getCod())) {
                        String usuarioResultado = request.getParameter(q.getQuestao());
                        if (usuarioResultado.equals(q.getResposta())) {
                            resultado++;
                        }
                        qtQuestoes++;
                    }
                }
                try {
                    HistoricoTeste.adicionarTesteHistorico(resultado, new Date(), codTeste, usuario.getCod());
                } catch (Exception e) {
                    erro = e.getMessage();
                    System.out.println(erro);
                }
        %>
        <%}%>
        <% if (session.getAttribute("usuario_logado") == null) {%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%} else {
                usuario = (Usuario) session.getAttribute("usuario_logado");%>
        <div class="bg-dark py-5">
            <div class="container">
                <% for (Disciplina disciplina : Disciplina.getDisciplina(d)) {%>
                <h1 class="text-white text-center"><%=disciplina.getNome()%></h1>
                <%} %>
            </div>
        </div>
        <div class="container">
            <% if (usuario.getPermissao().equals("admin") || usuario.getPermissao().equals("professor")) {%>
            <h3>Área restrita para alunos</h3>
            <%} else {%>
            <%if (Teste.getTeste(d).isEmpty()) {%>
            <h3>Não existe nenhum teste cadastrado.</h3>
            <%} else {%>
            <form>
                <%for (Teste t : Teste.getTeste(d)) {%>
                <div class="container mb-5">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-5"><%= t.getNome()%></h5>
                    </header>
                    <%for (Questao q : Questao.getQuestoes(t.getCod())) {%>
                    <p class="mt-4 h5">Questão <%= contador++%> - <%= q.getQuestao()%></p>
                    <%for (Alternativa a : Alternativa.getAlternativas(q.getCod())) {%>
                    <div class="form-group">
                        <input type="radio" name="<%= q.getQuestao()%>" value="<%= a.getAlternativa()%>" required> <%= a.getAlternativa()%>
                    </div>
                    <%}%>
                    <%}%>
                    <input type="hidden" name="codigoTeste" value="<%= t.getCod()%>" >
                    <%}%>
                    <div class="text-center">
                        <input type="hidden" name="disciplina" value="<%=d%>">
                        <input class="btn btn-success" type="submit" name="formEnviarTeste" value="Enviar">
                    </div>
            </form>
            <%}%>
            <%}%>
            <%}%>
        </div>
        <div class="text-center mb-5">
            <h2 class="display-3"><%= decimalFormat.format((resultado / qtQuestoes) * 10)%></h2>
            <p class="h4">Nota</p>
        </div>
    </div>
    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>
