<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page import="br.com.fatecpg.portal.Curso"%>
<%@page import="br.com.fatecpg.portal.Permissao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    if (request.getParameter("formRemoverUsuario") != null) {
        try {
            long cod = Long.parseLong(request.getParameter("cod"));
            Usuario.removerUsuario(cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }

    if (request.getParameter("formAlterarUsuario") != null) {
        long cod = Long.parseLong(request.getParameter("cod"));
        String nome = request.getParameter("nome");
        String usuario = request.getParameter("usuario");
        long senha = request.getParameter("senha").hashCode();
        long curso = Long.parseLong(request.getParameter("curso"));
        long permissao = Long.parseLong(request.getParameter("permissao"));
        try {
            Usuario.alterarUsuario(nome, usuario, senha, curso, permissao, cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }

    if (request.getParameter("formNovoUsuario") != null) {
        String nome = request.getParameter("nome");
        String usuario = request.getParameter("usuario");
        long senha = request.getParameter("senha").hashCode();
        long curso = Long.parseLong(request.getParameter("curso"));
        long permissao = Long.parseLong(request.getParameter("permissao"));
        try {
            Usuario.adicionarUsuario(nome, usuario, senha, curso, permissao);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="../WEB-INF/jspf/style.jspf" %>
        <title>Usuários - Portal</title>
    </head>
    <body>
        <%@ include file="../WEB-INF/jspf/menu.jspf" %>
        <% if (session.getAttribute("usuario_logado") == null) { %>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% } else {
            Usuario user = (Usuario) session.getAttribute("usuario_logado");
            if (!user.getPermissao().equals("admin")) { %>
        <h2>Você não tem permissão para acessar este recurso!</h2>
        <% } else { %>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Usuários</h1>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mb-5">
                    <% if (request.getParameter("tableAlterarUsuario") != null) {
                                Usuario usuario = Usuario.getUsuario(Long.parseLong(request.getParameter("cod")));%>
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Alterar Usuário</h5>
                    </header>
                    <form  class="py-4">
                        <div class="form-group">
                            <label>Código</label> 
                            <input class="form-control" type="text" name="cod" value="<%= usuario.getCod()%>" readonly />
                        </div>
                        <div class="form-group">
                            <label>Nome</label>
                            <input class="form-control" type="text" name="nome" value="<%= usuario.getNome()%>" required />
                        </div>
                        <div class="form-group">
                            <label>Permissão</label>
                            <select class="form-control" name="permissao" required >
                                <% for (Permissao p : Permissao.getPermissoes()) {%>
                                <option value="<%= p.getCod()%>"><%= p.getNome()%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Curso</label>
                            <select class="form-control" name="curso" required >
                                <% for (Curso c : Curso.getCursos()) {%>
                                <option value="<%= c.getCod()%>"><%= c.getNome()%></option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Usuário</label> 
                            <input class="form-control" type="text" name="usuario" value="<%= usuario.getUsuario()%>" required />
                        </div>
                        <div class="form-group">
                            <label>Senha</label>
                            <input class="form-control" type="password" name="senha" required />
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" name="formAlterarUsuario" value="Alterar" />
                            <a class="btn btn-danger" href="usuario.jsp" role="button">Voltar</a>
                        </div>

                    </form>
                    <% } else { %>
                    <header class="mt-5 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                        <h5 class="ml-4">Adicionar Usuário</h5>
                    </header>
                    <form class="mt-3">
                        <div class="form-group">
                            <label>Nome</label> 
                            <input class="form-control" type="text" name="nome" required />
                        </div>
                        <div class="form-group">
                            <label>Permissão</label>
                            <select class="form-control" name="permissao" required >
                                <% for (Permissao p : Permissao.getPermissoes()) {%>
                                <option value="<%= p.getCod()%>"><%= p.getNome()%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Curso</label>
                            <select class="form-control" name="curso" required >
                                <% for (Curso c : Curso.getCursos()) {%>
                                <option value="<%= c.getCod()%>"><%= c.getNome()%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Usuário</label> 
                            <input class="form-control" type="text" name="usuario" required />
                        </div>
                        <div class="form-group">
                            <label>Senha</label> 
                            <input class="form-control" type="password" name="senha" required />
                        </div>
                        <div class="text-center">
                            <input class="btn btn-success" type="submit" name="formNovoUsuario" value="Cadastrar" />
                        </div>
                    </form>
                    <% } %>
                </div>
                <div class="col-md-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Código</th>
                                <th>Nome</th>
                                <th>Usuário</th>
                                <th>Curso</th>
                                <th>Permissão</th>
                                <th>Comandos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Usuario u : Usuario.getUsuarios()) {%>
                            <tr>
                                <td><%= u.getCod()%></td>
                                <td><%= u.getNome()%></td>
                                <td><%= u.getUsuario()%></td>
                                <td><%= u.getCurso()%></td>
                                <td><%= u.getPermissao()%></td>
                                <td>
                                    <form>
                                        <input type="hidden" name="cod" value="<%= u.getCod()%>" />
                                        <input type="submit" class="btn btn-warning" name="tableAlterarUsuario" value="Alterar" />
                                        <input type="submit" class="btn btn-danger" name="formRemoverUsuario" value="Remover" />
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
