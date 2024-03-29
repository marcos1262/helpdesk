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
                <form name="formAssumir<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="assumirChamado" value="true">
                    <a style="margin-right: 20px;"
                       class="text-info" data-toggle="tooltip" title="Assumir chamado"
                       onclick="document.forms['formAssumir<%= c.getId() %>'].submit();">
                        <i class="fa fa-check-square"></i>
                    </a>
                </form>
                <%--TODO pedir justificativa--%>
                <form name="formCancelar<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <a class="text-info" data-toggle="tooltip" title="Cancelar chamado"
                       onclick="modalCancelar(<%= c.getId() %>);return false;">
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
<div id="action-modal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>

    function modalCancelar(id) {
        //Constroi título e descrição
        var titulo = "Cancelar chamado";

        //Corpo da modal
        $('.modal-content').html('<div class="modal-header">'
            + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
            + '<h4 class="modal-title">' + titulo + '</h4>'
            + '</div>'
            + '<form method="post" action="<%=application.getContextPath()%>/Chamado/visualizar.jsp">'
            + '<div class="modal-body">'
            + '<input type="hidden" name="id" value="' + id + '">'
            + '<input type="hidden" name="cancelarChamado" value="true">'
            + '<div class="form-group">'
            + '<input type="text" name="justificativa" class="form-control" placeholder="Digite uma justificativa"/>'
            + '</div>'
            + '</div>'
            + '<div class="modal-footer">'
            + '<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Voltar</button>'
            + '<button type="submit" class="btn btn-danger pull-right">Cancelar chamado</button>'
            + '</div>'
            + '</form>'
        );
        $('#action-modal').modal('show');
    }
</script>