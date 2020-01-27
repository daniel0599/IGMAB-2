
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="entidades.*, datos.*, java.sql.ResultSet"%>
<!DOCTYPE html>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Cache-Control","must-revalidate");
response.setDateHeader("Expires", -1);
%>
<html lang="en">
	<head>
<!-- 		<link rel="stylesheet" type="text/css" href="css/site.css" /> -->
    	
		<meta charset="utf-8">
		<title>IGMAB</title>
		<meta name="description" content="description">
		<meta name="author" content="DevOOPS">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<!-- 		<link href="css/font-awesome.css" rel="stylesheet"> -->
		<link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet" type='text/css'>
		<link href="css/righteous.css" rel='stylesheet' type='text/css'>
		<link href="plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
		<link href="plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
		<link href="plugins/xcharts/xcharts.min.css" rel="stylesheet">
		<link href="plugins/select2/select2.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<link rel="stylesheet" href="jAlert-master/dist/jAlert.css" />
		
		 <style type="text/css">
		 .ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {
      		color: black;
     		font-weight: bold;
		 }
		</style>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
				<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
				<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
		<![endif]-->

<%
	
	
    Dt_Vw_rol_opciones dtvrop = new Dt_Vw_rol_opciones();
	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("usuarioVerificado");
	
	int usuarioId=us.getUsuarioID();
	
	Rol r = new Rol();
	r = (Rol)session.getAttribute("Rol");
	
	String url="";
	url = request.getRequestURI();
	System.out.println("url: "+url);
	int index = request.getRequestURI().lastIndexOf("/");
	System.out.println("index: "+index);
	String miPagina = request.getRequestURI().substring(index);
	System.out.println("miPagina: "+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	
	
	ResultSet rs;
	
	if(us != null && r != null){		
		rs=dtvrop.obtenerOpc(r);
		while(rs.next())
		{
			opcionActual = rs.getString("opcion");
			System.out.println("opcionActual: "+opcionActual);
			if(opcionActual.equals(miPagina))
			{
				permiso = true;
				break;
			}
			else
			{
				permiso = false;
			}
		}
	}
	else
	{
		response.sendRedirect("Home.jsp");		
		return;
	}
	
	if(!permiso)
	{
		response.sendRedirect("error.jsp");
	}	
%>
	</head>
<body>
<!--Start Header-->
<div id="screensaver">
	<canvas id="canvas"></canvas>
	<i class="fa fa-lock" id="screen_unlock"></i>
</div>
<div id="modalbox">
	<div class="devoops-modal">
		<div class="devoops-modal-header">
			<div class="modal-header-name">
				<span>Basic table</span>
			</div>
			<div class="box-icons">
				<a class="close-link">
					<i class="fa fa-times"></i>
				</a>
			</div>
		</div>
		<div class="devoops-modal-inner">
		</div>
		<div class="devoops-modal-bottom">
		</div>
	</div>
</div>
<header class="navbar">
	<div class="container-fluid expanded-panel">
		<div class="row">
			<div id="logo" class="col-xs-12 col-sm-2">
				<a href="index.jsp">IGMAB</a>
			</div>
			<div id="top-panel" class="col-xs-12 col-sm-10">
				<div class="row">
					<div class="col-xs-8 col-sm-4">
						<a href="#" class="show-sidebar">
						  <i class="fa fa-bars"></i>
						</a>
						<!-- <div id="search">
							<input type="text" placeholder="search"/>
							<i class="fa fa-search"></i>
						</div> -->
					</div>
					<div class="col-xs-4 col-sm-8 top-panel-right">
						<ul class="nav navbar-nav pull-right panel-menu">
							<!-- <li class="hidden-xs">
								<a href="index.jsp" class="modal-link">
									<i class="fa fa-bell"></i>
									<span class="badge">7</span>
								</a>
							</li>
							<li class="hidden-xs">
								<a class="ajax-link" href="ajax/calendar.html">
									<i class="fa fa-calendar"></i>
									<span class="badge">7</span>
								</a>
							</li>
							<li class="hidden-xs">
								<a href="ajax/page_messages.html" class="ajax-link">
									<i class="fa fa-envelope"></i>
									<span class="badge">7</span>
								</a>
							</li> -->
							<li class="dropdown">
								<a href="#" class="dropdown-toggle account" data-toggle="dropdown">
									<div class="avatar">
										<img src="img/10000000000257660_1920x1080.jpg" class="img-rounded" alt="avatar" />
									</div>
									<i class="fa fa-angle-down pull-right"></i>
									<div class="user-mini pull-right">
										<span class="welcome">Bienvenido</span>
										<span><%=us.getUsuario() %></span>
									</div>
								</a>
								<ul class="dropdown-menu">
<!-- 									<li> -->
<!-- 										<a href="#"> -->
<!-- 											<i class="fa fa-user"></i> -->
<!-- 											<span class="hidden-sm text">Profile</span> -->
<!-- 										</a> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<a href="ajax/page_messages.html" class="ajax-link"> -->
<!-- 											<i class="fa fa-envelope"></i> -->
<!-- 											<span class="hidden-sm text">Messages</span> -->
<!-- 										</a> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<a href="ajax/gallery_simple.html" class="ajax-link"> -->
<!-- 											<i class="fa fa-picture-o"></i> -->
<!-- 											<span class="hidden-sm text">Albums</span> -->
<!-- 										</a> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<a href="ajax/calendar.html" class="ajax-link"> -->
<!-- 											<i class="fa fa-tasks"></i> -->
<!-- 											<span class="hidden-sm text">Tasks</span> -->
<!-- 										</a> -->
<!-- 									</li> -->
<!-- 									<li> -->
<!-- 										<a href="#"> -->
<!-- 											<i class="fa fa-cog"></i> -->
<!-- 											<span class="hidden-sm text">Settings</span> -->
<!-- 										</a> -->
<!-- 									</li> -->
									<li id="logout">									
										<a href="Home.jsp">
											<i class="fa fa-power-off"></i>
											<span  class="hidden-sm text">Cerrar Sesión</span>
											
										</a>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!--End Header-->
<!--Start Container-->
<div id="main" class="container-fluid">
	<div class="row">
		<div id="sidebar-left" class="col-xs-2 col-sm-2">
			<ul class="nav main-menu">
				<li>
					<a href="ajax/dashboard.html" class="active ajax-link">
						<i class="fa fa-dashboard"></i>
						<span class="hidden-xs">Inicio</span>
					</a>
				</li>

				<li class="dropdown">
					<a href="#" class="dropdown-toggle">
						<i class="fa fa-heart"></i>
						<span class="hidden-xs">Gestión Paciente</span>
					</a>
					<ul class="dropdown-menu">
                        <li><a class="ajax-link" href="ajax/paciente.jsp">Paciente</a></li>
						<li><a class="ajax-link" href="ajax/Pariente.jsp">Pariente</a></li>
						<li><a class="ajax-link" href="ajax/Pariente-Paciente.jsp">Asignar parientes</a></li>
						<li><a class="ajax-link" href="ajax/HistoriaClinica.jsp">Historia clínica</a></li>
					</ul>
				</li>

                <li>
                    <a class="ajax-link" href="ajax/Cita.jsp">
                        <i class="fa fa-table"></i>
                        <span class="hidden-xs">Gestión citas</span>
                    </a>
                </li>

                <li>
                    <a class="ajax-link" href="ajax/consulta.jsp">
                    <i class="fa fa-pencil"></i>
                    <span class="hidden-xs">Gestión consulta</span>
                    </a>
                </li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <i class="fa fa-file-text"></i>
                        <span class="hidden-xs">Reportes</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a  class="ajax-link" href="ajax/pacientes.jsp">Reporte de pacientes</a></li>

                        <li><a  class="ajax-link" href="ajax/ReporteAsistencia.jsp">Reporte de asistencia</a></li>
                    </ul>
                </li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <i class="fa fa-shield"></i>
                        <span class="hidden-xs">Seguridad y mantenimiento</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="ajax-link" href="ajax/RegistroUsuarios.jsp">Usuario</a></li>
                        <li><a class="ajax-link" href="ajax/rol.jsp">Rol</a></li>
                        <li><a class="ajax-link" href="ajax/RolUsuario.jsp">Asignar rol a usuario</a></li>
                        <li><a class="ajax-link" href="ajax/RolOpcion.jsp">Agregar opción a rol</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">
                                <i class="fa fa-book"></i>
                                <span class="hidden-xs">Catálogos</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a  class="ajax-link" href="ajax/psicologo.jsp">Psicólogo</a></li>
                                <li><a  class="ajax-link" href="ajax/parentesco.jsp">Parentesco</a></li>

                            </ul>
                        </li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle">
								<i class="fa fa-question-circle"></i>
								<span class="hidden-xs">Preguntas</span>
							</a>
							<ul class="dropdown-menu">
								<li><a class="ajax-link" href="ajax/tituloPregunta.jsp">Título Pregunta</a></li>
								<li><a class="ajax-link" href="ajax/respuestacatalogo.jsp">Respuesta Catálogo</a></li>
							</ul>
						</li>
                    </ul>
                </li>
            </ul>
            </li>
            </ul>
		</div>
		<!--Start Content-->
		<div id="content" class="col-xs-12 col-sm-10">
			<div class="preloader">
				<img src="img/devoops_getdata.gif" class="devoops-getdata" alt="preloader"/>
			</div>
			<div id="ajax-content"></div>
		</div>
		<!--End Content-->
	</div>
</div>


<!--End Container-->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!--<script src="http://code.jquery.com/jquery.js"></script>-->


<script src="plugins/jquery/jquery-2.1.0.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="plugins/bootstrap/bootstrap.min.js"></script>
<script src="plugins/jquery-maskedinput/jquery.maskedinput.js"></script>
<script src="plugins/justified-gallery/jquery.justifiedgallery.min.js"></script>
<script src="plugins/tinymce/tinymce.min.js"></script>
<script src="plugins/tinymce/jquery.tinymce.min.js"></script>
<script src="jquery-1.7.1.min.js"></script>
<script src="jAlert-master/dist/jAlert.min.js"></script>
<script src="jAlert-master/dist/jAlert-functions.min.js"> //optional!!</script>
<!-- All functions for this theme + document.ready processing -->
<script src="js/devoops.js"></script>

<script type="text/javascript">	
	function actualizarAsistencia() {
		var fusuarioId ="<%=usuarioId%>";
		
		$.ajax({
			url : "SlAsistencia",
			type : "post",
			datatype : 'html',
			data : {
				'fusuarioId' : fusuarioId
			}
		});
	}
	
	$(document).ready(function() {
		$("#logout").click(function() {  
	   		actualizarAsistencia();
		});
	}); // No redirige index a home -.-
	
</script>
<script type="text/javascript" src="plugins/jquery-ui-timepicker-addon/jquery-ui-timepicker-addon.js"></script>
</body>
</html>
