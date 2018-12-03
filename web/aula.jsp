<%@page import="br.com.fatecpg.portal.Aula"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String error = null;
    long cod_aula = 0;

    if (request.getParameter("formProxAula") != null){
        cod_aula = Long.parseLong(request.getParameter("cod"));
        try{
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            Aula.adicionarAulaHistorico(cod_aula, usuario.getCod());   
        } catch (Exception e) {
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
        <%@include file="/WEB-INF/jspf/header.jspf" %>
        <header>
            <div>
                <h2>Nome da disciplina</h2>
            </div>
        </header>
        <div>
            <div>
                <div>
                    <header>
                        <h2>Aulas</h2>
                    </header>
                    <% for (Aula a : Aula.getAulas()) { 
                        if (cod_aula == 0){%>
                        <form>
                            <input type="hidden" name="cod" value="<%= a.getCod() %>" />
                            <input type="submit" name="formProxAula" value="<%= a.getNome() %>" />
                        </form>
                        <% } else { %>
                            <form>
                                <input type="hidden" name="cod" value="<%= a.getCod()-1 %>" />
                                <input type="submit" name="formProxAula" value="<%= a.getNome() %>" />
                            </form>
                    <% } } %>
                </div>
                <% for (Aula a : Aula.getAulas()) {
                    if (cod_aula+1 == a.getCod()) { %>
                    <section id="<%= a.getCod() %>" style="display: block;">
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
                                    <input type="submit" name="formProxAula" value="Próxima aula" />
                                </form>
                            </footer>
                        </div>
                    </section>
                <% } } %>
            </div>
        </div>
    </body>
</html>
