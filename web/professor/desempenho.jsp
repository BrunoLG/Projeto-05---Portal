<%@page import="br.com.fatecpg.portal.HistoricoAula"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="br.com.fatecpg.portal.HistoricoTeste"%>
<%@page import="br.com.fatecpg.portal.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h1>Desempenho</h1>
        <% if (session.getAttribute("usuario") == null) { %>
            <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{
            Usuario user = (Usuario) session.getAttribute("usuario");
            if (!user.getPermissao().equals("professor")) { %>
            <h2>Você não tem permissão para acessar este recurso!</h2>
            <%}else{%>
            <h2>Melhores notas!</h2>
            <table border="1">
                <thead>
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
                            <td><%= ht.getNota()%></td>
                            <td><%= ht.getCurso()%></td>
                            <td><%= df.format(ht.getData())%></td>
                        </tr>
                    <%}%>
                </tbody> 
                <%}%>
            </table>
            <%}%>
        <%}%>
    </body>
</html>
