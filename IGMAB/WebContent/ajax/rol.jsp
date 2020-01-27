<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="datos.*"%>
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
			<li><a href="#">Rol</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
	
	<!-- INICIO DE FORMULARIO PARA AGREGAR UN Rol  -->
	
		<div id="frm-agrega" class="box">
			<div class="box-header">
				
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
								<label class="col-sm-6 control-label">Nombre del rol:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										placeholder="Ej. Secretaria, Directora" data-toggle="tooltip"
										data-placement="bottom" id="rolNuevo" name="rol"
										title="El nombre del rol es requerido" required />
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
		
			<!-- FIN DE FORMULARIO PARA AGREGAR UN Rol  -->
			
			
		<!-- INICIO DE FORMULARIO PARA EDITAR UN Rol  -->

		<div id="frm-edita" class="box">
			<div class="box-header">

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
							<label class="col-sm-6 control-label">Tipo de Rol:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control"
									placeholder="Ej. Secretaria, Directora" data-toggle="tooltip"
									data-placement="bottom" id="rolEditar" name="Rol"
									title="El tipo de Rol es requerido" required />
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

		<!-- FIN DE FORMULARIO PARA EDITAR UN Rol  -->
	</div>
</div>



<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> 
					<span>Lista de roles</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar Rol</span>
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
				<table class="table table-hover table-heading table-datatable" id="datatable-1">
					<thead>
						<tr>
							<th>Rol</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
					
					<%
					
						DtRol dtr = new DtRol();
						rs = dtr.cargarDatos();
						rs.beforeFirst();
						while(rs.next())
						{
					%>
					
					<tr>
						<td><%=rs.getString("Nombre") %></td>
						<td><button id="btnIdEliminar"
									value=<%=rs.getInt("RolID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick='eliminar(this.value);'><span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar</button>
								<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getString("Nombre")%>');"
									value=<%=rs.getInt("RolID")%> class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span>
									Actualizar</button>
							</td>
					</tr>
					
					<% } %>
					
					</tbody>
					<tfoot>
						<tr>
							<th>Rol</th>
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

	websocket.onopen = function(evt) 
	{ //manejamos los eventos...
		console.log("Conectado...");
	};

	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
		//alert("Hubo cambio en la base de datos. Actualiza la página para verlos");
    	//log("Mensaje recibido:" + evt.data);
		refrescar();
		
	};

	websocket.onerror = function(evt) 
	{
		console.log("oho!.. error:" + evt.data);
	};
	
	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar()
	{
		guardarRol();
		
	}
	
	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarRol(idClicked);
	}
	
	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarRol(idClicked);
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
	}
	
	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";

		$.ajax({
			url : "SlRol",
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
	
	//MÉTODO PARA GUARDAR EL REGISTRO A TRAVÉS DEL SERVLET
	function guardarRol() {
		var fRol = "";
		var opcion = "";

		opcion = "guardar";
		fRol = $("#rolNuevo").val();

		$.ajax({
			url : "SlRol",
			type : "post",
			datatype : 'html',
			data : {
				'fRol' : fRol,
				'opcion' : opcion
			},
			success : function(data) {
				if(data=="1") {
					errorAlert("El rol ya existe");
				} else {
					$("#rolNuevo").val(null);
					websocket.send("Guardar");
					successAlert('Listo', 'Guardado exitosamente');
				}
			}

		});

	}
	
	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarRol(idClicked) {
		var opcion = "";
		var fIdRol = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlRol",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fIdRol' : fIdRol
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');
			}

		});

	}
	
	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarRol(idClicked) {
		var opcion = "";
		var fRolId = idClicked;
		var fRolEditar = "";

		opcion = "actualizar";
		fRolEditar = $("#rolEditar").val();
		$.ajax({
			url : "SlRol",
			type : "post",
			datatype : 'html',
			data : {
				'fRolId' : fRolId,
				'fNombreEditar' : fRolEditar,
				'opcion' : opcion
			},
			success : function(data) {
				if(data=="1") {
					errorAlert("El rol ya existe");
				}
				else {
					$("#rolEditar").val(null);
					websocket.send("Modificar");
					successAlert('Listo', 'Actualizado exitosamente');
					$('#frm-edita').fadeOut();	
				}
			}

		});
	}
	
	
	
	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(RolID, Rol) {
		var frolId = RolID;
		var frol = Rol;

		$('#btnEditar').val(frolId);
		$('#rolEditar').val(frol);
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
//// 	function editOrDeleteCustomer(event) 
//// 	{
//// 	    var link = jQuery(event.currentTarget);
//// 	    var url = link.attr('href');
//// 	    jQuery.get(url, function(data) {
//// 	       $('#frm-edita').fadeIn();
//// 	    });
//// 	}
//// Add Drag-n-Drop feature


	$(document).ready(function() {
 		$('#frm-agrega').hide();
 		$('#frm-edita').hide();
 		
		// Initialize datepicker
		//$('#input_date').datepicker({setDate: new Date()});
		
		
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