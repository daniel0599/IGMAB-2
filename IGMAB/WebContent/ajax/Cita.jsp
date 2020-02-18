<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="datos.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="Utf-8"%>
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
			<li><a href="#">Gestión cita</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Registro de cita</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<h4 class="page-header">Formulario de registro</h4>
				<form class="form-horizontal" role="form"
					action="javascript:void(0);" onsubmit="guardar();">
					<div class="form-group">
						<label class="col-sm-2 control-label">Seleccione un
							paciente</label>
						<div class="col-sm-5">
							<!-- 						Combo con buscar -->
							<select class="populate placeholder" id="paciente"
								name="paciente">
								<option value=""> Seleccione paciente </option>
								<%
									DtPaciente dtp = new DtPaciente();
									ResultSet rp = dtp.cargarDatos();
									rp.beforeFirst();

									while (rp.next()) {
								%>

								<option value="<%=rp.getInt("PacienteID")%>"><%=rp.getString("Nombre1") + " " + rp.getString("Nombre2") + " " + rp.getString("Apellido1")
						+ " " + rp.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>

						</div>

					</div>

					<div class="clearfix"></div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Número de Sesión</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" name="numSesion"
								id="numSesion" placeholder="# de Sesión" data-toggle="tooltip"
								data-placement="bottom" title="Campo requerido" required />
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Fecha y hora de la
							Cita</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="fecha" name="fecha" autocomplete="off"
								placeholder="Fecha" title="Campo requerido" required> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>

						<div class="col-sm-2">
							<input type="text" class="form-control" id="hora" name="hora" autocomplete="off"
								placeholder="Hora" title="Campo requerido" required> <span
								class="fa fa-clock-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="clearfix"></div>
					<h5 class="page-header">Acciones</h5>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo"
								class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span>
								Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit"
								class="ajax-link action btn btn-primary btn-label-left"
								onClick="" title="Guardar">
								<span><i class="fa fa-check-circle txt-success"></i></span>
								Guardar
							</button>
						</div>
					</div>
					<div class="clearfix"></div>
				</form>
			</div>
		</div>
	</div>
</div>
		<!-- FIN DE FORMULARIO PARA AGREGAR UNA CITA  -->

		<!-- INICIO DE FORMULARIO PARA EDITAR UNA CITA  -->
       <div class="row">
       <div class="col-xs-12 col-sm-12">
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Editar cita</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<h4 class="page-header">Formulario de registro</h4>
				<form class="form-horizontal" role="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="form-group">
						<label class="col-sm-2 control-label">Seleccione un
							paciente</label>
						<div class="col-sm-5">
							<!-- 						Combo con buscar -->
							<select class="populate placeholder" id="pacienteEditar"
								name="pacienteEditar">
								<option>-- Seleccione un paciente --</option>
								<%
									rp.beforeFirst();

									while (rp.next()) {
								%>

								<option value="<%=rp.getInt("PacienteID")%>"><%=rp.getString("Nombre1") + " " + rp.getString("Nombre2") + " " + rp.getString("Apellido1")
						+ " " + rp.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>

					</div>

					<div class="clearfix"></div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Número de Sesión</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" name="numSesion"
								id="numSesionEditar" placeholder="# de Sesión"
								data-toggle="tooltip" data-placement="bottom"
								title="Campo requerido" required />
						</div>
					</div>

					<div class="clearfix"></div>
					<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Fecha y hora de la
							Cita</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="fechaEditar" autocomplete="off"
								name="fecha" placeholder="Date" title="Campo requerido" required>
							<span class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>

						<div class="col-sm-2">
							<input type="text" class="form-control" id="horaEditar" autocomplete="off"
								name="hora" placeholder="Time" title="Campo requerido" required>
							<span class="fa fa-clock-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="clearfix"></div>
					<h5 class="page-header">Acciones</h5>
					<div class="form-group">
						<div id="cancelar_nuevo_editar" class="col-sm-offset-2 col-sm-2">
							<button class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span>
								Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button id="btnEditar"
								class="ajax-link btn btn-primary btn-label-left"
								onClick="" title="Editar">
								<span><i class="fa fa-check-circle txt-success"></i></span>
								Editar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de Citas</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar Cita</span>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<div class="row padding-opc">
					<div class="col-md-12">
						<div class="col-md-12 col-xs-12 col-sm-12 agregar">
							<div class="col-md-12 text-center">
								<button name="button" class="btn btn-primary" id="todas" onclick="cargarTodas()">Ver todas las citas</button>
								<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#"
								   title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i>
								</a>
							</div>
						</div>

					</div>
				</div>
				<table class="table table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Paciente</th>
							<th>Fecha</th>
							<th>Hora</th>
							<th>Sesión</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>

						<%
							DtVCitaPaciente dtc = new DtVCitaPaciente();
							rs = dtc.cargarVistaHoy();
							rs.beforeFirst();

							while (rs.next()) {
						%>

						<tr>
							<td><%=rs.getString("Nombre1")%> <%=rs.getString("Nombre2")%>
								<%=rs.getString("Apellido1")%> <%=rs.getString("Apellido2")%></td>
							<td><%=rs.getString("Fecha")%></td>
							<td><%=rs.getString("Hora")%></td>
							<td><%=rs.getInt("Numsesion")%></td>
							<td>
								<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getInt("PacienteID")%>', '<%=rs.getString("Fecha")%>', '<%=rs.getString("Hora")%>',
									'<%=rs.getInt("Numsesion")%>');"
									value=<%=rs.getInt("CitaID")%>
									class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span>Actualizar
								</button>
							</td>
						</tr>

						<%
							}
						%>

					</tbody>
					<tfoot>
						<tr>
							<th>Paciente</th>
							<th>Fecha</th>
							<th>Hora</th>
							<th>Sesión</th>
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

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar() {
		guardarCita();
		
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarCita(idClicked);
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		eliminarCita(idClicked);
	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "refrescar";

		$.ajax({
			url : "SlCita",
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

	function guardarCita() {
		var fpacienteId = "", fnumSesion = "", ffecha = "", fhora = "", opcion = "guardar";

		fpacienteId = $("#paciente").val();
		fnumSesion = $("#numSesion").val();
		ffecha = $("#fecha").datepicker({
			dateFormat : 'yy-mm-dd'
		}).val();
		fhora = $("#hora").val();

		$.ajax({
			url : "SlCita",
			type : "post",
			datatype : 'html',
			data : {
				'fpacienteId' : fpacienteId,
				'fnumSesion' : fnumSesion,
				'ffecha' : ffecha,
				'fhora' : fhora,
				'opcion' : opcion
			},
			success : function(data) {
				$("#paciente").val(null);
				$("#fecha").val(null);
				$("#hora").val(null);
				$("#numSesion").val(null);
				websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarCita(idClicked) {
		var opcion = "";
		var fCitaId = idClicked;
		var fpacienteIdEditar = "", fnumSesionEditar = "", ffechaEditar = "", fhoraEditar = "";

		opcion = "actualizar";

		fpacienteIdEditar = $("#pacienteEditar").val();
		fnumSesionEditar = $("#numSesionEditar").val();
		ffechaEditar = $("#fechaEditar").datepicker({
			dateFormat : 'yy-mm-dd'
		}).val();
		fhoraEditar = $("#horaEditar").val();

		$.ajax({
			url : "SlCita",
			type : "post",
			datatype : 'html',
			data : {
				'fCitaId' : fCitaId,
				'fpacienteIdEditar' : fpacienteIdEditar,
				'fnumSesionEditar' : fnumSesionEditar,
				'ffechaEditar' : ffechaEditar,
				'fhoraEditar' : fhoraEditar,
				'opcion' : opcion
			},
			success : function(data) {
				$("#pacienteEditar").val(null);
				$("#numSesionEditar").val(null);
				$("#fechaEditar").val(null);
				$("#horaEditar").val(null);
				$('#frm-edita').fadeOut();
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(citaId, pacienteId, fecha, hora, numSesion) {
		var fCitaId = citaId;
		var fPacienteId = pacienteId;
		var ffecha = fecha;
		var fhora = hora;
		var fNumSesion = numSesion;

		$('#btnEditar').val(fCitaId);
		$('#pacienteEditar').val(fPacienteId).change();
		$('#fechaEditar').val(ffecha);
		$('#horaEditar').val(fhora);
		$('#numSesionEditar').val(fNumSesion);
		$('#frm-edita').fadeIn();
		$('#frm-agrega').fadeOut();
	}

	function cargarTodas() {
        var opcion = "refrescarConTodas";

        $.ajax({
            url : "SlCita",
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
                infoAlert('Aviso', 'Todas las citas cargadas');

            }

        });
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


	// Run timepicker
	function TimePicker() {
		$('#hora').timepicker({
			setDate : new Date()
		});

		$('#horaEditar').timepicker({
			setDate : new Date()
		});
	}

	function Selects() {
		$('#paciente').select({
			placeholder : "Seleccione un paciente"
		});
		$('#pacienteEditar').select({
			placeholder : "Seleccione un paciente"
		});
	}

	
	
	$.datepicker.regional['es'] = {
		closeText : 'Cerrar',
		prevText : '< Ant',
			 nextText: 'Sig >',
		currentText : 'Hoy',
		monthNames : [ 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
				'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre',
				'Diciembre' ],
		monthNamesShort : [ 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul',
				'Ago', 'Sep', 'Oct', 'Nov', 'Dic' ],
		dayNames : [ 'Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves',
				'Viernes', 'Sábado' ],
		dayNamesShort : [ 'Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb' ],
		dayNamesMin : [ 'Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá' ],
		weekHeader : 'Sm',
		firstDay : 1,
		isRTL : false,
		showMonthAfterYear : false,
		yearSuffix : '',
			minDate: "-0d"
	};

	$(document).ready(function() {
		
		$.timepicker.regional['es'] = {
				timeOnlyTitle: 'Elegir una hora',
				timeText: 'Hora',
				hourText: 'Horas',
				minuteText: 'Minutos',
				secondText: 'Segundos',
				millisecText: 'Milisegundos',
				microsecText: 'Microsegundos',
				timezoneText: 'Uso horario',
				currentText: 'Ahora',
				closeText: 'Cerrar',
				timeFormat: 'HH:mm',
				timeSuffix: '',
				amNames: ['a.m.', 'AM', 'A'],
				pmNames: ['p.m.', 'PM', 'P'],
				isRTL: false
			};
		
		$.datepicker.setDefaults($.datepicker.regional['es']);
		
		$.timepicker.setDefaults($.timepicker.regional['es']);
		
		$('#frm-agrega').hide();
		$('#frm-edita').hide();
		// Initialize datepicker
		$('#fecha').datepicker({
			dateFormat : "yy-mm-dd"
		});
		$('#fechaEditar').datepicker({
			dateFormat : "yy-mm-dd"
		});

		LoadTimePickerScript(TimePicker);

		LoadDataTablesScripts(AllTables);
		// Add tooltip to form-controls
		$('.form-control').tooltip();
		// 		LoadSelectScript(Selects);

		// Getter
		var dateFormat = $("#fecha").datepicker("option", "dateFormat");
		var dateFormat2 = $("#fechaEditar").datepicker("option", "dateFormat");

		var changeMonth = $("#fecha").datepicker("option", "changeMonth");
		var changeYear = $("#fecha").datepicker("option", "changeYear");

		var changeMonth = $("#fecha").datepicker("option", "changeMonth");
		var changeYear = $("#fecha").datepicker("option", "changeYear");

		// Setter
		$("#fecha").datepicker("option", "dateFormat", "yy-mm-dd");
		$("#fechaEditar").datepicker("option", "dateFormat2", "yy-mm-dd");

		$("#fecha").datepicker("option", "changeMonth", true);
		$("#fechaEditar").datepicker("option", "changeMonth", true);

		$("#fecha").datepicker("option", "changeYear", true);
		$("#fechaEditar").datepicker("option", "changeYear", true);

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
		// Add drag-n-drop feature to boxes
		WinMove();
	});
</script>