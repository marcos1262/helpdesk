<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sistema HelpDesk</title>

    <%-- Java Code --%>
    <jsp:include page="include/security.jsp"/>
    <%
        Usuario usuario;

        if ((usuario = (Usuario) session.getAttribute("usuario")) == null)
            response.sendRedirect("login.jsp");
        else {
    %>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Kube CSS -->
    <link rel="stylesheet" href="assets/css/kube.css">
</head>
<body>

<h1>
    Bem vindo, <%=usuario.getNome()%>
</h1>

<%
//    new Facade().abreChamado("teste", "ALTA", "I'm with problems", usuario.getId());
%>

</body>
<%
    }
%>
</html>
