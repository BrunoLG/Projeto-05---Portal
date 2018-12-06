<%-- 
    Document   : criacaoTeste
    Created on : 06/12/2018, 00:49:08
    Author     : Leona
--%>

<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page import="br.com.fatecpg.portal.Alternativa"%>
<%@page import="br.com.fatecpg.portal.Questao"%>
<%@page import="br.com.fatecpg.portal.Teste"%>
<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    long filtroQ = 1; 
    long filtroA = 1;
    
    if(request.getParameter("criarTeste")!=null){
        String nomeTeste = request.getParameter("nomeTeste");
        long disciplina = Long.parseLong(request.getParameter("disciplina"));
        try{
            Teste.adicionarTeste(nomeTeste, disciplina);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
            System.out.println(error);
        }
    }
    
    if(request.getParameter("criarQuestao")!=null){
        String enunciado = request.getParameter("enunciado");
        String resposta = request.getParameter("resposta");
        String teste = request.getParameter("teste");
        try{
            Questao.adicionarQuestao(enunciado, resposta, teste);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
            System.out.println(error);
        }
    }
    
    if(request.getParameter("criarAlternativa")!=null){
        String alternativa = request.getParameter("alternativa");
        String questao = request.getParameter("questao");
        try{
            Alternativa.adicionarAlternativa(alternativa, questao);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
            System.out.println(error);
        }
    }
    
    if(request.getParameter("formFiltroAlternativas")!=null){
       filtroA = Long.parseLong(request.getParameter("filtroTabelaAlternativas"));
    }
    if(request.getParameter("formFiltroQuestoes")!=null){
        filtroQ = Long.parseLong(request.getParameter("filtroTabelaQuestoes"));
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Criação de Teste - Portal</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <% if (session.getAttribute("usuario") == null) { %>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{ 
            Usuario usuario = (Usuario) session.getAttribute("usuario"); %>
            <% if (usuario.getPermissao().equals("professor")) {%>
            <h2>Novo Teste</h2>
                <form>
                    Nome do teste:
                    <input type="text" name="nomeTeste" required>
                    Disciplina:
                    <select name="disciplina">
                        <% for(Disciplina disc: Disciplina.getDisciplinas()) { %>
                        <option value="<%= disc.getCod() %>"><%= disc.getNome() %></option>
                        <%}%>
                    </select>
                    <input type="submit" name="criarTeste" value="Criar teste" required>
                </form>
            <h2>Nova Questão</h2>        
                <form>
                    Nome do teste:
                    <select name="teste">
                        <% for(Teste t: Teste.getTestes(usuario.getCurso())) { %>
                        <option value="<%= t.getCod() %>"><%= t.getNome() %></option>
                        <%}%>
                    </select>
                    Enunciado:
                    <input type="text" name="enunciado" required>
                    Resposta:
                    <input type="text" name="resposta" required>
                    <input type="submit" name="criarQuestao" value="Criar Questão">
                </form>
            <h2>Nova Alternativa</h2>
                <form>
                    Nome da questão:
                    <select name="questao">
                        <% for(Teste t: Teste.getTestes(usuario.getCurso())){ %>
                            <% for(Questao q: Questao.getQuestoes(t.getCod())) {%>
                                <option value="<%= q.getCod()%>"><%= q.getQuestao()%></option>
                            <%}%>
                        <%}%>
                    </select>
                    Alternativa:
                    <input type="text" name="alternativa" required>
                    <input type="submit" name="criarAlternativa" value="Criar Alternativa" required>
                </form>
             
            <!--*******************TABELAS*********************-->        
            <h2>Testes</h2>
                <table border="1">
                    <thead>
                        <th>Código</th>
                        <th>Nome do Teste</th>
                        <th>Nome da Disciplina</th>
                    </thead>
                    <%if(Teste.getTestes(usuario.getCurso()).isEmpty()){%>
                    <tbody>
                        <td colspan="4">Esta disciplina não possuí testes registrados.</td>
                    </tbody>
                    <%}else{%>
                    <tbody>
                        <%for(Teste t: Teste.getTestes(usuario.getCurso())){%>
                        <tr>
                            <td><%= t.getCod() %></td>
                            <td><%= t.getNome()%></td>
                            <td><%= t.getDisciplina()%></td>
                        </tr>
                        <%}%>
                    </tbody>
                    <%}%>
                </table>
            <h2>Questões</h2>
            <form>
                <select name="filtroTabelaQuestoes">
                    <% for(Teste t: Teste.getTestes(usuario.getCurso())) {%>
                    <option value="<%= t.getCod() %>"><%= t.getNome() %></option>
                    <%}%>
                </select>
                <input type="submit" name="formFiltroQuestoes" value="Filtrar">
            </form>
                <table border="1">
                    <thead>
                        <th>Código</th>
                        <th>Enunciado</th>
                        <th>Resposta</th>
                        <th>Código do Teste</th>
                    </thead>
                    <%if(Questao.getQuestoes(filtroQ).isEmpty()){%>
                    <tbody>
                        <td colspan="4">Este teste não possuí questões registradas.</td>
                    </tbody>
                    <%}else{%>
                    <tbody>
                        <%for(Questao q: Questao.getQuestoes(filtroQ)){%>
                        <tr>
                            <td><%= q.getCod()%></td>
                            <td><%= q.getQuestao()%></td>
                            <td><%= q.getResposta()%></td>
                            <td><%= q.getCodTeste()%></td>
                        </tr>
                        <%}%>
                    </tbody>
                    <%}%>
                </table>
            <h2>Alternativas</h2>
            <form>
                <select name="filtroTabelaAlternativas">
                    <% for(Teste t: Teste.getTestes(usuario.getCurso())){ %>
                        <% for(Questao q: Questao.getQuestoes(t.getCod())) {%>
                        <option value="<%= q.getCod()%>"><%= q.getQuestao()%></option>
                        <%}%>
                    <%}%>
                </select>
                <input type="submit" name="formFiltroAlternativas" value="Filtrar">
            </form>
                <table border="1">
                    <thead>
                        <th>Código</th>
                        <th>Nome da Alternativa</th>
                        <th>Código do Questão</th>
                    </thead>
                    <%if(Alternativa.getAlternativas(filtroA).isEmpty()){%>
                    <tbody>
                        <td colspan="4">Esta questão não possuí alternativas registradas.</td>
                    </tbody>
                    <%}else{%>
                    <tbody>
                        <%for(Alternativa a: Alternativa.getAlternativas(filtroA)){%>
                        <tr>
                            <td><%= a.getCod()%></td>
                            <td><%= a.getAlternativa()%></td>
                            <td><%= a.getCodQuestao()%></td>
                        </tr>
                        <%}%>
                    </tbody>
                    <%}%>
                </table>
            <%}else{%>
            <h2>Você não tem permissão para acessar esta página</h2>
            <%}%>
        <%}%>
    </body>
</html>
