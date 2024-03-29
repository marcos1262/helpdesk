<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="pt-br">

<head>
    <title>Sistema Helpdesk - Chamados</title>

    <jsp:include page="include/security.jsp"/>
    <% if (session.getAttribute("usuario") == null) {
            response.sendRedirect(application.getContextPath() + "/login.jsp");
            return;
    }%>

    <jsp:useBean id="usuario" class="model.Usuario" scope="session"/>

    <jsp:include page="importCSS.jsp"/>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="header.jsp" %>

    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                Meus Chamados
                <%--<small>Chamados</small>--%>
            </h1>
            <ol class="breadcrumb">
                <li><a href="<%=application.getContextPath()%>/index.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
            </ol>
        </section>

        <section class="content">

            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div>
                            <%@include file="indexSolic.jsp" %>
                        </div>
                    </div>

                </div>
            </section><!-- /.content -->
        </section>
    </div>
</div>

<%@include file="footer.jsp" %>

</body>
</html>
