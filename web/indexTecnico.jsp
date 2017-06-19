<%--
<div class="nav-tabs-custom">
    <ul id="AbaChamados" class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#paraatender">PARA ATENDER</a></li>
            <li role="presentation"><a href="#meuschamados">MEUS CHAMADOS</a></li>
    </ul>
</div>
<div class="tab-content">
    <div id="paraatender" class="tab-pane fade in active">
        <%@include file="Chamado/paraAtender.jsp" %>
    </div>
    <div id="meuschamados" class="tab-pane fade">
        <%@include file="Chamado/chamadosTecnico.jsp" %>
    </div>
</div>

    <script>
        $(document).ready(function(){
            //ABA DE CHAMADO
            $('#AbaChamados a').click(function (e) {
                    e.preventDefault();
                    $(this).tab('show');
            });
        });
    </script> --%>

<h4>Para Atender</h4>
<%@include file="Chamado/paraAtender.jsp" %>

<hr>

<h4>Meus Chamados</h4>
<%@include file="Chamado/chamadosTecnico.jsp" %>