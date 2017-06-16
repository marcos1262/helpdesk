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
                            <!-- Se tem chamados mostra a tabela -->
                            <%
                                Chamado c1 = new Chamado();
                                c1.setSolicitante(usuario);
                                List<Chamado> res = new Facade().consultaChamados(c1, 0, 20);
                                if (res.size() > 0) {
                            %>
                            <div class="table-responsive no-padding">
                                <table class="table table-hover paginated">
                                    <thead>
                                    <tr>
                                        <th style="width: 10px">#</th>
                                        <th>Titulo</th>
                                        <th>Prioridade</th>
                                        <th>Status</th>
                                        <th>Data</th>

                                        <th>Técnico</th>
                                        <th style="width: 100px">#</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (Chamado c : res) {
                                    %>
                                    <tr>
                                        <td><%= c.getId() %>
                                        </td>
                                        <td><%= c.getTitulo() %>
                                        </td>
                                        <td><%= c.getPrioridade().toString() %>
                                        </td>
                                        <td><%= c.getStatus().toString() %>
                                        </td>
                                        <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>
                                        </td>

                                        <td><%= c.getTecnico().getNome() %>
                                        </td>
                                        <td>
                                            <a style="margin-right: 20px;"
                                               href="<%= application.getContextPath() %>/Chamado/visualizar.jsp"
                                               class="text-info" data-toggle="tooltip" title="Mais ações"><i
                                                    class="fa fa-plus-circle"></i></a>
                                            <a href="<%= application.getContextPath() %>/Chamado/cancelar.jsp"
                                               class="text-info" data-toggle="tooltip" title="Cancelar chamado"><i
                                                    class="fa fa-trash-o"></i></a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div><!-- /.box-body -->
                            <div class="clearfix">
                                <ul class="pagination pagination-sm no-margin pull-right"></ul>
                            </div>

                            <!-- Senão mostra uma frase -->
                            <% } else { %>

                            <p>Você ainda não possui chamados cadastrados <a href="<%= application.getContextPath() %>/Chamado/abrir.jsp">Clique aqui</a> para adicionar um.
                            </p>

                            <% } %>
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
