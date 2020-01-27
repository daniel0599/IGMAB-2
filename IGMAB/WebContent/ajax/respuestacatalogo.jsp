<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="datos.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
%>
	<style>
	select#soflow, select#soflow-color {
   -webkit-appearance: button;
   -webkit-border-radius: 2px;
   -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
   -webkit-padding-end: 20px;
   -webkit-padding-start: 2px;
   -webkit-user-select: none;
   background-image: url(http://i62.tinypic.com/15xvbd5.png), -webkit-linear-gradient(#FAFAFA, #F4F4F4 40%, #E5E5E5);
   background-position: 97% center;
   background-repeat: no-repeat;
   border: 1px solid #AAA;
   color: #555;
   font-size: inherit;
   margin: 20px;
   overflow: hidden;
   padding: 5px 10px;
   text-overflow: ellipsis;
   white-space: nowrap;
   width: 300px;
}

select#soflow-color {
   color: #fff;
   background-image: url(http://i62.tinypic.com/15xvbd5.png), -webkit-linear-gradient(#779126, #779126 40%, #779126);
   background-color: #779126;
   -webkit-border-radius: 20px;
   -moz-border-radius: 20px;
   border-radius: 20px;
   padding-left: 15px;
}
}
	</style>
	
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
		response.sendRedirect("../Home.jsp");
		return;
	}
	
	if(!permiso)
	{
		response.sendRedirect("error.jsp");
	}

%>
	
<div class="row">
<div class="col-xs-12 col-sm-12">
	<div id="breadcrumb" class="col-md-12">
	
	<!-- INICIO DE FORMULARIO PARA AGREGAR RESPUESTA CATALOGO  -->
	
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Seguridad y mantenimiento</a></li>
			<li><a href="#">Preguntas</a></li>
			<li><a href="#">Respuesta catalogo</a></li>
		</ol>
	</div>
	</div>
	</div>


<div class="row">
<div class="col-xs-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
			
			
			
				<div class="box-name">
					<i class="fa fa-search"></i>
					<span>Formulario de clasificación de preguntas</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link">
						<i class="fa fa-chevron-up"></i>
					</a>
					<a class="expand-link">
						<i class="fa fa-expand"></i>
					</a>
					<a class="close-link">
						<i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
 			<div class="box-content no-padding">
			 <div class="row">
<!-- 				<form class="form-horizontal" method="post" > -->
				<div class="col-sm-6">
				<h5 class="page-header">Clasificación de preguntas</h5>
					<div class="form-group">
					
						<div class="row form-group">
					<label class="col-sm-6 control-label">Seleccione el titulo de pregunta</label>
						<div class="col-sm-6">
								<select name="titulopregunta" id="titulopreguntaid">
								<option >Seleccione una opción</option>
								<%
								DtTituloPregunta dttp = new DtTituloPregunta();
								ResultSet rp = dttp.cargarDatos();
								rp.beforeFirst();
								
								while (rp.next()){
									%>
								   <option value = "<%= rp.getInt("tituloPreguntaId")%>"><%=rp.getString("Descripcion")%></option>
									<%
									}
								%>
							</select>
							</div>
						</div>
					</div>	
							
						<div class="form-group">
						  <div class="row form-group">
						    <label class="col-sm-6 control-label">Seleccione el tipo de respuesta</label>
						      <div class="col-sm-6">
								<select name="clasificacion" id="clasificacion">
								<option >Seleccione una opción</option>
								<%
								Dt_Clasificacion_Respuesta dtcr = new Dt_Clasificacion_Respuesta();
								ResultSet rpa = dtcr.cargarDatos();
								rpa.beforeFirst();
								
								while (rpa.next()){
									%>
								   <option value = "<%= rpa.getInt("ClasificacionID")%>"><%=rpa.getString("Descripcion")%></option>
									<%
									}
								%>
							</select>
							</div>
						  </div>
						</div>	
							
					
							 
						<div class="form-group">
						<label class="col-sm-6 control-label">Agregue una respuesta: </label>
						<div class="col-sm-6">
						<input type="text" class="form-control" placeholder="Ej. Triste, Feliz"
									id="respuestacatalogo" name="respuestacatalogo">
							</div>
						</div>
						
						
					
					
						</div>
					<div class="col-sm-6">
						<h5 class="page-header">Acciones</h5>
						<div class="form-group">
							<div id="cancelar_nuevo" class="col-sm-2 text-center">
								<button class="ajax-link action btn btn-default btn-label-left" type="reset" title="Cancelar">
									<span><i class="fa fa-minus-circle txt-danger"></i></span>
									Cancelar
									</button>
							</div>
							<div class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-primary btn-label-left" onClick="guardar();"
									title="Guardar">
									<span><i class="fa fa-check-circle txt-success"></i></span>Guardar
									</button>
							</div>
						</div>
						
