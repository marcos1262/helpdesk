<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="pt-br">

<head>
    <title>Sistema Helpdesk</title>

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
        <section class="content-header">
            <h1>
                Acompanhar
                <small>Chamados</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="<%= application.getContextPath() %>/index.jsp"><i class="fa fa-dashboard"></i> Home</a>
                </li>
                <li class="active">Acompanhar chamado</li>
            </ol>
        </section>

        <section class="content">

            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <%
                            if (request.getParameter("id") != null && request.getParameter("assumirChamado") == null) {
                                Chamado c1 = new Chamado();
                                c1.setId(Integer.parseInt(request.getParameter("id")));
                                List<Chamado> res = new Facade().consultaChamados(c1, 0, 1);
                                Chamado c = res.get(0);
                        %>
                        <form class="form-horizontal" action="">
                            <input type="hidden" name="id" value="<%= c.getId() %>"/>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Titulo <strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <input name="titulo" type="text" class="form-control" value="<%= c.getTitulo() %>">
                                </div>

                                <label class="control-label col-md-1 required">Prioridade<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="prioridade" type="text" class="form-control"
                                           value="<%= c.getPrioridade() %>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Status <strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <input name="status" type="text" class="form-control" value="<%= c.getStatus() %>">
                                </div>

                                <label class="control-label col-md-1 required">Data<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="data" type="text" class="form-control" value="<%= c.getData() %>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Solicitante <strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <input name="solicitante" type="text" class="form-control"
                                           value="<%= c.getSolicitante().getNome() %>" disabled="true"/>
                                </div>

                                <label class="control-label col-md-1 required">Técnico<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="tecnico" type="text" class="form-control"
                                           value="<%= c.getTecnico() %>"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Justificativa do Status</label>
                                <div class="col-md-4">
                                    <textarea disabled="true" value="Aqui vai ter a justificativa"></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Adicione à descrição</label>
                                <div class="col-md-4">
                                    <textarea value=""></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                    <button type="submit" class="btn btn-success">Salvar</button>
                                    <a href="<%= application.getContextPath() %>/index.jsp" class="btn btn-default">Voltar
                                        para tela inicial</a>
                                </div>
                            </div>
                        </form>
                        <%
                            }
                        %>
                    </div>

                </div>
            </section><!-- /.content -->

        </section>
    </div>
</div>

<%@include file="../footer.jsp" %>

<%
    if (request.getParameter("assumirChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));

        Facade facade = new Facade();
        if (facade.assumeChamado(id, usuario.getId()))
//                TODO mostrar acima do formulário (sem alert)
            out.println("<script>" +
                    "alert('Chamado assumido com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        else
            out.println("<script>alert('Não foi possível assumir o chamado, por favor, contate um administrador.');</script>");
    }
%>

</body>
</html>
