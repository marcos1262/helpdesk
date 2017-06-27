<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS | skin-blue |
| | skin-black |
| | skin-purple |
| | skin-yellow |
| | skin-red |
| | skin-green |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed |
| | layout-boxed |
| | layout-top-nav |
| | sidebar-collapse |
|---------------------------------------------------------|

-->
<!-- Main Header-->
<header class="main-header">

    <!-- Logo -->
    <a href="<%= application.getContextPath() %>/index.jsp" class="logo"><b>Help</b>Desk</a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <!-- User Account Menu -->
                <li class="dropdown user user-menu">
                    <!-- Menu Toggle Button -->
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <!-- The user image in the navbar-->
                        <% if (usuario.getImagem() != null) { %>
                        <img src="<%= application.getContextPath() %>/uploads/<%= usuario.getImagem() %>"
                             class="user-image"
                             alt="<%= usuario.getNome() %>"/>
                        <% } else { %>
                        <img src="<%= application.getContextPath() %>/assets/img/avatar.png"
                             class="user-image"
                             alt="<%= usuario.getNome() %>"/>
                        <% } %>
                        <!-- hidden-xs hides the username on small devices so only the image appears. -->

                        <span class="hidden-xs"><%= usuario.getNome() %></span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- The user image in the menu -->
                        <li class="user-header">

                            <% if (usuario.getImagem() != null) { %>
                            <img src="<%= application.getContextPath() %>/uploads/<%= usuario.getImagem() %>"
                                 class="img-circle"
                                 alt="<%= usuario.getNome() %>"/>
                            <% } else { %>
                            <img src="<%= application.getContextPath() %>/assets/img/avatar.png"
                                 class="img-circle"
                                 alt="<%= usuario.getNome() %>"/>
                            <% } %>

                            <p>
                                <%= usuario.getNome() %>
                            </p>
                        </li>

                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-left">
                                <!-- Visualizar usuário -->
                                <a href="#" class="btn btn-default btn-flat">Perfil</a>
                            </div>
                            <div class="pull-right">
                                <!-- LOGOUT -->
                                <form name="Sair" action="<%= application.getContextPath() %>/include/security.jsp"
                                      method="post">
                                    <input type="submit" class="btn btn-default btn-flat" name="Sair" value="Sair"/>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel">
            <div class="pull-left image">
                <% if (usuario.getImagem() != null) { %>
                <img src="<%= application.getContextPath() %>/uploads/<%= usuario.getImagem() %>" class="img-circle"
                     alt="<%= usuario.getNome() %>"/>
                <% } else { %>
                <img src="<%= application.getContextPath() %>/assets/img/avatar.png"
                     class="img-circle"
                     alt="<%= usuario.getNome() %>"/>
                <% } %>
            </div>
            <div class="pull-left info">
                <p><%= usuario.getNome() %></p>
                <%= usuario.getTipo().getDescricao()%>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu">

            <!-- Optionally, you can add icons to the links -->
            <li class="<% if(request.getRequestURI().contains("index.jsp")){%> active <%}%>">
                <a href="<%= application.getContextPath() %>/index.jsp"><i class="fa fa-fw fa-home"></i><span>
                    Início
                </span></a>
            </li>
            <c:if test="${usuario.tipo == 'ADMIN'}">
                <li class="treeview <% if(request.getRequestURI().contains("usuario.jsp")){%> active <%}%>">
                    <a href="#"><i class="fa fa-fw fa-user"></i> <span>
                    Usuários
                </span><i class="fa fa-angle-left pull-right"></i></a>
                    <ul class="treeview-menu">
                        <li><a href="#">
                            Novo Usuário
                        </a></li>
                        <li><a href="#">
                            Lista de Usuários
                        </a></li>
                    </ul>
                </li>
            </c:if>

            <li class="treeview <% if(request.getRequestURI().contains("chamado.jsp")){%> active <%}%>">
                <a href="#"><i class="fa fa-fw fa-desktop"></i> <span>Chamados</span> <i
                        class="fa fa-angle-left pull-right"></i></a>
                <ul class="treeview-menu">
                    <li><a href="<%=application.getContextPath()%>/Chamado/abrir.jsp">Novo Chamado</a></li>
                    <li><a href="<%=application.getContextPath()%>/index.jsp">Meus Chamados</a></li>
                    <c:if test="${usuario.tipo == 'TECNI'}">
                        <li><a href="<%=application.getContextPath() %>/index.jsp">Chamados para atender</a></li>
                    </c:if>
                </ul>
            </li>

        </ul><!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>