</div>
<!-- </form> -->
					
							</div>
							</div>
							

							
							</div>
							</div>
							</div>
							
							<!-- FIN DE FORMULARIO PARA RESPUESTA CATALOGO  -->

							<!-- INICIO DE FORMULARIO PARA EDITAR RESPUESTA CATALOGO  -->
							
<!-- 						<div class="row"> -->
<!-- 						<div class="col-xs-12"> -->
						
						
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i>
					<span>Formulario de clasificación de preguntas</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link">
						<i class="fa fa-chevron-up"></i>
					</a>
					<a class="expand-link">
						<i class="fa fa-expand"></i>
					</a>
					<a class="close-link">
						<i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
 			<div class="box-content no-padding">
			 <div class="row">
<!-- 				<form class="form-horizontal" method="post" > -->
				<div class="col-sm-6">
				<h5 class="page-header">Clasificación de preguntas</h5>
					<div class="form-group">
				
					<div class="row form-group">
					<label class="col-sm-6 control-label">Seleccione el titulo de pregunta</label>
						<div class="col-sm-6">
								<select name="titulopreguntaEditar" id="titulopreguntaEditar">
								<option >Seleccione una opción</option>
								<%
								
								rp.beforeFirst();
								
								while (rp.next()){
									%>
								   <option value = "<%= rp.getInt("tituloPreguntaId")%>"><%=rp.getString("Descripcion")%></option>
									<%
									}
								%>
							</select>
							</div>
						</div>
						</div>	 
						
						<div class="form-group">
						  <div class="row form-group">
						    <label class="col-sm-6 control-label">Seleccione el tipo de respuesta</label>
						      <div class="col-sm-6">
								<select name="clasificacionEditar" id="clasificacionEditar">
								<option >Seleccione una opción</option>
								<%
								Dt_Clasificacion_Respuesta dtcra = new Dt_Clasificacion_Respuesta();
								ResultSet rpaa = dtcr.cargarDatos();
								rpaa.beforeFirst();
								
								while (rpaa.next()){
									%>
								   <option value = "<%= rpaa.getInt("ClasificacionID")%>"><%=rpaa.getString("Descripcion")%></option>
									<%
									}
								%>
							</select>
							</div>
						  </div>
						</div>	
							 	<div class="form-group">
								<label class="col-sm-6 control-label">Edite una respuesta: </label>
								<div class="col-sm-6">
								<input type="text" class="form-control" placeholder="Ej. Triste, Feliz"
											id="descripcionEditar" name="descripcionEditar">
								</div>
								</div>
								
						
					
						</div>
					<div class="col-sm-6">
						<h5 class="page-header">Acciones</h5>
						<div class="form-group">
							<div id="cancelar_nuevo_editar" class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-default btn-label-left" type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span>
									Cancelar
									</button>
							</div>
							<div class="col-sm-6 text-center">
								<!-- 									<button class="ajax-link action" onClick="guardarParentesco();" title="Guardar"> -->
								<!-- 										Guardar -->
								<!-- 									</button> -->
								<button id="btnEditar" class="ajax-link btn btn-primary btn-label-left"
									onClick="actualizar(this.value);" title="Editar">
									<span><i class="fa fa-check-circle txt-success"></i></span>
									Editar
									</button>
							</div>
						</div>
						
</div>
<!-- </form> -->
					
							</div>
							</div>
							</div>
