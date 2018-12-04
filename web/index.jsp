<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="WEB-INF/jspf/style.jspf" %>
        <title>Página Inicial - Portal</title>
    </head>
    <body class="bg-light">
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <div class="bg-dark py-5">
            <div class="container">
                <h1 class="text-white text-center">Nome da empresa.</h1>
                <h4 class="text-white text-center font-weight-light">Slogam da empresa aqui.</h4>
            </div>
        </div>
        <div class="bg-light">
            <div class="container">
                <header class="py-5">
                    <h2 class="text-center">Características</h2>
                </header>
                <div class="bg-light">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card mb-5">
                                <div class="card-header bg-primary text-center text-white font-weight-bold">Aulas</div>
                                <div class="card-body">
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-5">
                                <div class="card-header bg-success text-center text-white font-weight-bold">Testes</div>
                                <div class="card-body">
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-5">
                                <div class="card-header bg-danger text-center text-white font-weight-bold">Certificados</div>
                                <div class="card-body">
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       <%@ include file="WEB-INF/jspf/footer.jspf" %> 
    </body>
</html>
