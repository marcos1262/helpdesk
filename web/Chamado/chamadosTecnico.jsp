<%@page import="model.Usuario"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div>
    <!-- Se tem chamados mostra a tabela -->
    <%
        Chamado c2 = new Chamado();
        c2.setTecnico(new Usuario(usuario.getId()));

        List<Chamado> res2 = new Facade().consultaChamados(c2, 0, 20);
        if (res2.size() > 0) {
    %>
    <div class="table-responsive no-padding">
        <table class="table table-hover paginated">
            <thead>
            <tr>
                <th style="width: 10px">#</th>
                <th>Titulo</th>
                <th>Prioridade</th>
                <th>Descrição</th>
                <th>Data de abertura</th>
                <th style="width: 100px">Opções</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Chamado c : res2) {
            %>
            <tr>
                <td><%= c.getId() %>
                </td>
                <td><%= c.getTitulo() %>
                </td>
                <td><%= c.getPrioridade().toString() %>
                </td>
                <%--TODO consultar descrição--%>
                <td>
                    <% if (c.getDescricoes() != null)
                        out.print("1ª de " + c.getDescricoes().size() + ": " +
                                c.getDescricoes().get(0).getDescricao());
                    else out.print("Sem descrição...");
                    %>
                </td>
                <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>
                </td>

                <td>
                    <a href="<%= application.getContextPath() %>/Chamado/cancelar.jsp"
                       class="text-info" data-toggle="tooltip" title="Cancelar chamado">
                        <i class="fa fa-trash-o"></i>
                    </a>
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

    <p>Você ainda não assumiu chamados.
    </p>

    <% } %>
</div>
