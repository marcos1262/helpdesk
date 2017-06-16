<%@ page import="model.Facade" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="pt-br">

<head>
    <title>Sistema Helpdesk - Abrir Chamado</title>

    <jsp:include page="../include/security.jsp"/>
    <% if (session.getAttribute("usuario") == null) {
        response.sendRedirect(application.getContextPath() + "/login.jsp");
        return;
    }%>

    <jsp:useBean id="usuario" class="model.Usuario" scope="session"/>

    <jsp:include page="../importCSS.jsp"/>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="../header.jsp" %>

    <div class="content-wrapper">
        <%--TODO criar própria página--%>
        <section class="content-header">
            <h1>
                Abrir chamado
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
                    <div class="col-md-6 col-xs-12">
                        <form name="chamado" action="" method="post">
                            <label>
                                Título:
                                <input type="text" name="titulo" class="form-control"/>
                            </label><br>
                            <label>
                                Prioridade:
                                <select name="prioridade" class="form-control">
                                    <option value="BAIXA">Baixa</option>
                                    <option selected value="NORMAL">Normal</option>
                                    <option value="ALTA">Alta</option>
                                </select>
                            </label><br>
                            <label>
                                Descrição:
                                <input type="text" name="descricao" class="form-control"/>
                            </label><br>
                            <input type="submit" name="abrirChamado" value="Abrir Chamado" class="btn btn-primary"/>
                        </form>
                    </div>
                </div>
            </section><!-- /.content -->
        </section>
    </div>
</div>

<%@include file="../footer.jsp" %>

<%
    if (request.getParameter("abrirChamado") != null) {
        String titulo = request.getParameter("titulo"),
                prioridade = request.getParameter("prioridade"),
                descricao = request.getParameter("descricao");

        if (titulo.equals("")) {
            out.println("<script>alert('O campo título é obrigatório!');</script>");
        } else if (prioridade.equals("")) {
            out.println("<script>alert('O campo prioridade é obrigatório!');</script>");
        } else if (descricao.equals("")) {
            out.println("<script>alert('O campo descrição é obrigatório!');</script>");
        } else {
            Facade facade = new Facade();
            if (facade.abreChamado(titulo, prioridade, descricao, usuario.getId())) {
//                TODO mostrar acima do formulário (sem alert)
                out.println("<script>alert('Chamado aberto com sucesso!');</script>");
                response.sendRedirect(application.getContextPath() + "/index.jsp");
            } else
                out.println("<script>alert('Não foi possível abrir um chamado, por favor, contate um administrador.');</script>");
        }
    }
%>

</body>
</html>
