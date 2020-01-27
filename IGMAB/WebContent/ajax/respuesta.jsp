<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entidades.*, datos.*,java.sql.*"%>
<%@page import="datos.DtTituloPregunta"%>
<%@page import="datos.DtRespuestaCatalogo"%>
<%@page import="datos.Dt_Clasificacion_Respuesta"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setDateHeader("Expires", -1);
%>
<style>
* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;}

.csscolumns { #head1 { display:block;}

#head2 {
	display: none;}}
	
.no-csscolumns { #head1 { display:none;}
#head2 { display: block;}
}

.page {
	max-width: 1142px;
	margin: 0 auto;
}

.columns {
	-webkit-column-count: 3;
	-webkit-column-gap: 26px;
	-moz-column-count: 3;
	-moz-column-gap: 26px;
	column-count: 3;
	column-gap: 26px;
	list-style: none;
	margin: 0;
	padding: 0;
	position: relative;
	left: -340px;

	/* Small screen */
	@media
	all
	and
	(max-width:
	768px)
{
	-webkit-column-count
	:
	2;
	-moz-column-count	
	:
	3;
	column-count
	:	
	3;
}
/* Small screen */
@media all and (max-width: 600px) {
	-webkit-column-count
	:
	1;
	-moz-column-count
	:
	1;
	column-count
	:
	1;
}

}
li {
	position: relative;
	border-bottom: 1px solid #cdcac8;
	padding: 7px 7px 6px 0px; . no-csscolumns &{ display : block;
	float: left; @media all and (min-width: 769px) { margin-right : 3
	.05882 %; width : 31 .29412 %; & :nth-child(3n) {
	margin-right: 500px;
}

&
:nth-child(3n+1) {
	clear: left;
}

}
@media all and (min-width: 600px) and (max-width: 768px) {
	margin-right: 2.27671 %; width: 48.86165 %; &:nth-child(even) {
		margin-right: 0;
	}
	&
	:nth-child(odd) {
		clear: left;
	}
}

@media all and (max-width: 600px) {
	width
	:
	100%;
}

}
}
input[type=checkbox] {
	margin-right: 5px;
}
</style>
<%
	Dt_Vw_rol_opciones dtvrop = new Dt_Vw_rol_opciones();
	Usuario us = new Usuario();
	us = (Usuario) session.getAttribute("usuarioVerificado");

	Rol r = new Rol();
	r = (Rol) session.getAttribute("Rol");

	String url = "";
	url = request.getRequestURI();
	System.out.println("url: " + url);
	int index = request.getRequestURI().lastIndexOf("/");
	System.out.println("index: " + index);
	String miPagina = request.getRequestURI().substring(index);
	System.out.println("miPagina: " + miPagina);
	boolean permiso = false;
	String opcionActual = "";

	ResultSet rs;

	if (us != null && r != null) {
		rs = dtvrop.obtenerOpc(r);
		while (rs.next()) {
			opcionActual = rs.getString("opcion");
			System.out.println("opcionActual: " + opcionActual);
			if (opcionActual.equals(miPagina)) {
				permiso = true;
				break;
			} else {
				permiso = false;
			}
		}
	} else {
		response.sendRedirect("../Home.jsp");
		return;
	}

	if (!permiso) {
		response.sendRedirect("error.jsp");
	}
%>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Inicio</a></li>
			<li><a href="#">Gestion Paciente</a></li>
			<li><a href="#">Respuesta</a></li>
		</ol>
	</div>
</div>

<form class="form-horizontal form-label-left" name="ingresarrespuesta"
 	method="post" action="./SlRespuesta">  

