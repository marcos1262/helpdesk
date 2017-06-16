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
                            if (request.getParameter("id") != null
                                    && request.getParameter("assumirChamado") == null
                                    && request.getParameter("cancelarChamado") == null
                                    && request.getParameter("transferirChamado") == null) {
                                Chamado c1 = new Chamado();
                                c1.setId(Integer.parseInt(request.getParameter("id")));
                                List<Chamado> res = new Facade().consultaChamados(c1, 0, 1);
                                Chamado c = res.get(0);
                        %>
                        <form class="form-horizontal" method="post" action="">
                            <input type="hidden" name="id" value="<%= c.getId() %>"/>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Título
                                    <strong class="text-danger">*</strong>
                                </label>
                                <div class="col-md-4">
                                    <input name="titulo" type="text" class="form-control" value="<%= c.getTitulo() %>"
                                           required disabled>
                                </div>

                                <label class="control-label col-md-1 required">Prioridade
                                    <strong class="text-danger">*</strong>
                                </label>
                                <div class="col-md-2">
                                    <select name="prioridade" class="form-control" required
                                            <% if (usuario.getId() != c.getTecnico().getId()) { %> disabled <% } %>>
                                        <option <%= c.getPrioridade() == Chamado.prioridades.BAIXA ? "selected" : ""%>
                                                value="BAIXA">Baixa
                                        </option>
                                        <option <%= c.getPrioridade() == Chamado.prioridades.NORMAL ? "selected" : ""%>
                                                value="NORMAL">Normal
                                        </option>
                                        <option <%= c.getPrioridade() == Chamado.prioridades.ALTA ? "selected" : ""%>
                                                value="ALTA">Alta
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Status <strong
                                        class="text-danger">*</strong>
                                </label>
                                <div class="col-md-4">
                                    <select name="status" class="form-control" required
                                            <% if (usuario.getId() != c.getTecnico().getId()) { %> disabled <% } %>>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.ABERTO ? "selected" : ""%>
                                                value="ABERTO">Aberto
                                        </option>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.ATENDENDO ? "selected" : ""%>
                                                value="ATENDENDO">Atendendo
                                        </option>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.ESPERANDO ? "selected" : ""%>
                                                value="ESPERANDO">Esperando
                                        </option>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.FECHADO_CANCELADO ? "selected" : ""%>
                                                value="FECHADO_CANCELADO">Fechado (Cancelado)
                                        </option>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.FECHADO_FALHA ? "selected" : ""%>
                                                value="FECHADO_FALHA">Fechado (Falha)
                                        </option>
                                        <option <%= c.getStatus() == Chamado.statusOpcoes.FECHADO_SUCESSO ? "selected" : ""%>
                                                value="FECHADO_SUCESSO">Fechado (Sucesso)
                                        </option>
                                    </select>
                                </div>
                                <label class="control-label col-md-1 required">Data<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="data" type="text" class="form-control" value="<%= c.getData() %>"
                                           disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Solicitante <strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <input name="solicitante" type="text" class="form-control"
                                           value="<%= c.getSolicitante().getNome() %>" disabled>
                                </div>

                                <label class="control-label col-md-1 required">Técnico<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="tecnico" type="text" class="form-control"
                                           value="<%= c.getTecnico().getNome() %>" disabled/>
                                </div>
                            </div>

                            <%--TODO mostrar lista de descrições, receber novas descrições, excluir descrições--%>
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Adicione à descrição</label>
                                <div class="col-md-4">
                                    <textarea value=""></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                    <a href="<%= application.getContextPath() %>/index.jsp" class="btn btn-default">Voltar
                                        para tela inicial</a>
                                    <button type="submit" name="alterarChamado" class="btn btn-success">Salvar</button>
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

    if (request.getParameter("cancelarChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));
        String justificativa = request.getParameter("justificativa");
//        TODO gravar justificativa

        Facade facade = new Facade();
        if (facade.cancelaChamado(id))
//                TODO mostrar acima do formulário (sem alert)
            out.println("<script>" +
                    "alert('Chamado cancelado com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        else
            out.println("<script>alert('Não foi possível cancelar o chamado, por favor, contate um administrador.');</script>");
    }

    if (request.getParameter("transferirChamado") != null) {
//        Long id = Long.parseLong(request.getParameter("id"));
//        String justificativa = request.getParameter("justificativa");
//        Long idtecnico = Long.parseLong(request.getParameter("novo_tecnico"));
////        TODO gravar justificativa
//
//        Facade facade = new Facade();
//        if (facade.transfereChamado(id, idtecnico))
////                TODO mostrar acima do formulário (sem alert)
//            out.println("<script>" +
//                    "alert('Chamado assumido com sucesso!');" +
//                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
//        else
//            out.println("<script>alert('Não foi possível assumir o chamado, por favor, contate um administrador.');</script>");
    }

    if (request.getParameter("alterarChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));
        String status = request.getParameter("status");
        String prioridade = request.getParameter("prioridade");

        Chamado c = new Chamado();
        c.setId(id);
        c.setStatus(status);
        c.setPrioridade(prioridade);

        Facade facade = new Facade();
        if (facade.atualizaChamado(c))
//                TODO mostrar acima do formulário (sem alert)
            out.println("<script>" +
                    "alert('Chamado alterado com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        else
            out.println("<script>alert('Não foi possível alterar o chamado, por favor, contate um administrador.');</script>");
    }
%>

</body>
</html>
