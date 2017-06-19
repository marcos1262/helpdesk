<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Se tem chamados mostra a tabela -->
<%
    Chamado c1 = new Chamado();
    c1.setTecnico(new Usuario(0));
    c1.setStatus(Chamado.statusOpcoes.ABERTO.toString());

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
            <th>Descrição</th>
            <th>Data de abertura</th>
            <th>Solicitante</th>
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
            <td>
                <% if (c.getDescricoes() != null) {
                    if (c.getDescricoes().size() > 1)
                        out.print("1ª de " + c.getDescricoes().size() + ": ");
                    out.print(c.getDescricoes().get(0).getDescricao());
                } else out.print("Sem descrição...");
                %>
            </td>
            <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>
            </td>
            <td><%= c.getSolicitante().getNome() %>
            </td>

            <td>
                <form name="formAssumir" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="assumirChamado" value="true">
                    <a style="margin-right: 20px;"
                       class="text-info" data-toggle="tooltip" title="Assumir chamado"
                       onclick="document.forms['formAssumir'].submit();">
                        <i class="fa fa-check-square"></i>
                    </a>
                </form>
                <%--TODO pedir justificativa--%>
                <form name="formCancelar" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="cancelarChamado" value="true">
                    <a class="text-info" data-toggle="tooltip" title="Cancelar chamado"
                       onclick="document.forms['formCancelar'].submit();">
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

<p>Não há chamados para serem atendidos.
</p>

<% } %>
