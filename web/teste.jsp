<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.com.fatecpg.portal.Alternativa"%>
<%@page import="br.com.fatecpg.portal.Questao"%>
<%@page import="br.com.fatecpg.portal.Teste"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teste - Portal</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%
        long d = Long.parseLong(request.getParameter("disciplina"));
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        int contador = 1;
        String erro = null;

        if(request.getParameter("formEnviarTeste")!=null){
            double resultado = 0;
            long codTeste = Long.parseLong(request.getParameter("codigoTeste"));
            for(Teste t: Teste.getTeste(d)){
                for(Questao q: Questao.getQuestoes(t.getCod())){
                    String usuarioResultado = request.getParameter(q.getQuestao());
                    if(usuarioResultado.equals(q.getResposta())){
                        resultado++;
                    }
                }
            }
            try{
               HistoricoTeste.adicionarTesteHistorico(resultado, new Date(), codTeste, usuario.getCod()); 
            }catch(Exception e){
                erro = e.getMessage();
                System.out.println(erro);
            }
            %>
            <h2>Nota: <%= resultado %></h2>
        <%}%>
        
        <% if (session.getAttribute("usuario") == null){%>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{
            usuario = (Usuario) session.getAttribute("usuario");%>
            <h2>Nome da disciplina</h2>
            <% if (usuario.getPermissao().equals("admin") || usuario.getPermissao().equals("professor")) {
                response.sendRedirect("criacaoTeste.jsp?disciplina=1");
            %>
            <%}else{%>
                <%if(Teste.getTeste(d).isEmpty()){%>
                <h3>Não existe nenhum teste cadastrado.</h3>
                <%}else{%>
                <form>
                    <%for(Teste t: Teste.getTeste(d)){%>
                    <h2><%= t.getNome() %></h2>
                        <%for(Questao q : Questao.getQuestoes(t.getCod())){%>
                        <p>Questão <%= contador++%> - <%= q.getQuestao()%></p>
                            <%for(Alternativa a: Alternativa.getAlternativas(q.getCod())){%>
                            <input type="radio" name="<%= q.getQuestao() %>" value="<%= a.getAlternativa() %>" required> <%= a.getAlternativa()%>
                            <br>
                            <%}%>
                            <br>
                        <%}%>
                        <input type="hidden" name="codigoTeste" value="<%= t.getCod()%>" >
                    <%}%>
                    <input type="submit" name="formEnviarTeste" value="Enviar">
                </form>
                <%}%>
            <%}%>
        <%}%>
    </body>
</html>
