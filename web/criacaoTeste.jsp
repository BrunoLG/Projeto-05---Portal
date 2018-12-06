<%-- 
    Document   : criacaoTeste
    Created on : 06/12/2018, 00:49:08
    Author     : Leona
--%>

<%@page import="br.com.fatecpg.portal.Teste"%>
<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    long d = Long.parseLong(request.getParameter("disciplina"));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Criação de Teste - Portal</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Novo Teste</h2>
            <form>
                Nome do teste:
                <input type="text" name="nomeTeste">
                Disciplina:
                <select name="disciplina">
                    <% for(Disciplina disc: Disciplina.getDisciplinas()) { %>
                    <option><%= disc.getNome() %></option>
                    <%}%>
                </select>
                <input type="submit" name="criarTeste" value="Criar teste">
            </form>
        <h2>Nova Questão</h2>        
            <form>
                Nome do teste:
                <select name="teste">
                    <% for(Teste t: Teste.getTeste(d)) { %>
                    <option><%= t.getNome() %></option>
                    <%}%>
                </select>
                Disciplina:
                <select name="disciplina">
                    <% for(Disciplina disc: Disciplina.getDisciplinas()) { %>
                    <option><%= disc.getNome() %></option>
                    <%}%>
                </select>
                <input type="submit" name="criarTeste" value="Criar teste">
            </form>
        <h2>Nova Alternativa</h2>        
            <form>
                Nome do teste:
                <input type="text" name="nomeTeste">
                Disciplina:
                <select name="disciplina">
                    <% for(Disciplina disc: Disciplina.getDisciplinas()) { %>
                    <option><%= disc.getNome() %></option>
                    <%}%>
                </select>
                <input type="submit" name="criarTeste" value="Criar teste">
            </form>
    </body>
</html>
