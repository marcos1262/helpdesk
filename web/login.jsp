<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sistema HelpDesk</title>

    <jsp:include page="include/security.jsp"/>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Kube CSS -->
    <link rel="stylesheet" href="assets/css/kube.css">

    <link rel="stylesheet" href="assets/css/master.scss">
</head>
<body>

<div class="row align-center align-middle h100" id="container-login">
    <div class="col">
        <h2>Login</h2>

        <form method="post" action="" class="form">
            <div class="form-item">
                <label>Usuário<br>
                    <input type="text" name="usuario" required>
                </label>
            </div>

            <div class="form-item">
                <label>Senha<br>
                    <input type="password" name="senha" required>
                </label>
            </div>

            <div class="form-item row gutters">
                <input type="reset" class="button secondary outline col col-6" value="Cancelar">
                <button class="button primary-color-dark col col-6">Entrar</button>
            </div>
        </form>
    </div>
</div>

    <!-- Kube JS + jQuery are used for some functionality, but are not required for the basic setup -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="assets/js/kube.js"></script>
    <script>
        $('#container-login').animation('fadeIn');
    </script>
</body>

<%-- Java Code --%>
<%
    if (session.getAttribute("usuario") != null) {
        // TODO voltar para página anterior
        response.sendRedirect("/index.jsp");
        // FIXME quando volta a página, mostra login ou senha incorretos
    }
%>

</html>
