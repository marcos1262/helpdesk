<%@page import="model.Historico.acoes" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Descricao" %>
<%@ page import="model.Usuario" %>
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
                <li><a href="<%= application.getContextPath() %>/index.jsp">
                    <i class="fa fa-dashboard"></i> Home
                </a></li>
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
                                c1.setId(Long.parseLong(request.getParameter("id")));
                                List<Chamado> res = new Facade().consultaChamados(c1, 0, 100);
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
                                <input type="hidden" name="prioridade_old" value="<%= c.getPrioridade() %>">
                                <div class="col-md-2">
                                    <select name="prioridade" class="form-control" required
                                            onchange="verificaPrioridade()"
                                            <% if (c.getTecnico() == null || usuario.getId() != c.getTecnico().getId()) { %>
                                            disabled <% } %> >
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

                            <div id="action-modal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Status <strong
                                        class="text-danger">*</strong>
                                </label>
                                <input type="hidden" name="status_old" value="<%= c.getStatus() %>">
                                <div class="col-md-4">
                                    <select name="status" class="form-control" required
                                            <% if (c.getTecnico() == null || usuario.getId() != c.getTecnico().getId()) { %>
                                            disabled
                                            <% } %>>
                                        <%
                                            for (Chamado.statusOpcoes s : Chamado.statusOpcoes.values()) {
                                        %>
                                        <option <%= c.getStatus() == s ? "selected" : ""%>
                                                value="<%= s %>"><%= s.getDescricao() %>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <label class="control-label col-md-1 required">
                                    Data
                                    <strong class="text-danger">*</strong>
                                </label>
                                <div class="col-md-2">
                                    <input name="data" type="text" class="form-control"
                                           value="<%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>"
                                           disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2 required">Solicitante <strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <input name="solicitante" type="text" class="form-control"
                                           value="<%= c.getSolicitante().getNome() %>"
                                           disabled>
                                </div>

                                <label class="control-label col-md-1 required">Técnico<strong
                                        class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                    <input name="tecnico" type="text" class="form-control"
                                           value="<%= c.getTecnico() != null ?
                                           new Facade().consultaUsuarios(c.getTecnico(), 0, 1).get(0).getNome() : ""%>"
                                           disabled/>
                                </div>
                            </div>

                            <%--TODO excluir descrições--%>
                            <div class="form-group col-md-8 col-md-push-2">
                                <b>Descrições / Comentários</b>
                                <table class="table table-hover paginated">
                                    <thead>
                                    <tr>
                                        <th style="width: 10px">#</th>
                                        <th>Descrição</th>
                                        <%--<th style="width: 100px">Opções</th>--%>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (int i = 0; i < c.getDescricoes().size(); i++) {
                                            Descricao d = c.getDescricoes().get(i);
                                    %>
                                    <tr>
                                        <td><%= i + 1 %>
                                        </td>
                                        <td><%= d.getDescricao() %>
                                        </td>

                                        <%--<td>--%>
                                        <%--&lt;%&ndash; TODO alguma opção para descrição &ndash;%&gt;--%>
                                        <%--<form name="formAssumir" method="post" action="" class="inline">--%>
                                        <%--<input type="hidden" name="id" value="<%= c.getId() %>">--%>
                                        <%--<input type="hidden" name="assumirChamado" value="true">--%>
                                        <%--<a style="margin-right: 20px;"--%>
                                        <%--class="text-info" data-toggle="tooltip" title="Assumir chamado"--%>
                                        <%--onclick="document.forms['formAssumir'].submit();">--%>
                                        <%--<i class="fa fa-check-square"></i>--%>
                                        <%--</a>--%>
                                        <%--</form>--%>
                                        <%--</td>--%>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2 required">Adicione à descrição</label>
                                <div class="col-md-4">
                                    <textarea class="form-control" name="adddesc"></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                    <a href="<%= application.getContextPath() %>/index.jsp" class="btn btn-default">
                                        Voltar
                                    </a>
                                    <button type="submit" name="alterarChamado" class="btn btn-success col-md-offset-1">
                                        Salvar
                                    </button>
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

<script>
    function verificaPrioridade() {
        var nova = document.getElementsByName("prioridade")[0].value;
        var antiga = document.getElementsByName("prioridade_old")[0].value;

        if (nova !== antiga) {
            //Constroi título e descrição
            var titulo = "Transferir chamado";

            //Corpo da modal
            $('.modal-content').html(
                '<div class="modal-header">'
                + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
                + '<h4 class="modal-title">' + titulo + '</h4>'
                + '</div>'
                + '<div class="modal-body">'
                + '<div class="form-group">'
                + '<input type="text" name="justificativa" class="form-control" placeholder="Digite uma justificativa"/>'
                + '</div>'
                + '</div>'
                + '<div class="modal-footer">'
                + '<button type="button" class="btn btn-default pull-right" data-dismiss="modal">Continuar</button>'
                + '</div>'
            );
            $('#action-modal').modal('show');
        }
    }
</script>

<%
    if (request.getParameter("assumirChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));
        Chamado c = new Chamado();
        c.setId(id);

        Facade facade = new Facade();
        if (facade.assumeChamado(id, usuario.getId())) {
//                TODO mostrar acima do formulário (sem alert)
            facade.cadastraHistorico(acoes.ASSUMIR_CHAMADO, null, usuario, c, null);
            out.println("<script>" +
                    "alert('Chamado assumido com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        } else {
            out.println("<script>" +
                    "alert('Não foi possível assumir o chamado, por favor, contate um administrador.');" +
                    "</script>");
        }
    }

    if (request.getParameter("cancelarChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));
        String justificativa = request.getParameter("justificativa");
        Chamado c = new Chamado();
        c.setId(id);

        Facade facade = new Facade();
        
        if(usuario.getTipo() != Usuario.tipos.SOLIC && justificativa.equals("")){
            out.println("<script>alert('A justificativa é obrigatória!');</script>");
        } else if (facade.cancelaChamado(id)){
            if(usuario.getTipo() != Usuario.tipos.SOLIC)
                facade.cadastraHistorico(acoes.CANCELAR_CHAMADO, justificativa, usuario, c, null);
            else
                facade.cadastraHistorico(acoes.CANCELAR_CHAMADO, null, usuario, c, null);

            out.println("<script>" +
                    "alert('Chamado cancelado com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        } else {
            out.println("<script>" +
                    "alert('Não foi possível cancelar o chamado, por favor, contate um administrador.');" +
                    "</script>");
        }
    }

    if (request.getParameter("transferirChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));

        Chamado c = new Chamado();
        c.setId(id);

        String justificativa = request.getParameter("justificativa");
        Long idtecnico = Long.parseLong(request.getParameter("novo_tecnico"));
        Facade facade = new Facade();

        if (justificativa.equals("")){
            out.println("<script>alert('A justificativa é obrigatória!');</script>");
        }else if (facade.transfereChamado(id, idtecnico) && facade.cadastraHistorico(acoes.TRANSFERIR_CHAMADO, justificativa, usuario, c, new Usuario(idtecnico)))
//                TODO mostrar acima do formulário (sem alert)
            out.println("<script>" +
                    "alert('Chamado transferido com sucesso!');" +
                    "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
        else
            out.println("<script>alert('Não foi possível transferir o chamado, por favor, contate um administrador.');</script>");
    }

    if (request.getParameter("alterarChamado") != null) {
        Long id = Long.parseLong(request.getParameter("id"));
        String justificativa = request.getParameter("justificativa");

        String status = request.getParameter("status");
        String status_old = request.getParameter("status_old");

        String prioridade = request.getParameter("prioridade");
        String prioridade_old = request.getParameter("prioridade_old");

        Chamado c = new Chamado();
        c.setId(id);
        if (usuario.getTipo() != Usuario.tipos.SOLIC) {
            c.setStatus(status);
            c.setPrioridade(prioridade);
        }

        String desc = request.getParameter("adddesc");
        boolean incrementouDesc = false;
        if (!desc.equals("")) {
            c.addDescricao(new Descricao(desc));
            incrementouDesc = true;
        }

        if (status.equals(""))
            out.println("<script>alert('O campo status é obrigatório!');</script>");
        else if (prioridade.equals(""))
            out.println("<script>alert('O campo prioridade é obrigatório!');</script>");
        else if (!status.equals(status_old) && !incrementouDesc)
            out.println("<script>alert('Para alterar o status do chamado, você precisa adicionar um comentário!');</script>");
        else if (!prioridade.equals(prioridade_old) && justificativa.equals(""))
            out.println("<script>alert('Para alterar a prioridade do chamado, você precisa informar uma justificativa!');</script>");
        else if (new Facade().atualizaChamado(c)) {
//                TODO mostrar acima do formulário (sem alert)
            boolean histAltPrioridade = true,
                    histAltStatus = true;

            if (!prioridade.equals(prioridade_old)
                    && !new Facade().cadastraHistorico(acoes.ALTERAR_PRIORIDADE, justificativa, usuario, c, null))
                histAltPrioridade = false;


            if (!status.equals(status_old)
                    && !new Facade().cadastraHistorico(acoes.ALTERAR_STATUS, null, usuario, c, null))
                histAltStatus = false;

            if (histAltPrioridade && histAltStatus)
                out.println("<script>" +
                        "alert('Chamado alterado com sucesso!');" +
//                    "</script>");
                        "window.location = '" + application.getContextPath() + "/index.jsp';</script>");
            else
                out.println("<script>" +
                        "alert('Não foi possível alterar o chamado, por favor, contate um administrador!');" +
                        "</script>");
        } else
            out.println("<script>" +
                    "alert('Não foi possível alterar o chamado, por favor, contate um administrador.');" +
                    "</script>");
    }
%>

</body>
</html>
