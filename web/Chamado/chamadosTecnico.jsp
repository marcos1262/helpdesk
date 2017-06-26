<%@page import="model.Usuario" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
            <th>Solicitante</th>
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
                <form name="formVisualizar<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp"
                      class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="visualizarChamado" value="true">
                    <a style="margin-right: 20px;"
                       class="text-info" data-toggle="tooltip" title="Visualizar chamado"
                       onclick="document.forms['formVisualizar<%= c.getId() %>'].submit();">
                        <i class="fa fa-edit"></i>
                    </a>
                </form>
                <%--TODO pedir justificativa--%>
                <form name="formTransferir<%= c.getId() %>" method="post" action="Chamado/visualizar.jsp"
                      class="inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="hidden" name="transferirChamado" value="true">
                    <a class="text-info" data-toggle="tooltip" title="Transferir chamado"
                       onclick="modalTransferir(<%= c.getId() %>);return false;">
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

<div id="action-modal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>

    function modalTransferir(id) {
        //Constroi título e descrição
        titulo = "Transferir chamado";

        //Corpo da modal
        $('.modal-content').html('<div class="modal-header">'
            + '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
            + '<h4 class="modal-title">' + titulo + '</h4>'
            + '</div>'
            + '<form method="post" action="<%=application.getContextPath()%>/Chamado/visualizar.jsp">'
            + '<div class="modal-body">'
            + '<input type="hidden" name="id" value="' + id + '">'
            + '<input type="hidden" name="transferirChamado" value="true">'
            + '<div class="form-group">'
            + '<select name="novo_tecnico" class="form-control">'
            + '<option selected value="">Selecione um técnico...</option>'
            <%
                Usuario u = new Usuario();
                u.setTipo(Usuario.tipos.TECNI);

                List<Usuario> tecnicos = new Facade().consultaUsuarios(u, 0, 20);

                for(Usuario t : tecnicos){
                    if(t.getId() != usuario.getId()){
            %>
            + '<option value="<%= t.getId() %>"><%= t.getNome() %></option>'
            <%
                    }
                }
            %>
            + '</div>'
            + '<div class="form-group">'
            + '<input type="text" name="justificativa" class="form-control" placeholder="Digite uma justificativa"/>'
            + '</div>'
            + '</div>'
            + '<div class="modal-footer">'
            + '<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancelar</button>'
            + '<button type="submit" class="btn btn-success pull-right">Transferir</button>'
            + '</div>'
            + '</form>'
        );
        $('#action-modal').modal('show');
    }
</script>