<%-- 
    Document   : criacaoTeste
    Created on : 06/12/2018, 00:49:08
    Author     : Leona
--%>
<%@page import="br.com.fatecpg.portal.Usuario"%>
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

    if (request.getParameter("criarTeste") != null) {
        String nomeTeste = request.getParameter("nomeTeste");
        long disciplina = Long.parseLong(request.getParameter("disciplina"));
        try {
            Teste.adicionarTeste(nomeTeste, disciplina);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
            System.out.println(error);
        }
    }

    if (request.getParameter("criarQuestao") != null) {
        String enunciado = request.getParameter("enunciado");
        String resposta = request.getParameter("resposta");
        String teste = request.getParameter("teste");
        try {
            Questao.adicionarQuestao(enunciado, resposta, teste);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
            System.out.println(error);
        }
    }

    if (request.getParameter("criarAlternativa") != null) {
        String alternativa = request.getParameter("alternativa");
        String questao = request.getParameter("questao");
        try {
            Alternativa.adicionarAlternativa(alternativa, questao);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
            System.out.println(error);
        }
    }

    if (request.getParameter("formFiltroAlternativas") != null) {
        filtroA = Long.parseLong(request.getParameter("filtroTabelaAlternativas"));
    }
    if (request.getParameter("formFiltroQuestoes") != null) {
        filtroQ = Long.parseLong(request.getParameter("filtroTabelaQuestoes"));
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="../WEB-INF/jspf/style.jspf" %>
        <title>Criação de Teste - Portal</title>
    </head>
    <body>
        <%@ include file="../WEB-INF/jspf/menu.jspf" %>
        <% if (session.getAttribute("usuario_logado") == null) { %>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%} else {
            Usuario usuario = (Usuario) session.getAttribute("usuario_logado"); %>
        <% if (usuario.getPermissao().equals("professor")) {%>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Teste</h1>
            </div>
        </div>
        <div class="container mt-5 mb-5">
            <div class="row">
                <div class="col-md-4">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Novo teste</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Novo Teste</label>
                            <input class="form-control" type="text" name="nomeTeste" required>
                        </div>
                        <div class="form-group">
                            <label>Disciplina</label>
                            <select class="form-control" name="disciplina">
                                <% for (Disciplina disc : Disciplina.getDisciplinas()) {%>
                                <option value="<%= disc.getCod()%>"><%= disc.getNome()%></option>
                                <%}%>
                            </select>
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="criarTeste" value="Criar teste" required>
                        </div>
                    </form>
                </div>
                <div class="col-md-4">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Nova questão</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Nome do teste</label>
                            <select class="form-control" name="teste">
                                <% for (Teste t : Teste.getTestes(usuario.getCurso())) {%>
                                <option value="<%= t.getCod()%>"><%= t.getNome()%></option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Enunciado</label>
                            <input class="form-control" type="text" name="enunciado" required>
                        </div>
                        <div class="form-group">
                            <label>Resposta</label>
                            <input class="form-control" type="text" name="resposta" required>
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="criarQuestao" value="Criar Questão">
                        </div>
                    </form>
                </div>
                <div class="col-md-4">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Nova alternativa</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Nome da questão</label>
                            <select class="form-control" name="questao">
                                <% for (Teste t : Teste.getTestes(usuario.getCurso())) { %>
                                <% for (Questao q : Questao.getQuestoes(t.getCod())) {%>
                                <option value="<%= q.getCod()%>"><%= q.getQuestao()%></option>
                                <%}%>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Alternativa</label>
                            <input class="form-control" type="text" name="alternativa" required>
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="criarAlternativa" value="Criar Alternativa" required>
                        </div>
                    </form>
                </div>
            </div>

            <!--*******************TABELAS*********************-->        
            <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                <h5 class="ml-4">Testes</h5>
            </header>
            <table class="table mt-3">
                <thead class="thead-dark">
                <th>Código</th>
                <th>Nome do Teste</th>
                <th>Nome da Disciplina</th>
                </thead>
                <%if (Teste.getTestes(usuario.getCurso()).isEmpty()) {%>
                <tbody>
                <td colspan="4">Esta disciplina não possuí testes registrados.</td>
                </tbody>
                <%} else {%>
                <tbody>
                    <%for (Teste t : Teste.getTestes(usuario.getCurso())) {%>
                    <tr>
                        <td><%= t.getCod()%></td>
                        <td><%= t.getNome()%></td>
                        <td><%= t.getDisciplina()%></td>
                    </tr>
                    <%}%>
                </tbody>
                <%}%>
            </table>
            <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                <h5 class="ml-4">Questões</h5>
            </header>
            <form class="mt-3">
                <div class="row">
                    <div class="col-md-4">
                        <select class="form-control" name="filtroTabelaQuestoes">
                            <% for (Teste t : Teste.getTestes(usuario.getCurso())) {%>
                            <option value="<%= t.getCod()%>"><%= t.getNome()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <input class="btn btn-success" type="submit" name="formFiltroQuestoes" value="Filtrar">
                    </div>
                </div>
            </form>
            <table class="table mt-3">
                <thead class="thead-dark">
                <th>Código</th>
                <th>Enunciado</th>
                <th>Resposta</th>
                <th>Código do Teste</th>
                </thead>
                <%if (Questao.getQuestoes(filtroQ).isEmpty()) {%>
                <tbody>
                <td colspan="4">Este teste não possuí questões registradas.</td>
                </tbody>
                <%} else {%>
                <tbody>
                    <%for (Questao q : Questao.getQuestoes(filtroQ)) {%>
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
            <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                <h5 class="ml-4">Alternativas</h5>
            </header>
            <form class="mt-3">
                <div class="row">
                    <div class="col-md-4">
                        <select class="form-control" name="filtroTabelaAlternativas">
                            <% for (Teste t : Teste.getTestes(usuario.getCurso())) { %>
                            <% for (Questao q : Questao.getQuestoes(t.getCod())) {%>
                            <option value="<%= q.getCod()%>"><%= q.getQuestao()%></option>
                            <%}%>
                            <%}%>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input class="btn btn-success" type="submit" name="formFiltroAlternativas" value="Filtrar">
                    </div>
                </div>
            </form>
            <table class="table mt-3">
                <thead class="thead-dark">
                <th>Código</th>
                <th>Nome da Alternativa</th>
                <th>Código do Questão</th>
                </thead>
                <%if (Alternativa.getAlternativas(filtroA).isEmpty()) {%>
                <tbody>
                <td colspan="4">Esta questão não possuí alternativas registradas.</td>
                </tbody>
                <%} else {%>
                <tbody>
                    <%for (Alternativa a : Alternativa.getAlternativas(filtroA)) {%>
                    <tr>
                        <td><%= a.getCod()%></td>
                        <td><%= a.getAlternativa()%></td>
                        <td><%= a.getCodQuestao()%></td>
                    </tr>
                    <%}%>
                </tbody>
                <%}%>
            </table>
            <%} else {%>
            <h2>Você não tem permissão para acessar esta página</h2>
            <%}%>
            <%}%>
        </div>
        <%@ include file="../WEB-INF/jspf/footer.jspf" %>
    </body>
</html>