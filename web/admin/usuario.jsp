<%@page import="br.com.fatecpg.portal.Curso"%>
<%@page import="br.com.fatecpg.portal.Permissao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    if (request.getParameter("formRemoverUsuario") != null){
        try{
            long cod = Long.parseLong(request.getParameter("cod"));
            Usuario.removerUsuario(cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
            error = e.getMessage();
        }
    }    
    
    if (request.getParameter("formAlterarUsuario") != null){
        long cod = Long.parseLong(request.getParameter("cod"));
        String nome = request.getParameter("nome");
        String usuario = request.getParameter("usuario");
        long senha = request.getParameter("senha").hashCode();
        long curso =  Long.parseLong(request.getParameter("curso"));
        long permissao =  Long.parseLong(request.getParameter("permissao"));
        try {
            Usuario.alterarUsuario(nome, usuario, senha, curso, permissao, cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
    }
    
    if (request.getParameter("formNovoUsuario") != null){
        String nome = request.getParameter("nome");
        String usuario = request.getParameter("usuario");
        long senha = request.getParameter("senha").hashCode();
        String curso = request.getParameter("curso");
        String permissao = request.getParameter("permissao");
        try {
            Usuario.adicionarUsuario(nome, usuario, senha, curso, permissao);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
} %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários - Portal</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <% if (session.getAttribute("usuario") == null) { %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% } else { 
            Usuario user = (Usuario) session.getAttribute("usuario");
            if (!user.getPermissao().equals("admin")) { %>
                <h2>Você não tem permissão para acessar este recurso!</h2>
            <% } else { 
                if (errorMessage != null) { %>
                    <h2 style="color: red"><%= error %></h2>
                <% } %>
            <h1>Usuários</h1>
                <% if (request.getParameter("tableAlterarUsuario") != null) {
                    Usuario usuario = Usuario.getUsuario(Long.parseLong(request.getParameter("cod"))); %>
                <h2>Alterar Usuário</h2>
                <form>
                    Código: <input type="text" name="cod" value="<%= usuario.getCod() %>" readonly />
                    Nome: <input type="text" name="nome" value="<%= usuario.getNome() %>" required />
                    Permissão: 
                    <select name="permissao" required >
                            <% for (Permissao p : Permissao.getPermissoes()) { %>
                                <option value="<%= p.getCod() %>"><%= p.getNome() %></option>
                            <% } %>
                    </select>
                    Curso: 
                    <select name="curso" required >
                        <% for (Curso c : Curso.getCursos()) { %>
                                <option value="<%= c.getCod() %>"><%= c.getNome() %></option>
                        <% } %>
                    </select>
                    Usuário: <input type="text" name="usuario" value="<%= usuario.getUsuario() %>" required />   
                    Senha: <input type="password" name="senha" required />   
                    <input type="submit" name="formAlterarUsuario" value="Alterar" />
                    <a href="usuario.jsp" role="button">Voltar</a>
                </form>
                <% } else { %>
                <h2>Novo usuário</h2>
                <form>
                    Nome: <input type="text" name="nome" required />
                    Permissão: 
                    <select name="permissao" required >
                            <% for (Permissao p : Permissao.getPermissoes()) { %>
                                <option value="<%= p.getCod() %>"><%= p.getNome() %></option>
                            <% } %>
                    </select>
                    Curso: 
                    <select name="curso" required >
                        <% for (Curso c : Curso.getCursos()) { %>
                                <option value="<%= c.getCod() %>"><%= c.getNome() %></option>
                        <% } %>
                    </select>
                    Usuário: <input type="text" name="usuario" required />   
                    Senha: <input type="password" name="senha" required />   
                    <input type="submit" name="formNovoUsuario" value="Cadastrar" />
                </form>
                <% } %>
            <table border="1">
                <thead>
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
                    <% for (Usuario u : Usuario.getUsuarios()) { %>
                        <tr>
                            <td><%= u.getCod() %></td>
                            <td><%= u.getNome() %></td>
                            <td><%= u.getUsuario() %></td>
                            <td><%= u.getCurso() %></td>
                            <td><%= u.getPermissao() %></td>
                            <td>
                                <form>
                                    <input type="hidden" name="cod" value="<%= u.getCod() %>" />
                                    <input type="submit" name="tableAlterarUsuario" value="Alterar" />
                                    <input type="submit" name="formRemoverUsuario" value="Remover" />
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
