<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div>
    <!-- Se tem chamados mostra a tabela -->
    <%
        Chamado c2 = new Chamado();
        c2.setTecnico(usuario);
//        TODO não mostrar os fechados

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
                <td><%= c.getId() %></td>
                <td><%= c.getTitulo() %></td>
                <td><%= c.getPrioridade().toString() %></td>

                <td>
                    <% if (c.getDescricoes() != null) {
                        if (c.getDescricoes().size() > 1)
                            out.print("1ª de " + c.getDescricoes().size() + ": ");
                        out.print(c.getDescricoes().get(0).getDescricao());
                    } else out.print("Sem descrição...");
                    %>
                </td>
                <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %></td>

                <td>
                    <form name="formVisualizar" method="post" action="Chamado/visualizar.jsp" class="inline">
                        <input type="hidden" name="id" value="<%= c.getId() %>">
                        <input type="hidden" name="visualizarChamado" value="true">
                        <a style="margin-right: 20px;"
                           class="text-info" data-toggle="tooltip" title="Visualizar chamado"
                           onclick="document.forms['formVisualizar'].submit();">
                            <i class="fa fa-check-square"></i>
                        </a>
                    </form>
                    <%--TODO pedir justificativa--%>
                    <form name="formTransferir" method="post" action="Chamado/visualizar.jsp" class="inline">
                        <input type="hidden" name="id" value="<%= c.getId() %>">
                        <input type="hidden" name="transferirChamado" value="true">
                        <a class="text-info" data-toggle="tooltip" title="Transferir chamado"
                           onclick="document.forms['formTransferir'].submit();">
                            <i class="fa fa-forward"></i>
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

    <p>Você ainda não assumiu chamados.
    </p>

<% } %>