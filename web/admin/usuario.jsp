<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    if (request.getParameter("formRemoverUsuario") != null){
        try{
            long id = Long.parseLong(request.getParameter("cod"));
            System.out.println(id);
            Usuario.removerUsuario(id);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e) {
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
        <h1>Usuários</h1>
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
            <fieldset>
                <legend>Novo usuário</legend>
                <form>
                    Nome: <input type="text" name="nome" required />
                    Permissão: 
                    <select name="permissao" required >
                        <option value="admin">Administrador</option>
                        <option value="professor">Professor</option>
                        <option value="aluno">Aluno</option>
                    </select>
                    Curso: 
                    <select name="curso" required >
                        <option value="null">Nenhum</option>
                        <option value="Análise e Desenvolvimento de Sistemas">Análise e Desenvolvimento de Sistemas</option>
                        <option value="Comércio Exterior">Comércio Exterior</option>
                        <option value="Processos Químicos">Processos Químicos</option>
                    </select>
                    Usuário: <input type="text" name="usuario" required />   
                    Senha: <input type="password" name="senha" required />   
                    <input type="submit" name="formNovoUsuario" value="Cadastrar" />
                </form>
            </fieldset>
            <br>
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
                                    <input type="submit" name="formAlterarUsuario" value="Alterar" />
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
