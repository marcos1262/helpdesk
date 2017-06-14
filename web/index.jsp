<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <title>Sistema Helpdesk</title>

    <jsp:include page="include/security.jsp"/>
    <%
        Usuario usuario;
        if ((usuario = (Usuario) session.getAttribute("usuario")) == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <jsp:include page="importCSS.jsp"/>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="header.jsp"%>

    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                Dashboard
                <small>Control panel</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Dashboard</li>
            </ol>
        </section>

        <section class="content">
            Crie seu chamado:
            <br>
            <form name="chamado" action="index.jsp" method="post">
                <input type="text" name="titulo" placeholder="Título"/>
                <input type="text" name="prioridade" placeholder="Prioridade"/>
                <input type="text" name="descricao" placeholder="Descrição"/>
                <input type="submit" name="gerar" placeholder="Criar chamado"/>
            </form>

            <%
                /*String titulo=request.getParameter("titulo");
                String prioridade=request.getParameter("prioridade");
                String descricao=request.getParameter("descricao");
                if(titulo != null && prioridade != null && descricao != null){
                    if(titulo.equals("")){
                        out.print("<script>alert('O campo titulo Ã© obrigatÃ³rio!');</script>");
                    }
                    if(prioridade.equals("")){
                        out.print("<script>alert('O campo prioridade Ã© obrigatÃ³rio!');</script>");
                    }
                    if(descricao.equals("")){
                        out.print("<script>alert('O campo descricao Ã© obrigatÃ³rio!');</script>");
                    }
                }
                Facade fachada= new Facade();
                fachada.abreChamado(titulo, prioridade, descricao, usuario.getId());*/
            %>


            <%
                //TESTANDO abreChamado
                /*
                new Facade().abreChamado("teste", "ALTA", "I'm with problems", usuario.getId());
                */

                // TESTANDO consultaChamados

                Chamado c1 = new Chamado();
                c1.setTitulo("teste");
                List<Chamado> res = new Facade().consultaChamados(c1, 0, 20);
                for (Chamado c : res) {
                    out.println("C:" + c.getId());
                }

            %>
        </section>
    </div>
</div>
</body>
</html>
