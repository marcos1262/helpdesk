<%@ page import="model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sistema HelpDesk</title>

    <%-- Java Code --%>
    <jsp:include page="include/security.jsp"/>
    <%
        Usuario usuario;

        if ((usuario = (Usuario) session.getAttribute("usuario")) != null)
            // TODO voltar para página anterior

            if (usuario.getTipo() == Usuario.tipos.ADMIN)
                response.sendRedirect("adm/index.jsp");
            else
                response.sendRedirect("index.jsp");

        // FIXME quando volta a página, mostra login ou senha incorretos
    %>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="assets/AdminLTE-2.3.11/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/AdminLTE-2.3.11/dist/css/AdminLTE.min.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    
    <style>
        body {
            position: fixed;
            height: 100%;
            width: 100%;
            background-image: url("assets/img/bglogin3.jpg");
            background-attachment: fixed;
            background-repeat: no-repeat;
            background-size: cover;
        }
        
        .color-white{
            color: #fff;
            text-shadow:1px 1px 1px rgba(0,0,0, 0.35)
	}
    </style>

    
</head>
<body>

<div class="login-box">
    <div class="login-logo color-white">
        <b>Help</b>desk
    </div>
    <div class="login-box-body">
        <div class="login-box-msg">
            <h3>Login</h3>
        </div>
        <form method="post" action="" class="form">
            <div class="form-group">
                <input type="text" name="usuario" class="form-control" placeholder="Usuário" required autofocus>
            </div>

            <div class="form-group">
                <input type="password" name="senha" placeholder="Senha" class="form-control" required>
            </div>

            <div class="form-group">
                <input type="reset" class="btn btn-info btn-flat" value="Cancelar">
                <button type="submit" class="btn btn-primary btn-flat">Entrar</button>
            </div>
        </form>
    </div>
</div>

<!-- AdminLTE jQuery / Bootstrap js -->
<script src="assets/AdminLTE-2.3.11/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="assets/AdminLTE-2.3.11/bootstrap/js/bootstrap.min.js"></script>
<script>
    $('#container-login').animation('fadeIn');
</script>

</body>
</html>
