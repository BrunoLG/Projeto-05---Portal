<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page import="br.com.fatecpg.portal.Aula"%>
<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Perfil</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) session.getAttribute("usuario_logado");
        %>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Bem vindo(a), <%= u.getNome()%></h1>
                <h4 class="text-white text-center font-weight-light"><%= u.getCurso()%></h4>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Aulas</h5>
                    </header>
                    <table class="table mt-3">
                        <thead class="thead-dark">
                            <tr>
                                <th>Aula</th>
                                <th>Disciplina</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <%
                                    for (Aula a : Aula.listarAulas(u.getCod())) {%>
                                <td><%= a.getNome()%></td>
                                <td><%= a.getDisciplina()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Notas</h5>
                    </header>
                    <table class="table mt-3">
                        <thead class="thead-dark">
                            <tr>
                                <th>Disciplina</th>
                                <th>Nota</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <%
                                            for (HistoricoTeste t : HistoricoTeste.listarTestes(u.getCod())) {%>
                                <td><%= t.getCurso() %></td>
                                <td><%= t.getNota()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
