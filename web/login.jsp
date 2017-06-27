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

            response.sendRedirect("index.jsp");

        // FIXME quando volta a página, mostra login ou senha incorretos
    %>

    <jsp:include page="importCSS.jsp"/>

    <style>
        body {
            position: fixed;
            height: 100%;
            width: 100%;
            background: url("assets/img/bglogin.jpg") no-repeat fixed;
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

<jsp:include page="footer.jsp"/>

<script>
    $('#container-login').animation('fadeIn');
</script>

</body>
</html>