<div class="box-content">
  <%
  int pacienteId = Integer.parseInt(request.getParameter("pacienteId"));
  %>
     <input name="pacienteId" type="hidden" value=<%=pacienteId%>  checked>
	<%
		//DATA TABLE QUE CARGA TODOS LOS TITULOS DE PREGUNTA
		DtTituloPregunta dttp = new DtTituloPregunta();
		ResultSet rsa = dttp.cargarDatos();
		//DATA TABLE QUE CARGA TODAS LAS RESPUESTA CATALOGO
		DtRespuestaCatalogo dtres = new DtRespuestaCatalogo();
		ResultSet rsre = dtres.CargarDatos();

		//ARRAYLIST A cargar  
		//	ArrayList<Respueta> Repuestas = new ArrayList<Respuesta>();

		//Clasificacionde respuestas
		Integer a = 1;  //Seleccion multiple
		Integer b = 2;  //Respuesta cerrada
		Integer c = 3;  //Respuesta cerrada con descripcion
		Integer d = 4;  //Respuesta con Grado. 
		Integer e = 5;  //Sellecion Multiple con Descripcion
		
		System.out.println("ANTES DEL WHILE QUE CARGA TODAS LOS TITULOS DE PREGUNTA");
		rsa.beforeFirst();
		while (rsa.next()) {

		System.out.println("ADENTRO DEL WHILE Y CON " + rsa.getInt("TitulopreguntaID") + "Titulo"+ rsa.getString("Descripcion"));
			
	%>
	<h1 id="head1">
		<%=rsa.getString("Descripcion")%>
	</h1>
	<h3 id="head2">
		Señale cuáles de las siguientes características pueden aplicarse a
		su/sus
		<%=rsa.getString("Descripcion")%>
	</h3>
	<%
		rsre.beforeFirst();
	    while (rsre.next()) {

		if (rsre.getInt("TitulopreguntaID") == rsa.getInt("TitulopreguntaID")) {   //VALIDAMOS QUE LA RESPUESTA CATALOGO DEL RESULT SET PERTENEZCA A EL TITULO PREGUNTA QUE ESTA ACTIVO EN LA DESCRIPCION DE ARRIBA
			
		if (Integer.parseInt(String.valueOf(rsre.getInt("ClasificacionID"))) == (a)) { //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO A OSEA SELLECION MULTIPLE.
 	%>
	<ol class="columns">
		<li><label> <input type="checkbox"
				name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" /><%=rsre.getString("Descripcion")%>
		</label></li>
	</ol>
	<%
		} else if (Integer.parseInt(String.valueOf(rsre.getInt("ClasificacionID"))) == (b)) {  //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO B OSEA RESPUESTA CERRADA.
	%>
	<h4><%=rsre.getString("Descripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-4">
			<div class="radio">
				<label> <input name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio" value="1"  checked> Sí
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio">
				<label> <input name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio" value="0"> No <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	<%
		} else if (Integer.parseInt(String.valueOf(rsre.getInt("ClasificacionID"))) == (c)) { //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO C OSEA RESPUESTA CERRADA CON DESCRIPCION.
	%>

	<h4><%=rsre.getString("Descripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-4">
			<div class="radio">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio" value="1" checked> Sí
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio" value="0"> No <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<label class="col-sm-2 ">¿Por qué? </label>
			<div class="col-sm-4">
				<input name ="respcatdesc<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="text" class="form-control">
			</div>
		</div>
	</div>
	<%
		} else if (Integer.parseInt(String.valueOf(rsre.getInt("ClasificacionID"))) == (d)) { // VALIDAMOS QUE LA RTESPUETA CATALOGO SEA DE TIPO D OSEA RESPUETACON GRADO
	%>
	<h4><%=rsre.getString("Descripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="1" checked>1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="2"> 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="3"> 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="4"> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="5"> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="6"> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" type="radio"  value="7"> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	<%
		}else if(Integer.parseInt(String.valueOf(rsre.getInt("ClasificacionID"))) == (e)){
	%>
	  <ol class="columns">
		<li><label> <input name="respcat<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>"  type="checkbox"
				OnClick="document.getElementById('txt_1').disabled = !this.checked" /><%=rsre.getString("Descripcion")%>
				<textarea id="txt_1" name="respcatdesc<%=rsre.getInt(4)%><%=rsre.getInt(5)%><%=rsre.getInt(3)%>" placeholder="Escriba aquí..."
					rows="2" cols="40"></textarea>
		</label></li>
	</ol>
	<%}%>
	<%}%>
	<%}%>
	<%}%>
</div>

<div class="modal-footer">
			<button id="cancelar" type="button" class="btn btn-default" data-dismiss="modal"  onClick="redireccionar();">Cancelar</button>
            <button type="submit" class="btn btn-primary">Guardar</button>
</div>
 </form>  



<script type="text/javaScript">

function redireccionar() {
// 	confirm(function(){
// 		           window.location.href = "#ajax/paciente.jsp";
// 		           location.reload();
// 		  		  }, function(){
// 		     		  infoAlert('Aviso', 'Eliminación cancelada');
// 		 		  })
	
	
		window.location.href = "#ajax/paciente.jsp";
 		location.reload();
}
	$(document).ready(function() {
		document.getElementById('txt_1').disabled = true;
		
// 		$('#cancelar').click(function() {
// 			window.location.href = "./index.jsp" 
// 			location.reload();
// 		});
	});
	

   
</script>





