<%@ page import="model.Usuario" %>
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
                                                <!-- TEM QUE MUDAR ISSO AQUI!!!!!!!!!!
                                                <?php if($usuarioLogado['imagem']){ ?>
                                                <img src="<?= base_url("uploads/{$usuarioLogado['imagem']}");?>" class="user-image" alt="<?= $usuarioLogado['nome'];?>" />
                                                <?php }else{ ?>	
                                                <img src="<?= base_url("front/dist/img/zethus-logo.jpg");?>" class="user-image" alt="<?= $usuarioLogado['nome'];?>" />
                                                <?php } ?>	-->								<!-- hidden-xs hides the username on small devices so only the image appears. -->
                                                
                                                <!-- É PRA MUDAR TAMBÉM!!!!!!
                                                <span class="hidden-xs"><?= $usuarioLogado['nome'];?></span> -->
                                        </a>
                                        <ul class="dropdown-menu">
                                                <!-- The user image in the menu -->
                                                <li class="user-header">
                                                        
                                                        <!-- É PRA MUDAR TAMBÉM!!!!!!
                                                        <?php if($usuarioLogado['imagem']){ ?>
                                                        <img src="<?= base_url("uploads/{$usuarioLogado['imagem']}");?>" class="img-circle" alt="<?= $usuarioLogado['nome'];?>" />
                                                        <?php }else{ ?>	
                                                        <img src="<?= base_url("front/dist/img/zethus-logo.jpg");?>" class="img-circle" alt="<?= $usuarioLogado['nome'];?>" />
                                                        <?php } ?>	

                                                        <p>
                                                                <?= $usuarioLogado['nome'];?>
                                                        </p> -->
                                                </li>

                                                <!-- Menu Footer-->
                                                <li class="user-footer">
                                                        <div class="pull-left">
                                                                <!-- É PRA MUDAR TAMBÉM!!!!!!
                                                                <?= anchor('gerencial/usuarios/visualiza/'.$usuarioLogado['id_usuario'], 'Perfil', array('class' => 'btn btn-default btn-flat'));?> -->
                                                        </div>
                                                        <div class="pull-right">
                                                                <!-- É PRA MUDAR TAMBÉM!!!!!!
                                                                <?= anchor('gerencial/logout', 'Sair', array('class' => 'btn btn-default btn-flat'));?> -->
                                                        </div>
                                                </li>
                                        </ul>
                                </li>
                        </ul>
                </div>
                </nav>
            </header>
        </div>
 