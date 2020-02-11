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
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Seguridad y mantenimiento</a></li>
			<li><a href="#">Catálogos</a></li>
			<li><a href="#">Psicólogo</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
	
	<!--  INCICIO DE FORMULARIO PARA AGREGAR UN PSICOLOGO -->
	
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Agregar Psicologo</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<div class="row">
				 	<form id="agreg" class="form-horizontal" method="post"
						action="javascript:void(0);" onsubmit="guardar();">
						  <div class="col-sm-6"> 
							<h5 class="page-header">Datos</h5>
							<div class="form-group">
								<label class="col-sm-6 control-label">Carnet:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. 000012587" data-toggle="tooltip"
										data-placement="bottom" id="Carnet"
										name="Carnet" title="El número de carnet es requerido"
										 required/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Primer nombre:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Carlos" data-toggle="tooltip"
										data-placement="bottom" id="Nombre1"
										name="username" title="El primer nombre es requerido"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Segundo nombre:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Daniel" data-toggle="tooltip"
										data-placement="bottom" id="Nombre2"
										name="Nombre2" title="El segundo nombre no es requerido"
										 />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Primer apellido:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Robles" data-toggle="tooltip"
										data-placement="bottom" id="Apellido1"
										name="Apellido1" title="El primer apellido es requerido"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Segundo apellido:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Vivas" data-toggle="tooltip"
										data-placement="bottom" id="Apellido2"
										name="Apellido2" title="El segundo apellido no es requerido"
										 />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Nombre del Tutor:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Profesor Mario" data-toggle="tooltip"
										data-placement="bottom" id="Tutor"
										name="Tutor" title="El Tutor es requerido"
										required />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-6 control-label">Seleccione un usuario</label>
								<div class="col-sm-6">
									<select name="country" id="usuarioId" required>
									<option value=""> Selecciona el usuario </option>
									<%
										DtVUsuarioUnico dtu = new DtVUsuarioUnico();
										ResultSet ru = dtu.cargarVista();
										ru.beforeFirst();
										while (ru.next()){
									
									
									%>
									<option value="<%=ru.getInt("UsuarioID")%>"><%=ru.getString("Usuario")%></option>
									<%
										}
									%>
									</select>
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
								<!-- 									<button class="ajax-link action" onClick="guardarParentesco();" title="Guardar"> -->
								<!-- 										Guardar -->
								<!-- 									</button> -->
								<button class="ajax-link action btn btn-primary btn-label-left" onClick=""
									title="Guardar">
									<span><i class="fa fa-check-circle txt-success"></i></span>Guardar
									</button>
							</div>
						</div>
						</div>
    					</form>
				</div>
			</div>
		</div>
	</div>
</div> 

<!-- FIN DE FORMULARIO PARA GUARDAR UN PSICOLGO-->


<!--INICIO DE FORMULARIO PARA EDITAR  UN PSICOLOGO -->
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Editar Psicologo</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<div class="row">
					<form id="edit" class="form-horizontal" method="post"
						action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
						<div class="col-sm-6">
							<h5 class="page-header">Datos</h5>
							<div class="form-group">
								<label class="col-sm-6 control-label">Carnet:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. 000012587" data-toggle="tooltip"
										data-placement="bottom" id="CarnetEditar"
										name="carnet" title="El número de carnet es requerido"
										 />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Primer nombre:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Carlos" data-toggle="tooltip"
										data-placement="bottom" id="Nombre1Editar"
										name="nombre1" title="El primer nombre es requerido"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Segundo nombre:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Daniel" data-toggle="tooltip"
										data-placement="bottom" id="Nombre2Editar"
										name="nombre2" title="El segundo nombre no es requerido"
										 />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Primer apellido:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Robles" data-toggle="tooltip"
										data-placement="bottom" id="Apellido1Editar"
										name="apellido1" title="El primer apellido es requerido"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Segundo apellido:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Vivas" data-toggle="tooltip"
										data-placement="bottom" id="Apellido2Editar"
										name="apellido2" title="El segundo apellido no es requerido"
										 />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Nombre del Tutor:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Profesor Mario" data-toggle="tooltip"
										data-placement="bottom" id="TutorEditar"
										name="Tutor" title="El Tutor es requerido"
										required />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-6 control-label">Seleccione un usuario</label>
								<div class="col-sm-6">
									<select name="country" id="usuarioIdEditar" disabled>
									<option value=""> Selecciona el usuario </option>
									<%
										DtUsuario dtus = new DtUsuario();
										ResultSet rsu = dtus.cargarDatos();
										rsu.beforeFirst();
										while (rsu.next()){
									
									
									%>
									<option value="<%=rsu.getInt("UsuarioID")%>"><%=rsu.getString("Usuario")%></option>
									<%
										}
									%>
									</select>
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
									onClick="" title="Editar">
									<span><i class="fa fa-check-circle txt-success"></i></span>
									Editar
									</button>
							</div>
						</div>
						</div>
					</form>  
				</div>
			</div>
		</div>
	


