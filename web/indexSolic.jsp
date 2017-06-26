<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Facade" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
            <th style="width: 100px">Opções</th>
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
            <td><%= c.getStatus().getDescricao() %>
            </td>
            <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>
            </td>
            <td>
                <% if (c.getTecnico() != null && c.getTecnico().getId() != 0)
                    out.print(new Facade().consultaUsuarios(c.getTecnico(), 0, 1).get(0).getNome());
                else
                    out.println("<i>Ainda não assumido...</i>");%>
            </td>
            <td>
                <form style="margin-right: 20px;" name="formVisualizar<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <a class="text-info" data-toggle="tooltip" title="Mais ações"
                       onclick="document.forms['formVisualizar<%= c.getId() %>'].submit();">
                        <i class="fa fa-plus-circle"></i>
                    </a>
                </form>
                <%--TODO pedir justificativa--%>
                <form name="formCancelar<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="cancelarChamado" value="true">
                    <a class="text-info" data-toggle="tooltip" title="Cancelar chamado"
                       onclick="document.forms['formCancelar<%= c.getId() %>'].submit();">
                        <i class="fa fa-trash-o"></i>
                    </a>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<!-- /.box-body -->
<div class="clearfix">
    <ul class="pagination pagination-sm no-margin pull-right"></ul>
</div>

<!-- Senão mostra uma frase -->
<% } else { %>

<p>Você ainda não possui chamados cadastrados <a href="<%= application.getContextPath() %>/Chamado/abrir.jsp">Clique
    aqui</a> para adicionar um.
</p>

<% } %>