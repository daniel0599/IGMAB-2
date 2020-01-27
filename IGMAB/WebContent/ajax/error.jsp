<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    import="entidades.*, datos.*"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="Dashboard">
	<meta name="keyword"
		content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error | IGMAB</title>

</head>
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
<body>
<div id="container">
<%-- 		<jsp:include page="menu.jsp" flush="true" /> --%>

		<!-- **********************************************************************************************************************************************************
      CONTENIDO PRINCIPAL
      *********************************************************************************************************************************************************** -->


<div class="jumbotron">
	<div class="container">
		<h1 class="display-3 fa fa-warning txt-danger"> Acceso denegado</h1>
		<div class="clearfix"></div>
		<h3>Estimado usuario <%=rs.getString("rol")%></h3>
		<p>Este rol no cuenta con los permisos suficientes</p>
		<a class="back-btn" href="index.jsp"> Regresar a Inicio</a>
	</div>
</div>



			<!-- **********************************************************************************************************************************************************
      CONTENIDO DE PIÉ DE PÁGINA
  *********************************************************************************************************************************************************** -->

			<!--Inicio del Footer-->
<%-- 			<div><jsp:include page="footer.jsp" flush="true" /> --%>
			</div>
			<!--Fin footer-->
		
		<!--Fin main-content-->

	<!--Fin container-->
</body>
</html>