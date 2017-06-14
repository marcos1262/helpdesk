<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        
        <title>Sistema Helpdesk</title>
        
        <%-- Java Code --%>
        <jsp:include page="include/security.jsp"/>
        <%
            Usuario usuario;

            if ((usuario = (Usuario) session.getAttribute("usuario")) == null)
                response.sendRedirect("login.jsp");
            else {
        %>
        
        <!--Bootstrap-->
        <link rel="stylesheet" href="assets/AdminLTE-2.3.11/bootstrap/css/bootstrap.min.css">
        
        <!--FontAwesome-->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        
        <!--AdminLTE | Theme style-->
        <link rel="stylesheet" href="assets/AdminLTE-2.3.11/dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
        -->
        <link href="assets/AdminLTE-2.3.11/dist/css/skins/skin-blue.min.css" rel="stylesheet" type="text/css" />
        
        <!-- REQUIRED JS SCRIPTS -->
        <!-- jQuery 2.1.3 -->
        <script src="assets/AdminLTE-2.3.11/plugins/jQuery/jquery-2.2.3.min.js"></script>
        
    </head>
    
    
    
    <!--
	BODY TAG OPTIONS:
	=================
	Apply one or more of the following classes to get the 
	desired effect
	|---------------------------------------------------------|
	| SKINS         | skin-blue                               |
	|               | skin-black                              |
	|               | skin-purple                             |
	|               | skin-yellow                             |
	|               | skin-red                                |
	|               | skin-green                              |
	|---------------------------------------------------------|
	|LAYOUT OPTIONS | fixed                                   |
	|               | layout-boxed                            |
	|               | layout-top-nav                          |
	|               | sidebar-collapse                        |  
	|---------------------------------------------------------|

	-->
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            
            <!-- Main Header-->
            <header class="main-header">
                
            <!-- Logo -->
            <a href="index.jsp" class="logo"><b>Help</b>Desk</a>
            
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
                                                <% if(usuario.getImagem() != null){ %>
                                                    <img src="assets/uploads/<%= usuario.getImagem() %>" class="user-image" alt="<%= usuario.getNome() %>" />
                                                <% }else{ %>	
                                                    <img src="assets/AdminLTE-2.3.11/dist/img/avatar.png" class="user-image" alt="<%= usuario.getNome() %>" />
                                                <% } %>								<!-- hidden-xs hides the username on small devices so only the image appears. -->
                                                
                                                <span class="hidden-xs"><%= usuario.getNome() %></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                                <!-- The user image in the menu -->
                                                <li class="user-header">
                                                        
                                                        <% if(usuario.getImagem() != null){ %>
                                                            <img src="assets/uploads/<%= usuario.getImagem() %>" class="img-circle" alt="<%= usuario.getNome() %>" />
                                                        <% }else{ %>	
                                                            <img src="assets/AdminLTE-2.3.11/dist/img/avatar.png" class="img-circle" alt="<%= usuario.getNome() %>" />
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
                                                                <a href="#" class="btn btn-default btn-flat">Sair</a>
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
                                            <% if(usuario.getImagem() != null){ %>
                                                <img src="assets/uploads/<%= usuario.getImagem() %>" class="img-circle" alt="<%= usuario.getNome() %>" />
                                            <% }else{ %>	
                                                <img src="assets/AdminLTE-2.3.11/dist/img/avatar.png" class="img-circle" alt="<%= usuario.getNome() %>" />
                                            <% } %>
                                    </div>
                                    <div class="pull-left info">
                                            
                                            <p><%= usuario.getNome() %></p>
                                            <!-- Status -->
                                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                                    </div>
                            </div>

                            <!-- Sidebar Menu -->
                            <ul class="sidebar-menu">

                                    <!-- Optionally, you can add icons to the links -->
                                    <li class="<% if(request.getRequestURI().contains("index.jsp")){%> active <%}%>"<a href="index.jsp"><i class="fa fa-fw fa-home"></i> <span>Início</span></a></li>
                                    <li class="treeview <% if(request.getRequestURI().contains("usuario.jsp")){%> active <%}%>">
                                            <a href="#"><i class="fa fa-fw fa-user"></i> <span>Usuários</span> <i class="fa fa-angle-left pull-right"></i></a>
                                            <ul class="treeview-menu">
                                                <li><a href="#">Novo Usuário</a></li>
                                                <li><a href="#">Lista de Usuários</a></li>
                                            </ul>
                                    </li>

                                    <li class="treeview <% if(request.getRequestURI().contains("chamado.jsp")){%> active <%}%>">
                                            <a href="#"><i class="fa fa-fw fa-users"></i> <span>Chamados</span> <i class="fa fa-angle-left pull-right"></i></a>
                                            <ul class="treeview-menu">
                                                <li><a href="#">Novo Chamado</a></li>
                                                <li><a href="#">Lista de Chamados</a></li>
                                            </ul>
                                    </li>

                            </ul><!-- /.sidebar-menu -->
                    </section>
                    <!-- /.sidebar -->
            </aside>
        </div>
 