<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="hidden-print">
    <h4>Montar relatório de chamado</h4>

    <form class="form-horizontal">
        <div class="form-group">
            <div class="col-md-3">
                <select id="parametro" class="form-control" title="Parâmetro">
                    <option value="" selected>Clique para escolher parâmetro...</option>

                    <option value="titulo">Título contém...</option>
                    <option value="prioridade">Prioridade</option>
                    <option value="status">Status</option>
                    <option value="data_inicial">Data inicial</option>
                    <option value="data_final">Data final</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="button" class="btn btn-primary" data-toggle="tooltip" title="Adicionar parâmetro"
                        onclick="adicionaParametro()">
                    <i class="fa fa-plus"></i>
                </button>
            </div>
        </div>
    </form>

    <br>
    <h4>Busca:</h4>

    <form class="form-horizontal" method="post">
        <div id="parametros">
            <div class="form-group" id="data_inicial">
                <label class="control-label col-md-2 required">
                    Data inicial:
                </label>
                <div class="col-md-3">
                    <input name="data_inicial" type="date" class="form-control">
                </div>
                <div class="col-md-1">
                    <button id="btn_remove_data_inicial" class="btn btn-default"
                            data-toggle="tooltip" title="Remover parâmetro"
                            onclick="removerParametro(this,'data_inicial');return false;">
                        <i class="fa fa-remove"></i>
                    </button>
                </div>
            </div>

            <div class="form-group" id="data_final">
                <label class="control-label col-md-2 required">
                    Data final:
                </label>
                <div class="col-md-3">
                    <input name="data_final" type="date" class="form-control">
                </div>
                <div class="col-md-1">
                    <button id="btn_remove_data_final" class="btn btn-default"
                            data-toggle="tooltip" title="Remover parâmetro"
                            onclick="removerParametro(this,'data_final');return false;">
                        <i class="fa fa-remove"></i>
                    </button>
                </div>
            </div>
        </div>
        <input type="submit" class="btn btn-success" name="gerarRelatorio" value="Gerar relatório">
    </form>
</div>
<script>
    var div = document.getElementById("parametros"),
        parametroInput = document.getElementById("parametro");

    var cont = 1;

    function adicionaParametro() {
        var parametro = parametroInput.value;

        switch (parametro) {
            case "titulo":
                div.innerHTML +=
                    '<div class="form-group" id="titulo' + cont + '">' +
                    '   <label class="control-label col-md-2 required">' +
                    '       Título contém:' +
                    '   </label>' +
                    '   <div class="col-md-3">' +
                    '       <input name="titulo" type="text" class="form-control">' +
                    '   </div>' +
                    '   <div class="col-md-1">' +
                    '       <button id="btn_remove' + cont + '" class="btn btn-default" ' +
                    '               data-toggle="tooltip" title="Remover parâmetro"' +
                    '               onclick="removerParametro(this,\'titulo' + cont + '\');return false;">' +
                    '           <i class="fa fa-remove"></i>' +
                    '       </button>' +
                    '   </div>' +
                    '</div>'
                ;
                break;
            case "prioridade":
                div.innerHTML +=
                    '<div class="form-group" id="prioridade' + cont + '">' +
                    '    <label class="control-label col-md-2 required">' +
                    '        Prioridade:' +
                    '    </label>' +
                    '    <div class="col-md-3">' +
                    '        <select name="prioridade" class="form-control">' +
                    <%
                        for (Chamado.prioridades p : Chamado.prioridades.values())
                            out.println("'<option value=\"" + p + "\">" + p.getDescricao() + "</option>' +");
                    %>
                    '        </select>' +
                    '    </div>' +
                    '    <div class="col-md-1">' +
                    '        <button id="btn_remove' + cont + '" class="btn btn-default"' +
                    '                data-toggle="tooltip" title="Remover parâmetro"' +
                    '                onclick="removerParametro(this,\'prioridade' + cont + '\');return false;">' +
                    '            <i class="fa fa-remove"></i>' +
                    '        </button>' +
                    '    </div>' +
                    '</div>'
                ;
                break;
            case "status":
                div.innerHTML +=
                    '<div class="form-group" id="status' + cont + '">' +
                    '    <label class="control-label col-md-2 required">' +
                    '        Status:' +
                    '    </label>' +
                    '    <div class="col-md-3">' +
                    '        <select name="status" class="form-control">' +
                    <%
                        for (Chamado.statusOpcoes s : Chamado.statusOpcoes.values())
                            out.println("'<option value=\"" + s + "\">" + s.getDescricao() + "</option>' +");
                    %>
                    '        </select>' +
                    '    </div>' +
                    '    <div class="col-md-1">' +
                    '        <button id="btn_remove' + cont + '" class="btn btn-default"' +
                    '                data-toggle="tooltip" title="Remover parâmetro"' +
                    '                onclick="removerParametro(this,\'status' + cont + '\');return false;">' +
                    '            <i class="fa fa-remove"></i>' +
                    '        </button>' +
                    '    </div>' +
                    '</div>'
                ;
                break;
            case "data_inicial":
                if (div.querySelector("#data_inicial") === null)
                    div.innerHTML +=
                        '<div class="form-group" id="data_inicial">' +
                        '    <label class="control-label col-md-2 required">' +
                        '        Data inicial:' +
                        '    </label>' +
                        '    <div class="col-md-3">' +
                        '        <input name="data_inicial" type="date" class="form-control">' +
                        '    </div>' +
                        '    <div class="col-md-1">' +
                        '        <button id="btn_remove_data_inicial" class="btn btn-default"' +
                        '                data-toggle="tooltip" title="Remover parâmetro"' +
                        '                onclick="removerParametro(this,\'data_inicial\');return false;">' +
                        '            <i class="fa fa-remove"></i>' +
                        '        </button>' +
                        '    </div>' +
                        '</div>'
                    ;
                break;
            case "data_final":
                if (div.querySelector("#data_final") === null)
                    div.innerHTML +=
                        '<div class="form-group" id="data_final">' +
                        '    <label class="control-label col-md-2 required">' +
                        '        Data final:' +
                        '    </label>' +
                        '    <div class="col-md-3">' +
                        '        <input name="data_final" type="date" class="form-control">' +
                        '    </div>' +
                        '    <div class="col-md-1">' +
                        '        <button id="btn_remove_data_final" class="btn btn-default"' +
                        '                data-toggle="tooltip" title="Remover parâmetro"' +
                        '                onclick="removerParametro(this,\'data_final\');return false;">' +
                        '            <i class="fa fa-remove"></i>' +
                        '        </button>' +
                        '    </div>' +
                        '</div>'
                    ;
                break;
        }

        cont++;
    }

    function removerParametro(btn, id) {
        $('[id=' + btn.id + ']').tooltip('destroy');
        var parametro = document.getElementById(id);
        parametro.parentNode.removeChild(parametro);
    }
