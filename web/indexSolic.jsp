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

                <% if(c.getTecnico().getId() != 0){ %>
            <td><%= new Facade().consultaUsuario(c.getTecnico().getId()).getNome() %>
            </td>
                <% } else { %>
            <td>
            </td>
                <% } %>
            <td>
                <a style="margin-right: 20px;"
                   href="<%= application.getContextPath() %>/Chamado/visualizar.jsp?id=<%= c.getId() %>"
                   class="text-info" data-toggle="tooltip" title="Mais ações"><i
                        class="fa fa-plus-circle"></i></a>
                <a href="<%= application.getContextPath() %>/Chamado/visualizar.jsp"
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

<!-- SenÃ£o mostra uma frase -->
<% } else { %>

<p>Você ainda não possui chamados cadastrados <a href="<%= application.getContextPath() %>/Chamado/abrir.jsp">Clique aqui</a> para adicionar um.
</p>

<% } %>