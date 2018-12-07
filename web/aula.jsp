<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page import="br.com.fatecpg.portal.Aula"%>
<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    Usuario usuario = (Usuario) session.getAttribute("usuario_logado");
    long dc = Long.parseLong(request.getParameter("disciplina"));

    if (request.getParameter("formRealizarTeste") != null) {
        try {
            for (Aula a : Aula.getAulas(dc)) {
                long cod = a.getCod();
                Aula.adicionarAulaHistorico(cod, usuario.getCod());
            }
        } catch (Exception e) {
            error = e.getMessage();
        }
        response.sendRedirect("teste.jsp?disciplina=" + dc);
    }

    if (request.getParameter("formNovaAula") != null) {
        String nome = request.getParameter("nome");
        String conteudo = request.getParameter("conteudo");
        long disciplina = Long.parseLong(request.getParameter("disciplina"));
        try {
            Aula.adicionarAula(nome, conteudo, disciplina);

        } catch (Exception e) {
            error = e.getMessage();
        }
        response.sendRedirect("aula.jsp?disciplina=" + dc);
    }

    if (request.getParameter("formAlterarAula") != null) {
        long cod = Long.parseLong(request.getParameter("cod"));
        String nome = request.getParameter("nome");
        String conteudo = request.getParameter("conteudo");
        long disciplina = Long.parseLong(request.getParameter("disciplina"));
        try {
            Aula.alterarAula(nome, conteudo, disciplina, cod);
        } catch (Exception e) {
            error = e.getMessage();
        }
        response.sendRedirect("aula.jsp?disciplina=" + dc);
    }

    if (request.getParameter("formRemoverAula") != null) {
        long cod = Long.parseLong(request.getParameter("cod"));
        try {
            Aula.removerAula(cod);
        } catch (Exception e) {
            error = e.getMessage();
        }
        response.sendRedirect("aula.jsp?disciplina=" + dc);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Aula - Portal</title>
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>

        <% if (session.getAttribute("usuario_logado") == null) {
                response.sendRedirect("login.jsp");
            } else {
                usuario = (Usuario) session.getAttribute("usuario_logado");%>
        <% if (usuario.getPermissao().equals("admin") || usuario.getPermissao().equals("professor")) {%>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Aulas</h1>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-5 mt-5">
                    <%if (request.getParameter("tableAlterarAula") != null) {
                            Aula aula = Aula.getAula(Long.parseLong(request.getParameter("cod")));%>
                    <form>
                        <div class="form-group">
                            <label>Código</label>
                            <input class="form-control" type="text" name="cod" value="<%= aula.getCod()%>" readonly /> 
                        </div>
                        <div class="form-group">
                            <label>Nome</label> 
                            <input class="form-control" type="text" name="nome" value="<%= aula.getNome()%>" required />
                        </div>
                        <div class="form-group">
                            <label>Contéudo</label>
                            <input class="form-control" type="text" name="conteudo" value="<%= aula.getConteudo()%>" required />   
                        </div>
                        <div class="form-group">
                            <label>Disciplina</label>
                            <select class="form-control" name="disciplina" required >
                                <% for (Disciplina d : Disciplina.getDisciplinas()) {%>
                                <option value="<%= d.getCod()%>"><%= d.getNome()%></option>
                                <% }%>
                            </select>
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="formAlterarAula" value="Alterar" />
                            <input type="hidden" name="disciplina" value="<%=dc%>" />
                            <a class="btn btn-danger" href="aula.jsp?disciplina=<%=dc%>" role="button">Voltar</a>
                        </div>
                    </form>
                    <% } else {%>

                    <form>
                        <div class="form-group">
                            <label>Nome</label>
                            <input class="form-control" type="text" name="nome" required />
                        </div>
                        <div class="form-group">
                            <label>Contéudo</label>
                            <input class="form-control" type="text" name="conteudo" required /> 
                        </div>
                        <div class="text-center">
                            <input type="hidden" name="disciplina" value="<%=dc%>" />   
                            <input class="btn btn-success" type="submit" name="formNovaAula" value="Cadastrar" />
                        </div>
                    </form>
                    <% } %>
                </div>
                <div class="col-md-7 mt-5">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>Aula</th>
                                <th>Conteúdo</th>
                                <th>Comandos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Aula a : Aula.getAulas()) {%>
                            <tr>
                                <td><%= a.getCod()%></td>
                                <td><%= a.getNome()%></td>
                                <td><%= a.getConteudo()%></td>
                                <td>
                                    <form>
                                        <input type="hidden" name="cod" value="<%= a.getCod()%>" />
                                        <input type="hidden" name="disciplina" value="<%= dc%>" />
                                        <input class="btn btn-warning" type="submit" name="tableAlterarAula" value="Alterar" />
                                        <input class="btn btn-danger" type="submit" name="formRemoverAula" value="Remover" />
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <% } else {%>
        <div class="bg-dark py-5">
            <div class="container">
                <% for (Disciplina d : Disciplina.getDisciplina(dc)) {%>
                <h1 class="text-white text-center"><%=d.getNome()%></h1>
                <%} %>
            </div>
        </div>
        <div class="container">
            <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                <h5 class="ml-4">Aulas</h5>
            </header>
            <div class="accordion mt-3" id="accordionExample">
                <% for (Aula a : Aula.getAulas(dc)) {%>

                <div class="card">
                    <div class="card-header" id="heading<%=a.getCod()%>">
                        <h5 class="mb-0">
                            <button class="btn btn-link text-dark font-weight-bold" style="text-decoration: none;" type="button" data-toggle="collapse" data-target="#collapse<%=a.getCod()%>" aria-expanded="true" aria-controls="collapse<%=a.getCod()%>">
                                <%=a.getNome()%>
                            </button>
                        </h5>
                    </div>

                    <div id="collapse<%=a.getCod()%>" class="collapse show" aria-labelledby="heading<%=a.getCod()%>" data-parent="#accordionExample">
                        <div class="card-body">
                            <%=a.getConteudo()%>
                        </div>
                    </div>
                </div>
                <% }%>
                <form class="text-center">
                    <input type="hidden" name="disciplina" value="<%= dc%>" />
                    <input type="submit" class="btn btn-primary mt-3" name="formRealizarTeste" value="Realizar Teste" />
                </form>
                <% } %>
            </div>
        </div>
        <% }%>
    </body>
</html>