<!-- 							</div> -->
<!-- 							</div> -->
					
					
						<div class="roq">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-location-arrow"></i>
						<span>Lista</span>
					</div>
					<div class="box-icons">
						<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
						</a> <a class="expand-link"> <i class="fa fa-expand"></i>
						</a> <a class="close-link"> <i class="fa fa-times"></i>
						</a>
					</div>
					<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar
						Respuesta</span>
				</div>
					
					<div class="no move"></div>
				</div>
				<div class="box-content no-padding">
					<div class="row padding-opc">
					<div class="col-md-12">
						<div class="col-md-12 col-xs-12 col-sm-12 agregar">
							<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#"
								title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i>
							</a>
						</div>

					</div>
				</div>
				<table class="table table-hover table-heading table-datatable" id="datatable-1">
					<thead>
						<tr>
							<th>Titulo de pregunta</th>
							<th>Respuesta</th>
							<th>Tipo Respuesta</th>
							<th>Acciones</th>
						</tr>
					</thead>
					
					<tbody>
					<%
						DtVRespuestaCatTituloPreg dtrc = new DtVRespuestaCatTituloPreg();
						rs = dtrc.cargarVista();
						rs.beforeFirst();
						
						while(rs.next())
						{
					
					%>
					
					<tr>
						<td><%=rs.getString("preguntaDesc") %></td>
						<td><%=rs.getString("respuestaDesc") %></td>
						<td><%=rs.getString("Descripcion") %></td>
						<td>
						
						<button id="btnEliminar" value=<%=rs.getInt("RespuestacatalogoID") %>
						class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'>
						<span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar</button>
						
						<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getInt("TitulopreguntaID")%>' ,'<%=rs.getString("respuestaDesc")%>' ,'<%=rs.getInt("ClasificacionID")%>' );"
									value=<%=rs.getInt("RespuestacatalogoID")%> class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span>
									Actualizar</button>
						 
						 </td>
						
						
					</tr>
					<% } %>
					
					</tbody>
					<tfoot>
						<tr>
							<th>Titulo de Pregunta</th>
							<th>Respuesta</th>
							<th>Tipo Respuesta</th>
							<th>Acciones</th>
						</tr>
					</tfoot>
					
				</table>
				</div>
			</div>
		</div>
	</div>


