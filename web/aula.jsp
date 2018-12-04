<%@page import="br.com.fatecpg.portal.Disciplina"%>
<%@page import="br.com.fatecpg.portal.Aula"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    long cod_aula = 0;

    if (request.getParameter("formProxAula") != null){
        try{
            cod_aula = Long.parseLong(request.getParameter("cod"));
            Aula.adicionarAulaHistorico(cod_aula, usuario.getCod()); 
        } catch (Exception e) {
            error = e.getMessage();
        }

        if (request.getParameter("formProxAula").equals("Realizar Teste")){
            response.sendRedirect("teste.jsp");
        }
    }
    
    if (request.getParameter("formAula") != null){
        cod_aula = Long.parseLong(request.getParameter("cod"));
    }
    
    if (request.getParameter("formNovaAula") != null){
        String nome = request.getParameter("nome");
        String conteudo = request.getParameter("conteudo");
        String disciplina = (String) session.getAttribute("disciplina");
        //long disciplina = (Long) session.getAttribute("disciplina");
        try {
            Aula.adicionarAula(nome, conteudo, disciplina);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
    }
    
    if (request.getParameter("formAlterarAula") != null){
        long cod = Long.parseLong(request.getParameter("cod"));
        String nome = request.getParameter("nome");
        String conteudo = request.getParameter("conteudo");
        long disciplina = Long.parseLong(request.getParameter("disciplina"));
        try {
            Aula.alterarAula(nome, conteudo, disciplina, cod);
            response.sendRedirect(request.getRequestURI());
        } catch (Exception e){
            error = e.getMessage();
        }
    }
    
    if (request.getParameter("formRemoverAula") != null){
            long cod = Long.parseLong(request.getParameter("cod"));
            try {
                Aula.removerAula(cod);
                response.sendRedirect(request.getRequestURI());
            } catch (Exception e){
                error = e.getMessage();
            }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aula - Portal</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <% if (session.getAttribute("usuario") == null) { %>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <% } else { 
            usuario = (Usuario) session.getAttribute("usuario"); %>
            <h2>Nome da disciplina</h2>
            <% if (usuario.getPermissao().equals("admin") || usuario.getPermissao().equals("professor")) { 
                if (request.getParameter("tableAlterarAula") != null) {
                    Aula aula = Aula.getAula(Long.parseLong(request.getParameter("cod"))); %>
                    <h2>Alterar Aula</h2>
                    <form>
                        Código: <input type="text" name="cod" value="<%= aula.getCod() %>" readonly /> 
                        Nome: <input type="text" name="nome" value="<%= aula.getNome() %>" required />
                        Contéudo: <input type="text" name="conteudo" value="<%= aula.getConteudo() %>" required />   
                        Disciplina:
                        <select name="disciplina" required >
                            <% for (Disciplina d : Disciplina.getDisciplinas()) { %>
                                <option value="<%= d.getCod() %>"><%= d.getNome() %></option>
                            <% } %>
                        </select>
                        <input type="submit" name="formAlterarAula" value="Alterar" />
                        <a href="aula.jsp" role="button">Voltar</a>
                    </form>
                <% } else { %>
                    <h2>Nova Aula</h2>
                    <form>
                        Nome: <input type="text" name="nome" required />
                        Contéudo: <input type="text" name="conteudo" required />   
                        <input type="hidden" name="disciplina" value="<%= session.getAttribute("disciplina") %>" />   
                        <input type="submit" name="formNovaAula" value="Cadastrar" />
                    </form>
                <% } %>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Aula</th>
                        <th>Conteúdo</th>
                        <th>Comandos</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Aula a : Aula.getAulas()) { %>
                        <tr>
                            <td><%= a.getCod() %></td>
                            <td><%= a.getNome() %></td>
                            <td><%= a.getConteudo() %></td>
                            <td>
                                <form>
                                    <input type="hidden" name="cod" value="<%= a.getCod() %>" />
                                    <input type="submit" name="tableAlterarAula" value="Alterar" />
                                    <input type="submit" name="formRemoverAula" value="Remover" />
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else {
                if (errorMessage != null) { %>
                <h2 style="color: red"><%= error %></h2>
                <% } %>
                <div>
                    <header>
                        <h2>Aulas</h2>
                    </header>
                    <% for (Aula a : Aula.getAulas()) { %>
                    <form method="post">
                        <input type="hidden" name="cod" value="<%= a.getCod()-1 %>" />
                        <input type="submit" name="formAula" value="<%= a.getNome() %>" />
                    </form>
                    <% } %>
                </div>
                <% for (Aula a : Aula.getAulas()) {
                    if (cod_aula+1 == a.getCod()) { %>
                    <section>
                        <header>
                            <h3><%= a.getNome() %></h3>
                        </header>
                        <div>                                  
                            <div>
                                <p><%= a.getConteudo() %></p>
                            </div>
                            <footer>
                                <form>
                                    <input type="hidden" name="cod" value="<%= a.getCod() %>" />
                                    <% if (Aula.getAulas().size() == a.getCod()) { %>
                                    <input type="submit" name="formProxAula" value="Realizar Teste" />
                                    <% } else {%>
                                    <input type="submit" name="formProxAula" value="Próxima aula" />
                                    <% } %>
                                </form>
                            </footer>
                        </div>
                    </section>
                    <% } %>
            <% } %>
        <% } } %>
    </body>
</html>
