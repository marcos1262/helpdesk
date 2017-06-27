<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<form id="parametros" class="form-horizontal" method="post">
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

    <div class="form-group" id="prioridade1">
        <label class="control-label col-md-2 required">
            Prioridade:
        </label>
        <div class="col-md-3">
            <select name="prioridade1" class="form-control">
                <%
                    for (Chamado.prioridades p : Chamado.prioridades.values())
                        out.println("<option value='" + p + "'>" + p.getDescricao() + "</option>");
                %>
            </select>
        </div>
        <div class="col-md-1">
            <button id="btn_remove1" class="btn btn-default"
                    data-toggle="tooltip" title="Remover parâmetro"
                    onclick="removerParametro(this,'prioridade1');return false;">
                <i class="fa fa-remove"></i>
            </button>
        </div>
    </div>

    <div class="form-group" id="status1">
        <label class="control-label col-md-2 required">
            Status:
        </label>
        <div class="col-md-3">
            <select name="status1" class="form-control">
                <%
                    for (Chamado.statusOpcoes s : Chamado.statusOpcoes.values())
                        out.println("<option value='" + s + "'>" + s.getDescricao() + "</option>");
                %>
            </select>
        </div>
        <div class="col-md-1">
            <button id="btn_remove2" class="btn btn-default"
                    data-toggle="tooltip" title="Remover parâmetro"
                    onclick="removerParametro(this,'status1');return false;">
                <i class="fa fa-remove"></i>
            </button>
        </div>
    </div>
</form>

<script>
    var form = document.getElementById("parametros"),
        parametroInput = document.getElementById("parametro");

    var cont = 1;

    function adicionaParametro() {
        var parametro = parametroInput.value;

        switch (parametro) {
            case "titulo":
                form.innerHTML +=
                    '<div class="form-group" id="titulo' + cont + '">' +
                    '   <label class="control-label col-md-2 required">' +
                    '       Título contém:' +
                    '   </label>' +
                    '   <div class="col-md-3">' +
                    '       <input name="titulo[]" type="text" class="form-control">' +
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
                form.innerHTML +=
                    '<div class="form-group" id="prioridade' + cont + '">' +
                    '    <label class="control-label col-md-2 required">' +
                    '        Prioridade:' +
                    '    </label>' +
                    '    <div class="col-md-3">' +
                    '        <select name="prioridade' + cont + '" class="form-control">' +
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
                form.innerHTML +=
                    '<div class="form-group" id="status' + cont + '">' +
                    '    <label class="control-label col-md-2 required">' +
                    '        Status:' +
                    '    </label>' +
                    '    <div class="col-md-3">' +
                    '        <select name="status' + cont + '" class="form-control">' +
                    <%
                        for (Chamado.statusOpcoes s : Chamado.statusOpcoes.values())
                            out.println("'<option value=\"" + s + "\">" + s.getDescricao() + "</option>'");
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
                if (form.querySelector("#data_inicial") === null)
                    form.innerHTML +=
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
                if (form.querySelector("#data_final") === null)
                    form.innerHTML +=
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