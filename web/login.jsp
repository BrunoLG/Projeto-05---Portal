<%@page import="br.com.fatecpg.portal.Usuario"%>
<% if(session.getAttribute("usuario_logado")!= null){ 
   response.sendRedirect("perfil.jsp");
   Usuario u = (Usuario) session.getAttribute("usuario_logado");
}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Login</title>
    </head>
    <body class="bg-light">
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <div class="container py-5">
            <div class="row">
                <div class="col-md-6">
                    <form class="py-4" method="post">
                        <div class="form-group">
                            <label>Usuário: </label>
                            <input class="form-control" placeholder="Digite um usuário." type="text" name="usuario">
                        </div>
                        <div class="form-group">
                            <label>Senha: </label>
                            <input class="form-control" placeholder="Digite uma senha." type="password" name="senha">
                        </div>
                        <input class="form-control btn-success" type="submit" value="Enviar" name="formLogin">
                    </form>
                    <%
                        String errorMessage = null;
                        if (request.getParameter("formLogin") != null) {
                            String usuario = request.getParameter("usuario");
                            String senha = request.getParameter("senha");
                            Usuario u = Usuario.getUsuario(usuario, senha);

                            if (u == null) {
                                errorMessage = "Usuário e/ou senha inválido(s).";
                    %>
                    <header class="py-3">
                        <h6 class="font-italic text-center" style="color: red;"><%= errorMessage%></h6>
                    </header>
                    <%} else {
                                session.setAttribute("usuario_logado", u);
                                response.sendRedirect("index.jsp");
                            }
                        }
                    %>
                </div>
                <div class="col-md-6">
                    <div class="mt-5 mb-3">
                    <h5 class="text-center">Não tem conta? Cadastre-se!</h5>
                    </div>
                    <div class="text-center">
                        <a class="btn btn-primary font-weight-bold" href="cadastro.jsp" role="button">Cadastrar</a>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
