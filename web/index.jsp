<%@ page import="model.Usuario.tipos"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
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
        <%--TODO criar própria página--%>
        <section class="content-header">
            <h1>
                Meus chamados
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
                            <c:if test="${usuario.tipo=='SOLIC'}">
                                <%@include file="indexSolic.jsp" %>
                            </c:if>
                            <c:if test="${usuario.tipo=='TECNI'}">
                                <%@include file="indexSolic.jsp" %>
                            </c:if>
                            <c:if test="${usuario.tipo=='ADMIN'}">
                                <%@include file="indexSolic.jsp" %>
                            </c:if>
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
