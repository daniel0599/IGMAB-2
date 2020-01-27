<%@page
	import="entidades.*,
	        datos.*, java.util.*, java.sql.*"%>
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
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Gestión paciente</a></li>
			<li><a href="#">Asignar pariente a paciente</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">

		<!--  INCICIO DE FORMULARIO PARA AGREGAR UN PSICOLOGO -->

		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar Pariente
						a paciente</span>
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
						<form id="agregar" class="form-horizontal" method="post" action="javascript:void(0);" onsubmit="guardar();">
					<div class="col-sm-6">
						<h5 class="page-header">Datos</h5>

						<div class="form-group">
							<label class="col-sm-2 control-label">Pariente</label>
							<div class="col-sm-4">
								<select name="pariente" id="pariente" required>
									<option value="">Seleccione</option>
									<%
										DtPariente dtpar = new DtPariente();
										rs = dtpar.cargarDatos();
										rs.beforeFirst();
										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("ParienteID")%>"><%=rs.getString("Nombre1")%>
										<%=rs.getString("Apellido1")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Paciente</label>
							<div class="col-sm-4">
								<select name="paciente" id="paciente" required>
									<option value="">Seleccione</option>
									<%
										DtPaciente dtpac = new DtPaciente();
										ResultSet rsp = dtpac.cargarDatos();
										rsp.beforeFirst();
										while (rsp.next()) {
									%>
									<option value="<%=rsp.getInt("PacienteID")%>"><%=rsp.getString("Nombre1")%>
										<%=rsp.getString("Apellido1")%></option>
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
								<button class="ajax-link action btn btn-default btn-label-left"
									type="reset" title="Cancelar">
									<span><i class="fa fa-minus-circle txt-danger"></i></span>
									Cancelar
								</button>
							</div>
							<div class="col-sm-6 text-center">
								<!-- 									<button class="ajax-link action" onClick="guardarParentesco();" title="Guardar"> -->
								<!-- 										Guardar -->
								<!-- 									</button> -->
								<button class="ajax-link action btn btn-primary btn-label-left"
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
			<i class="fa fa-location-arrow"></i> <span>Editar Pariente a
				Paciente</span>
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
			 <form class="form-horizontal" method="post" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
			<div class="col-sm-6">
				<h5 class="page-header">Datos</h5>

				<div class="form-group">
					<label class="col-sm-2 control-label">Pariente</label>
					<div class="col-sm-4">
						<select name="Pariente" id="ParienteEditar" class="form-control">
							<option value="">Seleccione</option>
							<%
								DtPariente dtpare = new DtPariente();
								ResultSet rse = dtpare.cargarDatos();
								rse.beforeFirst();
								while (rse.next()) {
							%>
							<option value="<%=rse.getInt("ParienteID")%>"><%=rse.getString("Nombre1")%><%=rse.getString("Apellido1")%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Paciente</label>
					<div class="col-sm-4">
						<select name="Paciente" id="PacienteEditar" class="form-control">
							<option value="">Seleccione</option>
							<%
								DtPaciente dtpace = new DtPaciente();
								ResultSet rspe = dtpace.cargarDatos();
								rspe.beforeFirst();
								while (rspe.next()) {
							%>
							<option value="<%=rspe.getInt("PacienteID")%>"><%=rspe.getString("Nombre1")%><%=rspe.getString("Apellido1")%></option>
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
						<button class="ajax-link action btn btn-default btn-label-left"
							type="reset" title="Cancelar">
							<span><i class="fa fa-minus-circle txt-danger"></i></span>
							Cancelar
						</button>
					</div>
					<div class="col-sm-6 text-center">
						<!-- 									<button class="ajax-link action" onClick="guardarParentesco();" title="Guardar"> -->
						<!-- 										Guardar -->
						<!-- 									</button> -->
						<button id="btnEditar"
							class="ajax-link btn btn-primary btn-label-left"
							 title="Editar">
							<span><i class="fa fa-check-circle txt-success"></i></span>
							Editar
						</button>
					</div>
				</div>
			</div>
			<!-- 					</form>   -->
		</div>
	</div>
</div>



<!--FIN DE FORMULARIO PARA EDITAR  UN PSICOLOGO -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Lista de
						Parientes de un paciente</span>
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
							<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#"
								title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i>
							</a>
						</div>

					</div>
				</div>
				<table class="table table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Nombre Pariente</th>
							<th>Nombre Paciente</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>

						<%
							DTVParientePaciente dtvpp = new DTVParientePaciente();
							ResultSet rsvv = dtvpp.cargarVista();
							rsvv.beforeFirst();
							while (rsvv.next()) {
						%>
						<tr>
							<td><%=rsvv.getString("Nombre1par") + " " + rsvv.getString("Nombre2par") + " "
						+ rsvv.getString("Apellido1par") + " " + rsvv.getString("Apellido2par")%></td>
							<td><%=rsvv.getString("Nombre1") + " " + rsvv.getString("Nombre2") + " "
						+ rsvv.getString("Apellido1") + " " + rsvv.getString("Apellido2")%></td>
							<td><button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rsvv.getInt("PacienteID")%>', '<%=rsvv.getInt("ParienteID")%>');"
									value=<%=rsvv.getInt("ParPacID")%>
									class="btn btn-primary btn-label-left">
									<span><i class="fa fa-clock-o"></i></span> Actualizar
								</button></td>
						</tr>
						<%
							}
						%>
					</tbody>
					<tfoot>
						<tr>
							<th>Nombre Pariente</th>
							<th>Nombre Paciente</th>
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
		console.logn("Conectado...");
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

		guardarParientePaciente();

	}

	//Metodo para ejecutar el WEBSOCKET ; ON MESSGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarParientePaciente(idClicked);

		//refrescar();

	}

	//		METODO PARA EJECUTAR EL WREBSOCKET. ON MESSAGE Y ELEIMINAR

	// function eliminar(idClicked){
	// 	eliminarPsicologo(idClicked);
	// 	//refrescar();
	// 	websocket.send("Eliminar");
	// }

	//METODO PARA REFRESCAR EL DATATABLE A TRAVËS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";
		//var table = $('#datatable-1').DataTable();

		$.ajax({
			url : "SLParientePaciente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion
			},
			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				AllTables();
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
			}

		});

	}

	//Método para guardar el psicologo a través del servlet
	function guardarParientePaciente() {
		var fParienteID = ""
		var fPacienteID = ""

		opcion = "guardar";
		fParienteID = $("#pariente").val();
		fPacienteID = $("#paciente").val();

		$.ajax({
			url : "SLParientePaciente",
			type : "post",
			datatype : 'html',
			data : {
				'fParienteID' : fParienteID,
				'fPacienteID' : fPacienteID,

				'opcion' : opcion
			},
			success : function(data) {
				$('#pariente').val(null);
				$('#paciente').val(null);

				websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
				$("#agregar")[0].reset();
				$('#frm-agrega').fadeOut();
			}

		});

	}

	//METODO para eliminar el Registro a través del sevlet
	// function eliminarPsicologo(idClicked){
	// 	var opcion = "";
	// 	var fPsicologoID = idClicked;
	// 	opcion = "eliminar";

	// 	$.ajax({
	// 	  url : "SLParientePaciente",
	// 	  type: "post",
	// 	  datatype : 'html',
	// 	  data : {
	// 		  'opcion': opcion,
	// 	      'fPsicologoID': fPsicologoID
	// 	  },
	// 	  succes : function(data) {
	// 		  alert('Eliminado exitosamente');
	// 	  }

	// 	});	
	// }

	//METODO PARA ACTUALIZAR EL REGISTRO
	function actualizarParientePaciente(idClicked) {

		//alert('Actualizado exitoso')
		var opcion = "";
		var fparienteEditar = "";
		var fpacienteEditar = "";

		opcion = "actualizar";
		fparienteEditar = $("#ParienteEditar").val();
		fpacienteEditar = $("#PacienteEditar").val();

		$.ajax({
			url : "SLParientePaciente",
			type : "post",
			datatype : 'html',
			data : {
				'fparienteEditar' : fparienteEditar,
				'fpacienteEditar' : fpacienteEditar,
				'opcion' : opcion
			},
			succes : function(data) {
				$('#ParienteEditar').val(null);
				$('#PacienteEditar').val(null);
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
				$('#frm-edita').fadeOut();

			}

		});

	}

	//	LIMPIAR EL EDITAR Y ADEMAS OCuLTA
	function limpiaOculta() {
		$('#PacienteEditar').val(null);
		$('#ParienteEditar').val(null);

		$('#frm-edita').fadeOut();
		console.log("YA PASO");
		//alert('Limpiado exitoso')
	}

	// METODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(pacienteID, parienteID, parpacID) {
		var fparpacID = parpacID;
		var fpacienteID = pacienteID;
		var fparienteID = parienteID;

		$('#btnEditar').val(parpacID);
		$('#PacienteEditar').val(fpacienteID);
		$('#ParienteEditar').val(fparienteID);

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
	/////////////////////////////CONTROLAR EL EVENTO FADEIN DE LA VENTANA EDITAR/////////////////////////////
	function editOrDeleteCustomer(event) {
		var link = jQuery(event.currentTarget);
		var url = link.attr('href');
		jQuery.get(url, function(data) {
			$('#frm-edita').fadeIn();
		});
	}
	// Add Drag-n-Drop feature
	$(document).ready(function() {
		// cambiarID();
		//  $('#Carnet').mask("9999999999");
		// $('#CarnetEditar').mask("9999999999");

		$('#frm-edita').hide();
		$('#frm-agrega').hide();
		// Initialize datepicker
		$('#input_date').datepicker({
			setDate : new Date()
		});
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