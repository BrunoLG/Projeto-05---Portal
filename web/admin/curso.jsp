<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page import="br.com.fatecpg.portal.Curso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    if (request.getParameter("formRemoverCurso") != null) {
        try {
            long cod = Long.parseLong(request.getParameter("cod"));
            Curso.removerCurso(cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }

    if (request.getParameter("formAlterarCurso") != null) {
        long cod = Long.parseLong(request.getParameter("cod"));
        String curso = request.getParameter("curso");
        try {
            Curso.alterarCurso(curso, cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }

    if (request.getParameter("formNovoCurso") != null) {
        String curso = request.getParameter("curso");
        try {
            Curso.adicionarCurso(curso);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="../WEB-INF/jspf/style.jspf" %>
        <title>Cursos - Portal</title>
    </head>
    <body>
        <%@ include file="../WEB-INF/jspf/menu.jspf" %>
        <% if (session.getAttribute("usuario_logado") == null) { %>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% } else {
            Usuario usuario = (Usuario) session.getAttribute("usuario_logado");
            if (!usuario.getPermissao().equals("admin")) { %>
        <h2>Você não tem permissão para acessar este recurso!</h2>
        <% } else {%>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Cursos</h1>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-5 mb-5">
                    <% if (request.getParameter("tableAlterarCurso") != null) {
                Curso curso = Curso.getCurso(Long.parseLong(request.getParameter("cod")));%>

                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Alterar Curso</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Código</label> 
                            <input class="form-control" type="text" name="cod" value="<%= curso.getCod()%>" readonly />
                        </div>
                        <div class="form-group">
                        <label>Curso</label> 
                        <input class="form-control" type="text" name="curso" value="<%= curso.getNome()%>" required />
                        </div>
                        <input class="btn btn-success" type="submit" name="formAlterarCurso" value="Alterar" />
                        <a href="curso.jsp" class="btn btn-danger" role="button">Voltar</a>
                    </form>
                    <% } else { %>
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Cadastrar Curso</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Curso</label>
                            <input class="form-control" type="text" name="curso" required />
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="formNovoCurso" value="Cadastrar" />
                        </div>
                    </form>
                    <% } %>
                </div>
                <div class="col-md-7 mb-5">
                    <table class="table mt-5">
                        <thead class="thead-dark">
                            <tr>
                                <th>Código</th>
                                <th>Nome</th>
                                <th>Comandos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Curso c : Curso.getCursos()) {%>
                            <tr>
                                <td><%= c.getCod()%></td>
                                <td><%= c.getNome()%></td>
                                <td>
                                    <form>
                                        <input type="hidden" name="cod" value="<%= c.getCod()%>" />
                                        <input type="submit" class="btn btn-warning" name="tableAlterarCurso" value="Alterar" />
                                        <input type="submit" class="btn btn-danger" name="formRemoverCurso" value="Remover" />
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <% } %>
                    <% }%>
                </div>
            </div>
        </div>
        <%@ include file="../WEB-INF/jspf/footer.jspf" %>
    </body>
</html>