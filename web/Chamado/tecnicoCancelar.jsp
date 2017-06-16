<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="pt-br">

<head>
    <title>Sistema Helpdesk</title>

    <jsp:include page="../include/security.jsp"/>
    <%
        Usuario usuario;
        if ((usuario = (Usuario) session.getAttribute("usuario")) == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
    %>

    <jsp:include page="../importCSS.jsp"/>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="../header.jsp"%>

    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                Cancelar
                <small>Chamados</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="<%= application.getContextPath() %>/index.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Excluir chamado</li>
            </ol>
        </section>

        <section class="content">
                    
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        
                        <!-------------------------------------------------->
                        <!-- TEM QUE RECEBER UM CHAMADO E SETAR OS CAMPOS -->
                        <!-- ACTION VAI PARA O JSP QUE EXCLUI NO BANCO    -->
                        <!-- VERIFICAR SE ADICIONOU UMA JUSTIFICATIVA     -->
                        <!-------------------------------------------------->
                        
                        <form class="form-horizontal" action="">
                            <input type="hidden" name="id" value=""/>
                            
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Titulo</label>
                                <div class="col-md-4">
                                        <input name="titulo" type="text" class="form-control" value="" disabled="true">
                                </div>

                                <label class="control-label col-md-1 required">Prioridade</label>
                                <div class="col-md-2">
                                        <input name="prioridade" type="text" class="form-control" value="" disabled="true">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Status</label>
                                <div class="col-md-4">
                                        <input name="status" type="text" class="form-control" value="" disabled="true">
                                </div>

                                <label class="control-label col-md-1 required">Data<strong class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                        <input name="data" type="text" class="form-control" value="" disabled="true">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Solicitante</label>
                                <div class="col-md-4">
                                    <input name="solicitante" type="text" class="form-control" value="<%= usuario.getId() %>" disabled="true"abled="true"/>
                                </div>

                                <label class="control-label col-md-1 required">Técnico<strong class="text-danger">*</strong></label>
                                <div class="col-md-2">
                                        <input name="tecnico" type="text" class="form-control" value="" disabled="true"/>
                                </div>
                            </div>
                                
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Justificativa do Status</label>
                                <div class="col-md-4">
                                    <textarea disabled="true" value="Aqui vai ter a justificativa"></textarea>
                                </div>
                            </div>
                                
                            <div class="form-group">
                                <label class="control-label col-md-2 required">Justificativa do cancelamento<strong class="text-danger">*</strong></label>
                                <div class="col-md-4">
                                    <textarea placeholder="Digite a justificativa"></textarea>
                                </div>
                            </div>
                                
                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                        <button type="submit" class="btn btn-danger">Cancelar chamado</button>
                                        <a href="<%= application.getContextPath() %>/index.jsp" class="btn btn-default">Voltar para tela inicial</a>
                                </div>
                            </div>
                        </form>
                    </div>						

                </div>
            </section><!-- /.content -->

        </section>
    </div>
</div>
        
            <%@include file="../footer.jsp" %>
</body>
</html>
