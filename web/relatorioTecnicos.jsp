<%@page import="model.Facade"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>

<%
    Usuario u = new Usuario();
    u.setTipo(Usuario.tipos.TECNI);
    
    List<Usuario> res = new Facade().consultaUsuarios(u, 0, 20);
    if (res.size() > 0) {
%>
<div class="table-responsive no-padding">
    <table class="table table-hover paginated">
        <thead>
        <tr>
            <th style="width: 10px">#</th>
            <th>Técnico</th>
            <th>Chamados atentidos</th>
            <th>Em atendimento</th>
            <th>Tempo médio</th>
            <th style="width: 100px">Opções</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Usuario user : res) {
        %>
        <tr>
            <td><%= user.getId() %>
            </td>
            <td><%= user.getNome() %>
            </td>
            <td><%= new Facade().chamadosAtendidos(user) %>
            </td>
            <td><%= new Facade().chamadosEmAtendimento(user) %>
            </td>
            <td>0
            </td>
            <td>
                <!--
                <form style="margin-right: 20px;" name="formVisualizar" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="">
                    <a class="text-info" data-toggle="tooltip" title="Mais ações"
                       onclick="document.forms['formVisualizar'].submit();">
                        <i class="fa fa-plus-circle"></i>
                    </a>
                </form>
                <%--TODO pedir justificativa--%>
                <form name="formCancelar" method="post" action="Chamado/visualizar.jsp" class="inline">
                    <input type="hidden" name="id" value="">
                    <input type="hidden" name="cancelarChamado" value="true">
                    <a class="text-info" data-toggle="tooltip" title="Cancelar chamado"
                       onclick="document.forms['formCancelar'].submit();">
                        <i class="fa fa-trash-o"></i>
                    </a>
                </form> -->
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
        
        <% } %>