<!--FIN DE FORMULARIO PARA EDITAR  UN PSICOLOGO -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> 
					<span>Lista de Psicologos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
			<div class="row padding-opc">
					<div class="col-md-12">					
						<div class="col-md-12 col-xs-12 col-sm-12 agregar">
						<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#" title="Nuevo Registro">
							<i class="fa fa-plus-circle fa-2x"></i>
						</a>
					</div>
						
					</div>
				</div>
				<table class="table table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Carnet</th>
							<th>Nombre completo</th>
							<th>Tutor</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
					
					<%
					
						DTPsicologo dtps = new DTPsicologo();
						rs = dtps.cargarDatos();
						rs.beforeFirst();
				        while(rs.next()){
					%>
					
					<tr>
						<td><%=rs.getString("Carnet") %></td>
						<td><%=rs.getString("Nombre1")+" "+rs.getString("Nombre2")+" "+rs.getString("Apellido1")+" "+rs.getString("Apellido2")%></td>
                        <td><%=rs.getString("Tutor") %></td>
                        <td><button id="btnIdEliminar"
									value=<%=rs.getInt("PsicologoID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick='eliminar(this.value);'><span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar</button>
								<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getString("Carnet")%>', '<%=rs.getString("Nombre1")%>', '<%=rs.getString("Nombre2")%>', '<%=rs.getString("Apellido1")%>', '<%=rs.getString("Apellido2")%>', '<%=rs.getString("Tutor") %>','<%=rs.getInt("UsuarioID")%>');"
									value=<%=rs.getInt("PsicologoID")%> class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span>
									Actualizar</button>
						</td>
					</tr>
					
					<% } %>
					
					</tbody>
					<tfoot>
						<tr>
							<th>Carnet</th>
							<th>Nombre completo</th>
						    <th>Tutor</th>
							<th>Acciones</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

/////////////////////////////FUNCIONES DEL WEBSOCKET/////////////////////////////
var wsUri = "ws://localhost:8080/IGMAB/serverendpointigmab";
var websocket = new WebSocket(wsUri); //creamos el socket

websocket.onopen = function(evt) { //manejamos los eventos...
	console.log("Conectado...");
};

websocket.onmessage = function(evt) { // cuando se recibe un mensaje
	//alert("Hubo cambio en la base de datos. Actualiza la página para verlos");
	//log("Mensaje recibido:" + evt.data);
	refrescar();

};

websocket.onerror = function(evt) {
	console.log("oho!.. error:" + evt.data);
};


//	MEtodo para ejecutar el websocket. onmessage y guardar
function guardar() {
  	guardarPsicologo();

}
//Metodo para ejecutar el WEBSOCKET ; ON MESSGE Y ACTUALIZAR
function actualizar(idClicked){

	actualizarPsicologo(idClicked);
	
}

//		METODO PARA EJECUTAR EL WREBSOCKET. ON MESSAGE Y ELEIMINAR

function eliminar(idClicked){
	confirm(function(){
		 			eliminarPsicologo(idClicked);
		 		  }, function(){
		 			  infoAlert('Aviso', 'Eliminación cancelada');
		 		  });
	
	//refrescar();
	//websocket.send("Eliminar");
}


//METODO PARA REFRESCAR EL DATATABLE A TRAVËS DEL SERVLET
function refrescar() {
	var opcion = "";
	opcion = "refrescar";
	//var table = $('#datatable-1').DataTable();

	$.ajax({
		url : "SLPsicologo",
		type : "post",
		datatype : 'html',
	    data: {
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

//Método para guardar el psicologo a través del servlet
function guardarPsicologo() {
	var fNombre1 = ""
	var fNombre2 = ""
	var fApellido1 = ""
	var fApellido2 = ""
	var fCarnet="";
	var fTutor="";
    var opcion = "";
    var fUsuarioId=0;
    
    opcion = "guardar";
	fNombre1 = $("#Nombre1").val();
	fNombre2 = $("#Nombre2").val();
	fApellido1 = $("#Apellido1").val();
	fApellido2 = $("#Apellido2").val();
	fCarnet= $("#Carnet").val();
	fTutor= $("#Tutor").val();
	fUsuarioId =$("#usuarioId").val();
	
	$.ajax({
		url : "SLPsicologo",
		type : "post",
		datatype : 'html',
		data : {
			'fNombre1' : fNombre1,
			'fNombre2' : fNombre2,
			'fApellido1' : fApellido1,
			'fApellido2' : fApellido2,
			'fCarnet' : fCarnet,
			'fTutor': fTutor,
			'fUsuarioId':fUsuarioId,
			 'opcion' : opcion
		},
		success : function(data) {
			if(data=="1") {
				errorAlert("El carnet ya existe");
			}
			else {
			$('#Nombre1').val(null);
			$('#Nombre2').val(null);
			$('#Apellido1').val(null);
			$('#Apellido2').val(null);
			$('#Carnet').val(null);
			$('#Tutor').val(null);
			$('#usuarioId').val(null);
			 websocket.send("Guardar");
			  successAlert('Listo', 'Guardado exitosamente');
				
			}
			//alert("Guardado");
	
		}

	});

}


//METODO para eliminar el Registro a través del sevlet
function eliminarPsicologo(idClicked){
	var opcion = "";
	var fPsicologoID = idClicked;
	opcion = "eliminar";
	
	$.ajax({
	  url : "SLPsicologo",
	  type: "post",
	  datatype : 'html',
	  data : {
		  'opcion': opcion,
	      'fPsicologoID': fPsicologoID
	  },
	  success : function(data) {
		  websocket.send("Eliminar");
		  successAlert('Listo', 'Eliminado exitosamente')
	  }
		
	});	
}


//METODO PARA ACTUALIZAR EL REGISTRO
function actualizarPsicologo(idClicked){
	
	var opcion= "";
	var fPsicologoID = idClicked;
	var fNombre1Editar="";
	var fNombre2Editar="";
	var fApellido1Editar="";
	var fApellido2Editar="";
	var fCarnetEditar="";
	var fTutorEditar="";
	var fUsuarioIdEditar="";
	
	opcion = "actualizar";
	fNombre1Editar = $("#Nombre1Editar").val();
	fNombre2Editar = $("#Nombre2Editar").val();
	fApellido1Editar = $("#Apellido1Editar").val();
	fApellido2Editar = $("#Apellido2Editar").val();
	fCarnetEditar = $("#CarnetEditar").val();
	fTutorEditar = $("#TutorEditar").val();
	fUsuarioIdEditar = $("#usuarioIdEditar").val();
	
	$.ajax({
		url: "SLPsicologo",
		type: "post",
		datatype : 'html',
		data: {
			'fPsicologoID' : fPsicologoID,
			'fNombre1Editar' : fNombre1Editar,
			'fNombre2Editar' : fNombre2Editar,
			'fApellido1Editar' : fApellido1Editar,
			'fApellido2Editar' : fApellido2Editar,
			'fCarnetEditar' : fCarnetEditar,
			'fTutorEditar' : fTutorEditar,
			'fUsuarioIdEditar' : fUsuarioIdEditar,
			'opcion' : opcion
		},
		success : function(data){
			if(data=="1") {
				errorAlert("El carnet ya existe");
			}
			else
			{
			$('#Nombre1Editar').val(null);
			$('#Nombre2Editar').val(null);
			$('#Apellido1Editar').val(null);
			$('#Apellido2Editar').val(null);
			$('#CarnetEditar').val(null);
			$('#TutorEditar').val(null);
			$("#psicologoEditar").val(null);
			$("#usuarioIdEditar").val(null)
			websocket.send("Modificar");
			 successAlert('Listo', 'Actualizado exitosamente');
			$('#frm-edita').fadeOut();
				
			}
			
		
		}
				
	});
	
}


//	LIMPIAR EL EDITAR Y ADEMAS OCuLTA
function limpiaOculta(){
	$('#Nombre1Editar').val(null);
	$('#Nombre2Editar').val(null);
	$('#Apellido1Editar').val(null);
	$('#Apellido2Editar').val(null);
	$('#CarnetEditar').val(null);
	$('#TutorEditar').val(null);
	$('#usuarioIdEditar').val(null);
	$("#psicologoEditar").val(null);
	$('#frm-edita').fadeOut();
	console.log("YA PASO");
	alert('Limpiado exitoso')
}

// METODO PARA CARGAR DATOS EN EL FORMULARIO
function cargarDatos(psicologoid, carnet, nombre1, nombre2, apellido1,  apellido2, tutor, usuarioId){
  var fNombre1 = nombre1;
  var fNombre2 = nombre2;
  var fApellido1 = apellido1;
  var fApellido2 = apellido2;
  var fCarnet = carnet;
  var fPsicologoID = psicologoid;
  var ftutor = tutor;
  var fUsuarioId =usuarioId;
  
  
  $('#btnEditar').val(fPsicologoID);
  $('#CarnetEditar').val(fCarnet);
  $('#Nombre1Editar').val(fNombre1);
  $('#Nombre2Editar').val(fNombre2);
  $('#Apellido1Editar').val(fApellido1);
  $('#Apellido2Editar').val(fApellido2);
  $('#TutorEditar').val(ftutor);
  $('#usuarioIdEditar').val(fUsuarioId).change();
  $('#frm-edita').fadeIn();
  $('#frm-agrega').fadeOut();
  
}


/////////////////////////////DATATABLES PLUGIN CON 3 VARIANTES DE CONFIGURACIONES/////////////////////////////
	function AllTables() 
	{
		TestTable1();
		TestTable2();
		TestTable3();
		LoadSelect2Script(MakeSelect2);
	}
/////////////////////////////CONTROLAR LA BUSQUEDA EN LA TABLA CARGADA/////////////////////////////
 	function MakeSelect2() 
 	{
 		$('select').select2();
 		$('.dataTables_filter').each(
 			function()
 			{
 				$(this).find('label input[type=text]').attr('placeholder','Buscar');
 			});
 	}
/////////////////////////////CONTROLAR EL EVENTO FADEIN DE LA VENTANA EDITAR/////////////////////////////
 	function editOrDeleteCustomer(event) 
 	{
 	    var link = jQuery(event.currentTarget);
 	    var url = link.attr('href');
 	    jQuery.get(url, function(data) {
 	       $('#frm-edita').fadeIn();
 	    });
 	}
// Add Drag-n-Drop feature
	$(document).ready(function() {
	   // cambiarID();
	    $('#Carnet').mask("999999999");
	    $('#CarnetEditar').mask("999999999");
		
		
		$('#frm-edita').hide();
		$('#frm-agrega').hide();
		// Initialize datepicker
		$('#input_date').datepicker({setDate: new Date()});
/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);
/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
        	$('#frm-agrega').fadeIn();
        	$('#frm-edita').fadeOut();
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
</script>
