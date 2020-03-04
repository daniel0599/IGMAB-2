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
			<li><a href="#">Paciente</a></li>
			<li><a href="#">Ver Respuesta</a></li>
		</ol>
	</div>
</div>


<div class="box-content">
  <%
  int pacienteId = Integer.parseInt(request.getParameter("pacienteId"));
  %>
     <input name="pacienteId" type="hidden" value=<%=pacienteId%>  checked>
	<%
		//DATA TABLE QUE CARGA TODOS LOS TITULOS DE PREGUNTA
		DtTituloPregunta dttp = new DtTituloPregunta();
		ResultSet rsa = dttp.cargarDatos();
        //DATA TABLE QUE CARGA TODOS LOS VALORES DE RESPUESTA
        DtRespuestaVista dtrespvi = new DtRespuestaVista();
        ResultSet rsrevi = dtrespvi.cargarDatos(pacienteId);
		
		//Clasificacionde respuestas
		Integer a = 1;  //Seleccion multiple
		Integer b = 2;  //Respuesta cerrada
		Integer c = 3;  //Respuesta cerrada con descripcion
		Integer d = 4;  //Respuesta con Grado. 
		Integer e = 5;  //Sellecion Multiple con Descripcion
		
		
		int n=dtrespvi.numeroderespuestas(pacienteId); // Variable 	que almacena el numero de respuesta que contesto el usuario
    	System.out.println("el numero de Rs son: "+n);
    	
    	
		System.out.println("ANTES DEL WHILE QUE CARGA TODAS LOS TITULOS DE PREGUNTA");
		rsa.beforeFirst();
		while (rsa.next()) {

		System.out.println("ADENTRO DEL WHILE Y CON " + rsa.getInt("TitulopreguntaID") + "Titulo"+ rsa.getString("Descripcion"));
			
	%>
	<h1 id="head1">
		<%=rsa.getString("Descripcion")%>
	</h1>
	<h3 id="head2">
		Acontinuación las siguientes características se aplicaron a
		su/sus
		<%=rsa.getString("Descripcion")%>
	</h3>
	<%
	    	rsrevi.first();
	    	for(int i=0; i<n; i++){
		    	System.out.println("Adentro del for de respuesta con id"+rsrevi.getInt("RespuestacatalogoID"));             
       
		   if (rsrevi.getInt("TitulopreguntaID") == rsa.getInt("TitulopreguntaID")) {   //VALIDAMOS QUE LA RESPUESTA CATALOGO DEL RESULT SET PERTENEZCA A EL TITULO PREGUNTA QUE ESTA ACTIVO EN LA DESCRIPCION DE ARRIBA
			
		       if (Integer.parseInt(String.valueOf(rsrevi.getInt("ClasificacionID"))) == (a) ) { //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO A OSEA SELLECION MULTIPLE.
		    	   System.out.println("SI ES DE CLASIFICACION 1, seleccion");

 	          %>
	             <ol class="columns">
		            <li><label> <input type="checkbox"
				        name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" checked onclick="javascript: return false;"/><%=rsrevi.getString("rescDescripcion")%>
		             </label></li>
	             </ol>
	<%
		   } else if (Integer.parseInt(String.valueOf(rsrevi.getInt("ClasificacionID"))) == (b)) {  //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO B OSEA RESPUESTA CERRADA.
			   System.out.println("SI ES DE CLASIFICACION 2, CERRADA");
			   if(rsrevi.getInt("Seleccion") == 1){
	%>
	          <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	          <div class="row form-group">
		           <div class="col-sm-4">
			           <div class="radio">
				           <label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="1"  checked disabled> Sí
					          <i class="fa fa-circle-o"></i>
				           </label>
			           </div>
			           <div class="radio">
				           <label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="0" disabled > No <i
					         class="fa fa-circle-o"></i>
				           </label>
			           </div>
		           </div>
	         </div>
               <%} else { %>
                <h4><%=rsrevi.getString("rescDescripcion")%></h4>
     	          <div class="row form-group"><div class="col-sm-4">
			           <div class="radio">
				           <label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="1" disabled> Sí
					          <i class="fa fa-circle-o"></i>
				           </label>
			           </div>
			           <div class="radio">
				           <label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="0" checked disabled > No <i
					         class="fa fa-circle-o"></i>
				           </label>
			           </div>
		           </div>
	         </div>
               <%}%>
               
	<%
		} else if (Integer.parseInt(String.valueOf(rsrevi.getInt("ClasificacionID"))) == (c)) { //VALIDAMOS QUE LA RESPUESTA SEA DE TIPO C OSEA RESPUESTA CERRADA CON DESCRIPCION.
	        System.out.println("SI ES DE CLASIFICACION 3, CERRADA CON DESC");
				  System.out.println("YA VA A MOSTRAR LA CERRADA con descripcion");   
				  System.out.println("La seleccion es "+ rsrevi.getInt("Seleccion")+" la desc es : "+rsrevi.getString("Descripcion"));   
				  
				 if(rsrevi.getInt("Seleccion") == 1){
				 %>

	         <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	            <div class="row form-group">
		           <div class="col-sm-4">
			            <div class="radio">
				             <label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="1" checked disabled > Sí
					              <i class="fa fa-circle-o"></i>
				             </label>
			            </div>
			            <div class="radio">
				             <label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="0" disabled> No <i
					                 class="fa fa-circle-o"></i>
				             </label>
			            </div>
			        <label class="col-sm-2 ">¿Por qué? </label>
			            <div class="col-sm-4">
				             <input name ="respcatdesc<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="text" class="form-control" readonly size="80" maxlength="100" placeholder="<%=rsrevi.getString("Descripcion").trim() %>">
			            </div>
		           </div>
	          </div>
	               <%} else {%>
	                    <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	            <div class="row form-group">
		           <div class="col-sm-4">
			            <div class="radio">
				             <label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="1" disabled> Sí
					              <i class="fa fa-circle-o"></i>
				             </label>
			            </div>
			            <div class="radio">
				             <label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio" value="0" checked disabled> No <i
					                 class="fa fa-circle-o"></i>
				             </label>
			            </div>
			        <label class="col-sm-2 ">¿Por qué? </label>
			            <div class="col-sm-4">
				             <input name ="respcatdesc<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="text" class="form-control" readonly size="80" maxlength="100" placeholder="<%=rsrevi.getString("Descripcion").trim() %>">
			            </div>
		           </div>
	          </div>
	               <%}%>

	     
	<%
		} else if (Integer.parseInt(String.valueOf(rsrevi.getInt("ClasificacionID"))) == (d)) { // VALIDAMOS QUE LA RTESPUETA CATALOGO SEA DE TIPO D OSEA RESPUETACON GRADO
			 System.out.println("SI ES DE CLASIFICACION 4, GRADO");
	%>
	
	       <% if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 1){%>
	<h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled checked>1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled> 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled> 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	            <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 2 ){ %>
	               <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled >1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled checked> 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled> 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	           <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 3 ){ %>
	                 <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled >1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled> 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled checked> 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	             <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 4 ){ %>
	             	 <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled>1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled > 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled > 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled checked> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	             <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 5 ){%>
	                 <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled >1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled > 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled> 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled checked> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	             <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 6 ){ %>
	             	 <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled >1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled > 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled > 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled checked> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	             <%} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("Grado"))) == 7 ){ %>
	             	 <h4><%=rsrevi.getString("rescDescripcion")%></h4>
	<div class="row form-group">
		<div class="col-sm-12">
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="1" disabled>1
					<i class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="2" disabled > 2 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="3" disabled > 3 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="4" disabled> 4 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input  name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="5" disabled> 5 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="6" disabled> 6 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
			<div class="radio-inline">
				<label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" type="radio"  value="7" disabled checked> 7 <i
					class="fa fa-circle-o"></i>
				</label>
			</div>
		</div>
	</div>
	             <%} else {
	            	  System.out.println("LLEGO AL ELSE VACIO");
	            	 %>
	                     
	             <%}%>

	<%
		} else if(Integer.parseInt(String.valueOf(rsrevi.getInt("ClasificacionID"))) == (e)){
			 System.out.println("SI ES DE CLASIFICACION 5, OTRO");
		
	%>
	  <ol class="columns">
		<li><label> <input name="respcat<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>"  type="checkbox"
				OnClick="document.getElementById('txt_1').disabled = !this.checked" /><%=rsrevi.getString("rescDescripcion")%>
				<textarea id="txt_1" name="respcatdesc<%=rsrevi.getInt(8)%><%=rsrevi.getInt(9)%><%=rsrevi.getInt(7)%>" readonly placeholder="Escriba aquí..."
					rows="2" cols="40"><%=rsrevi.getString("Descripcion").trim() %></textarea>
		</label></li>
	</ol>
	     
	<%}%>
	<%}%>
	<% rsrevi.next();
	}%>
	<%}%>

</div>

<div class="modal-footer">
			<button id="cancelar" type="button" class="btn btn-default" data-dismiss="modal"  onClick="redireccionar();">Salir</button>

</div>

<script type="text/javaScript">
function redireccionar() {	
		window.location.href = "#ajax/paciente.jsp";
 		location.reload();
}
	$(document).ready(function() {
		document.getElementById('txt_1').disabled = true;

	});

</script>