</script>

<%
    if (request.getParameter("gerarRelatorio") != null) {
        try {
            String titulo[] = {},
                    prioridade[] = {},
                    status[] = {};
            LocalDate dataInicial = null,
                    dataFinal = null;

            ArrayList<Chamado> chamados = new ArrayList<>();

            if (request.getParameterValues("titulo") != null) {
                titulo = request.getParameterValues("titulo");
            }
            if (request.getParameterValues("prioridade") != null) {
                prioridade = request.getParameterValues("prioridade");
            }
            if (request.getParameterValues("status") != null) {
                status = request.getParameterValues("status");
            }
            if (!request.getParameter("data_inicial").equals("")) {
                String di[] = request.getParameter("data_inicial").split("-");
                dataInicial = LocalDate.of(
                        Integer.parseInt(di[0]),
                        Integer.parseInt(di[1]),
                        Integer.parseInt(di[2])
                );
            }
            if (!request.getParameter("data_final").equals("")) {
                String df[] = request.getParameter("data_final").split("-");
                dataFinal = LocalDate.of(
                        Integer.parseInt(df[0]),
                        Integer.parseInt(df[1]),
                        Integer.parseInt(df[2])
                );
            }

            for (int i = 0; i < Integer.max(titulo.length, Integer.max(prioridade.length, status.length)); i++) {
                Chamado chamado = new Chamado();
                if (titulo.length > i) {
                    chamado.setTitulo(titulo[i]);
                }
                if (prioridade.length > i) {
                    chamado.setPrioridade(prioridade[i]);
                }
                if (status.length > i) {
                    chamado.setStatus(status[i]);
                }
                chamados.add(chamado);
            }

            List<Chamado> res = new Facade().consultaChamados(chamados, 0, 1000, dataInicial, dataFinal);

            if (res != null) {
%>
<br><br>
<h4>Relatório de Chamados</h4>
<b>Parâmetros:</b><br>
<ul>
    <%
        for (String t :
                titulo) {
            out.println("<li>Título contendo: "+t+"</li>");
        }
        for (String p :
                prioridade) {
            out.println("<li>Prioridade: " + p + "</li>");
        }
        for (String s :
                status) {
            out.println("<li>Status: " + s + "</li>");
        }
        if (dataInicial != null) {
            out.println("<li>Data inicial: "+dataInicial+"</li>");
        }
        if (dataFinal != null) {
            out.println("<li>Data final: "+dataFinal+"</li>");
        }
    %>
</ul>
<br>
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
            <th>Técnico</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Chamado c :
                    res) {
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
                <% if (c.getTecnico() != null && c.getTecnico().getId() != 0)
                    out.print(new Facade().consultaUsuarios(c.getTecnico(), 0, 1).get(0).getNome());
                else
                    out.println("<i>Ainda não assumido...</i>");%>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<% } else { %>
<p>Sem resultados...</p>
<% }
} catch (Exception e) {
    e.printStackTrace();
}
}
%>