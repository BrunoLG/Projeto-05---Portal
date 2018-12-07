<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.com.fatecpg.portal.HistoricoAula"%>
<%@page import="java.text.DateFormat"%>
<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    DecimalFormat decimalFormat = new DecimalFormat("#.#");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="../WEB-INF/jspf/style.jspf" %>
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="../WEB-INF/jspf/menu.jspf" %>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Desempenho</h1>
            </div>
        </div>
        <% if (session.getAttribute("usuario_logado") == null) { %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{
            Usuario user = (Usuario) session.getAttribute("usuario_logado");
            if (!user.getPermissao().equals("professor")) { %>
            <h2>Você não tem permissão para acessar este recurso!</h2>
            <%}else{%>
            <div class="container mb-5 mt-5">
            <header class="mt-5 mb-3 py-2 border-left border-primary bg-light" style="border-width: 5px !important;">
                <h5 class="ml-4">Melhores notas</h5>
            </header>
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Aluno</th>
                        <th>Nota</th>
                        <th>Disciplina</th>
                        <th>Data</th>
                    </tr>
                </thead>
                <%if(HistoricoTeste.getTesteHistorico(user.getCurso()).isEmpty()){%>
                    <tbody>
                        <td colspan="4">O histórico está vázio</td>
                    </tbody>
                <%}else{%>
                <tbody>
                    <%DateFormat df = new SimpleDateFormat("dd/MM/yyyy");%>
                    <%for(HistoricoTeste ht: HistoricoTeste.getTesteHistorico(user.getCurso())){%>
                            <tr>
                                <td><%= ht.getTeste()%></td>
                                <td><%= decimalFormat.format(ht.getNota())%></td>
                                <td><%= ht.getCurso()%></td>
                                <td><%= df.format(ht.getData())%></td>
                            </tr>
                    <%}%>
                </tbody> 
                <%}%>
            </table>
            <%}%>
        <%}%>
            </div>
        <%@ include file="../WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
