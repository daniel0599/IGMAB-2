<%@page import="java.util.*"%>
<%@page import="datos.*"%>
<%@page import="entidades.*"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
%>
<html lang="en">
<head>
		<title>LOGIN</title>
		<meta name="description" content="description">
		<meta name="author" content="Evgeniya">
		<meta name="keyword" content="keywords">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="../plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
		<link href="../css/style.css" rel="stylesheet">
		<link href="../plugins/select2/select2.css" rel="stylesheet">
		
		
		
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
				<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
				<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
		<![endif]-->
		<%
	
	
	Dt_Vw_rol_opciones dtvrop = new Dt_Vw_rol_opciones();

	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("usuarioVerificado");
	
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
	
	if(us != null && r != null)
	{
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
<div class="container-fluid">
	<div id="page-login" class="row">
		<div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
			<div class="text-right">
				<a href="page_register.html" class="txt-default">Need an account?</a>
			</div>
			<div class="box">
				<div class="box-content">
					<div class="text-center">
						<h3 class="page-header">Inicio de Sesión</h3>
					</div>
					<form action="../SlSeguridad" method="post">
						<div class="form-group">
							<label class="control-label">Usuario</label>
							<input type="text" class="form-control" name="username" id="username"/>
						</div>
						<div class="form-group">
							<label class="control-label">Contraseña</label>
							<input type="password" class="form-control" name="password" id="password"/>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Roles</label>
								<select class="populate placeholder" name="rol" id="rol">
									<option value="">-- Seleccione un Rol --</option>
									<%
										DtRol dtr = new DtRol();	
										 rs = dtr.cargarDatos();
										while(rs.next())
										{
									%>
									<option value="<%=rs.getInt("RolID")%>"><%=rs.getString("Nombre")%></option>
									<%
										}	
									%>
								</select>
						</div>
						<div class="form-group">					
							<div class="text-center">
								<input type="submit" class="btn btn-primary" value="Entrar">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!--<script src="http://code.jquery.com/jquery.js"></script>-->
<script src="../plugins/jquery/jquery-2.1.0.min.js"></script>
<script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="../plugins/select2/select2.min.js"></script>
<script src="../plugins/bootstrap/bootstrap.min.js"></script>

<!-- All functions for this theme + document.ready processing -->
<script src="../js/devoops.js"></script>

<script type="text/javascript">
// Run Select2 plugin on elements
function DemoSelect2()
{
	$('#rol').select2();
}

$(document).ready(function() 
{
	LoadSelect2Script(DemoSelect2);
	WinMove();
});

</script>

</body>
</html>