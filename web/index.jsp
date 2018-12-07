<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Página Inicial - Portal</title>
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <%@page import="br.com.fatecpg.portal.Usuario"%>
        <%@page import="br.com.fatecpg.portal.Disciplina"%>
        <%@page import="br.com.fatecpg.portal.Curso"%>
        <% if (session.getAttribute("usuario_logado") != null) {
                Usuario u = (Usuario) session.getAttribute("usuario_logado");
                if (u.getPermissao().equals("admin")) {%>

        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Disciplinas por curso</h1>
            </div>
        </div>
        <div class="container-fluid mb-5">
            <div class="row mt-5">
                <% for (Curso c : Curso.getCursos()) {
                        if (!c.getNome().equals("Nenhum")) {
                %>
                <div class="col-sm-4">
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4"><%=c.getNome()%></h5>
                    </header>
                    <% for (Disciplina d : Disciplina.getDisciplinasCurso(c.getCod())) {
                    %>

                    <div class="card text-center mt-2">
                        <div class="card-body">
                            <p class="h6"><%= d.getNome()%></p>
                            <form action="aula.jsp">
                                <input type="hidden" value="<%=d.getCod()%>" name="disciplina">
                                <input type="submit" class="btn btn-primary" value="Ir para">
                            </form>
                        </div>
                    </div>
                    <%}%>
                </div>
                <%}%>
                <%}%>
            </div>

            <%} else {
            %>
            <div class="bg-dark py-5">
                <div class="container">
                    <h1 class="text-white text-center">Disciplinas</h1>
                    <h4 class="text-white text-center font-weight-light"><%= u.getCurso()%></h4>
                </div>
            </div>
            <div class="container mb-5">
                <div class="row mt-5">
                    <% for (Disciplina d : Disciplina.getDisciplinaAluno(u.getCod())) {%>
                    <div class="col-sm-6">
                        <div class="card text-center">
                            <div class="card-body">
                                <p class="h6"><%= d.getNome()%></p>
                                <form action="aula.jsp">
                                    <input type="hidden" value="<%=d.getCod()%>" name="disciplina">
                                    <input type="submit" class="btn btn-primary" value="Ir para">
                                </form>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <%}%>
            <% } else {%>
            <div class="bg-dark py-5">
                <div class="container">
                    <h1 class="text-white text-center">Nome da empresa</h1>
                    <h4 class="text-white text-center font-weight-light">Slogam da empresa aqui</h4>
                </div>
            </div>
            <div class="bg-light">
                <div class="container">
                    <header class="py-5">
                        <h2 class="text-center">Características</h2>
                    </header>
                    <div class="bg-light">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card mb-5">
                                    <div class="card-header bg-primary text-center text-white font-weight-bold">Aulas</div>
                                    <div class="card-body">
                                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card mb-5">
                                    <div class="card-header bg-success text-center text-white font-weight-bold">Testes</div>
                                    <div class="card-body">
                                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card mb-5">
                                    <div class="card-header bg-danger text-center text-white font-weight-bold">Certificados</div>
                                    <div class="card-body">
                                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <%}%>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %> 
    </body>
</html>