<!-- FIN DE FORMULARIO PARA EDITAR RESPUESTA CATALOGO  -->
					
				<script type = "text/javascript">
				
				// Funciones del websocket
				
				var wsUri = "ws://localhost:8080/IGMAB/serverendpointigmab";
				var websocket = new WebSocket(wsUri); //creamos el socket
				
				websocket.onopen = function(evt) { //manejamos los eventos...
					console.log("Conectado...");
				};

				websocket.onmessage = function(evt) { // cuando se recibe un mensaje
					//alert("Hubo cambio en la base de datos. Actualiza la pÃ¡gina para verlos");
					//log("Mensaje recibido:" + evt.data);
					refrescar();

				};

				websocket.onerror = function(evt) {
					console.log("oho!.. error:" + evt.data);
				};
				
				//MÃ©todo para ejecutar el websocket.onmessage y guardar
				function guardar() {
					guardarRespuestaCatalogo();
					
				}
				
				//MÃ©todo para ejecutar el websocket.onmessage y actualizar
				function actualizar(idClicked) {
					actualizarRespuestaCatalogo(idClicked);
					
				}
				
				//MÃ©todo para ejecutar el websocket.onmessage y eliminar
				function eliminar(idClicked){
					confirm(function(){
						eliminarRespuestaCatalogo(idClicked);

					  }, function(){
						  infoAlert('Aviso', 'Eliminación cancelada');
					  });
					
				}
				
				//MÃ‰TODO PARA REFRESCAR EL DATATABLE A TRAVÃ‰S DEL SERVLET
				function refrescar() {
					var opcion = "";
					opcion = "refrescar";

					$.ajax({
						url : "SlRespuestaCatalogo",
						type : "post",
						datatype : 'html',
						data : {
							'opcion' : opcion
						},
						success : function(data) {
							$('#datatable-1').html(data);
							$('#datatable-1').dataTable().fnDestroy();
							AllTables();
							$('#datatable-1').addClass("table table-hover table-heading table-datatable");
						}

					});

				}
				

				//MÃ‰TODO PARA GUARDAR EL REGISTRO A TRAVÃ‰S DEL SERVLET
				function guardarRespuestaCatalogo() {
					var fdescripcion = "";
					var ftitulopreguntaid = "";
					var fclasificacion = "";
					var opcion = "";

					opcion = "guardar";
					fdescripcion = $("#respuestacatalogo").val();
					ftitulopreguntaid = $("#titulopreguntaid").val();
                    fclasificacion = $("#clasificacion").val();
                    
					$.ajax({
						url : "SlRespuestaCatalogo",
						type : "post",
						datatype : 'html',
						data : {
							'fdescripcion' : fdescripcion,
							'ftitulopreguntaid' : ftitulopreguntaid,
							'fclasificacion' : fclasificacion,
							'opcion' : opcion
							
						},
						success : function(data) {
							$("#respuestacatalogo").val(null);	
							$("#titulopregunta").val(null);
							$("#clasificacion").val(null);
							$('#frm-agrega ').fadeOut();
							websocket.send("Guardar");
							successAlert('Listo', 'Guardado exitosamente');
							
						}

					});

				}
				
				//MÃ‰TODO PARA ELIMINAR EL REGISTRO A TRAVÃ‰S DEL SERVLET
				function eliminarRespuestaCatalogo(idClicked) {
					var opcion = "";
					var fRespuestaCatalogoID = idClicked;
					opcion = "eliminar";

					$.ajax({
						url : "SlRespuestaCatalogo",
						type : "post",
						datatype : 'html',
						data : {
							'opcion' : opcion,
							'fRespuestaCatalogoID' : fRespuestaCatalogoID
						},
						success : function(data) {
							websocket.send("Eliminar");
							successAlert('Listo', 'Eliminado exitosamente');

						}

					});

				}
				
				//MÃ‰TODO PARA ACTUALIZAR EL REGISTRO A TRAVÃ‰S DEL SERVLET
				function actualizarRespuestaCatalogo(idClicked) {
					var opcion = "";
					var fRespuestaCatalogoID = idClicked;
					var ftitulopreguntaEditar = "";
					var fclasificacionEditar = "";
					var fdescripcionEditar = "";

					opcion = "actualizar";
					fdescripcionEditar = $("#descripcionEditar").val();
					ftitulopreguntaEditar = $("#titulopreguntaEditar").val();
					fclasificacionEditar = $("#clasificacionEditar").val();
					
					$.ajax({
						url : "SlRespuestaCatalogo",
						type : "post",
						datatype : 'html',
						data : {
							'fRespuestaCatalogoID' : fRespuestaCatalogoID,
							'fdescripcionEditar' : fdescripcionEditar,
							'fclasificacionEditar' : fclasificacionEditar,
							'opcion' : opcion,
							'ftitulopreguntaEditar' : ftitulopreguntaEditar
						},
						success : function(data) {
							$("#descripcionEditar").val(null);
							$("#titulopreguntaEditar").val(null);
							$("#clasificacionEditar").val(null);
							$('#frm-edita').fadeOut();
							websocket.send("Modificar");
							successAlert('Listo', 'Actualizado exitosamente');
							
						}

					});
				}
				
				//MÃ‰TODO PARA CARGAR DATOS EN EL FORMULARIO
				function cargarDatos(respuestaCatalogoID, titulopreguntaid, respuestadesc, clasificacionID) {
					var frespuestaCatalogoID = respuestaCatalogoID;
					var ftitulopreguntaid= titulopreguntaid;
					var frespuestadesc = respuestadesc;
					var fclasificacionID = clasificacionID;

					$('#btnEditar').val(frespuestaCatalogoID);
					$('#descripcionEditar').val(frespuestadesc);
					$('#titulopreguntaEditar').val(ftitulopreguntaid).change();
					$('#clasificacionEditar').val(fclasificacionID).change();
					
					$('#frm-edita').fadeIn();
					$('#frm-agrega').fadeOut();
				}
				
			
				
/////////////////////////////DATATABLES PLUGIN CON 3 VARIANTES DE CONFIGURACIONES/////////////////////////////
				function AllTables() {
					TestTable1();
					TestTable2();
					TestTable3();
					LoadSelect2Script(MakeSelect2);
				}
				/////////////////////////////CONTROLAR LA BUSQUEDA EN LA TABLA CARGADA/////////////////////////////
				function MakeSelect2() {
					$('select').select2();
					$('.dataTables_filter').each(
							function() {
								$(this).find('label input[type=text]').attr('placeholder',
										'Buscar');
							});
				}
				
				function Selects(){
					$('#titulopreguntaid').select({placeholder : "Seleccione un titulo "});
					$('#titulopreguntaidEditar').select({placeholder : "Seleccione un titulo "});
				}

				$(document).ready(function() {

					$('#frm-agrega').hide();
					$('#frm-edita').hide();
					/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
					LoadDataTablesScripts(AllTables);
					/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
					$('.form-control').tooltip();
					/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
					$('#btn-agrega-abrir').click(function() {
						$('#frm-agrega').fadeIn();
					});
					$('#cancelar_nuevo').click(function() {
						$('#frm-agrega').fadeOut();
					});
					$('#cancelar_nuevo_editar').click(function() {
						$('#frm-edita').fadeOut();
					});
					/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
					WinMove();
				});
				
				</Script>
