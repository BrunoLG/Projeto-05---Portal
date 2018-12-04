<%@page import="br.com.fatecpg.portal.Curso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    if (request.getParameter("formRemoverCurso") != null){
        try{
            long cod = Long.parseLong(request.getParameter("cod"));
            Curso.removerCurso(cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }    
    
    if (request.getParameter("formAlterarCurso") != null){
        long cod = Long.parseLong(request.getParameter("cod"));
        String curso = request.getParameter("curso");
        try {
            Curso.alterarCurso(curso, cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
    }
    
    if (request.getParameter("formNovoCurso") != null){
        String curso = request.getParameter("curso");
        try {
            Curso.adicionarCurso(curso);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
} %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cursos - Portal</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <% if (session.getAttribute("usuario") == null) { %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% } else { 
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (!usuario.getPermissao().equals("admin")) { %>
                <h2>Você não tem permissão para acessar este recurso!</h2>
            <% } else { 
                if (errorMessage != null) { %>
                    <h2 style="color: red"><%= error %></h2>
                <% } %>
            <h1>Cursos</h1>
                <% if (request.getParameter("tableAlterarCurso") != null) {
                    Curso curso = Curso.getCurso(Long.parseLong(request.getParameter("cod"))); %>
                <h2>Alterar Curso</h2>
                <form>
                    Código: <input type="text" name="cod" value="<%= curso.getCod() %>" readonly />
                    Curso: <input type="text" name="curso" value="<%= curso.getNome() %>" required />
                    <input type="submit" name="formAlterarCurso" value="Alterar" />
                    <a href="curso.jsp" role="button">Voltar</a>
                </form>
                <% } else { %>
                <h2>Novo curso</h2>
                <form>
                    Curso: <input type="text" name="curso" required />
                    <input type="submit" name="formNovoCurso" value="Cadastrar" />
                </form>
                <% } %>
            <table border="1">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nome</th>
                        <th>Comandos</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Curso c : Curso.getCursos()) { %>
                        <tr>
                            <td><%= c.getCod() %></td>
                            <td><%= c.getNome() %></td>
                            <td>
                                <form>
                                    <input type="hidden" name="cod" value="<%= c.getCod() %>" />
                                    <input type="submit" name="tableAlterarCurso" value="Alterar" />
                                    <input type="submit" name="formRemoverCurso" value="Remover" />
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        <% } %>
    </body>
</html>