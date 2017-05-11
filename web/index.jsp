<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sistema HelpDesk</title>

    <jsp:include page="include/security.jsp"/>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Kube CSS -->
    <link rel="stylesheet" href="assets/css/kube.css">
</head>
<body>

<h1>Hello World!</h1>

</body>

<%-- Java Code --%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("/login.jsp");
    }
%>

</html>
