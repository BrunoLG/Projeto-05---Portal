<%@page import="br.com.fatecpg.portal.Curso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
  <% if(request.getParameter("cadastrar")!= null){
      try {
          String nome = request.getParameter("nome");
          String usuario = request.getParameter("usuario");
          long senha = request.getParameter("senha").hashCode();
          long curso = Long.parseLong(request.getParameter("curso"));
          long permissao = 3;
          Usuario.adicionarUsuario(nome, usuario, senha, curso, permissao);
          response.sendRedirect("index.jsp");
      }
      catch (Exception e){
          System.out.println(e.getMessage());
      }
  }%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Cadastro</title>
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Cadastro</h1>
            </div>
        </div>
        <div class="container mb-5 mt-5">
            <form>
                <div class="form-group">
                <label>Nome</label>
                <input class="form-control" type="text" name="nome">
                </div>
                <div class="form-group">
                <label>Usuário</label>
                <input class="form-control" type="text" name="usuario">
                </div>
                <div class="form-group">
                    <label>Curso</label>
                    <select name="curso" required >
                        <% for (Curso c : Curso.getCursos()) { %>
                                <option value="<%= c.getCod() %>"><%= c.getNome() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                <label>Senha</label>
                <input class="form-control" type="password" name="senha">
                </div>
                <div class="text-center">
                <input class="btn btn-success" type="submit" name="cadastrar" value="Cadastrar">
                </div>
            </form>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
