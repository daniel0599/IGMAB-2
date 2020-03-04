 <%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
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

	System.out.println("EL ID DE USUARIO ES: " + us.getUsuarioID());

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
		response.sendRedirect("Home.jsp");
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
			<li><a href="#">Gestión consulta</a></li>
		</ol>
	</div>
</div>

<!-- INICIO DE FORMULARIO PARA GUARDAR CONSULTA -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Consulta</span>
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
				<h4 class="page-header">Nueva Consulta</h4>
				<form class="form-horizontal" role="form"
					action="javascript:void(0);" onsubmit="guardar();"
					id="formulario-agrega">
					<div class="form-group">
						<label class="col-sm-2 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select class="populate placeholder" id="pacienteId" required>

								<option value="0">Seleccione un paciente</option>

								<%
									DtConsulta dtcon = new DtConsulta();
									DtPaciente dtpa = new DtPaciente();
								    if(r.getRolId() == 3){
								    	rs = dtpa.cargarPacientesAPsicologosConsulta(dtcon.obtenerPsicologoID(us.getUsuarioID()));
								    }else{
								    	rs = dtpa.cargarDatos();
								    }
								     
									
									rs.beforeFirst();
									while (rs.next()) {
								%>
								<option value="<%=rs.getInt("PacienteID")%>"><%=rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " " + rs.getString("Apellido1")
						+ " " + rs.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>

						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" id="psicoIdLabel">Seleccione
								un psicólogo</label>
							<div class="col-sm-5" id="psicoIdGroup">
								<select class="populate placeholder" id="psicologoId" required>

									<option value="0">Seleccione un psicologo</option>

									<%
										DTPsicologo dtpi = new DTPsicologo();
										ResultSet rp = dtpi.cargarDatos();
										rp.beforeFirst();

										while (rp.next()) {
									%>
									<option value="<%=rp.getInt("PsicologoID")%>"><%=rp.getString("Nombre1") + " " + rp.getString("Nombre2") + " " + rp.getString("Apellido1")
						+ " " + rp.getString("Apellido2")%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Fecha </label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="fecha" name="fecha" autocomplete="on"
										placeholder="Fecha" title="Campo requerido" disabled>
									<span class="form-control-feedback"></span>
								</div>
								<div class="clearfix"></div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="form-styles">Objetivo
										de la sesión </label>
									<div class="col-sm-8">
										<textarea maxlength="500" class="form-control" id="objetivo"
											rows="5" lang="es" spellcheck="true"></textarea>
										<small id="objetivorev_char_count"></small>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Actividades </label>
									<div class="col-sm-8">
										<textarea maxlength="500" class="form-control" id="actividad"
											rows="5" lang="es" spellcheck="true"></textarea>
										<small id="actividadrev_char_count"></small>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Descripción </label>
									<div class="col-sm-8">
										<textarea maxlength="2500" class="form-control"
											id="descripcion" rows="5" lang="es" spellcheck="true"></textarea>
										<small id="descripcionrev_char_count"></small>
									</div>
								</div>




							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-2">
									<button id="cancelar_nuevo" type="reset"
										class="ajax-link action btn btn-default btn-label-left">
										<span><i class="fa fa-minus-circle txt-danger"></i></span>
										Cancelar
									</button>
								</div>
								<div class="col-sm-2">
									<button class="ajax-link action btn btn-primary btn-label-left"
										onClick="" title="Guardar">
										<span><i class="fa fa-check-circle txt-success"></i></span>
										Guardar
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- FIN DE FORMULARIO PARA AGREGAR CONSULTA -->


<!-- INICIO DE FORMULARIO PARA EDITAR CONSULTA  -->

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Consulta</span>
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
				<h4 class="page-header">Editar Consulta</h4>
				<form class="form-horizontal" role="form"
					action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());"
					id="formulario-agrega">
					<div class="form-group">
						<label class="col-sm-2 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select class="populate placeholder" id="pacienteIdEditar" required>

								<option value="0">Seleccione un paciente</option>

								<%
									
									if(r.getRolId() == 3){
								    	rs = dtpa.cargarPacientesAPsicologosConsulta(dtcon.obtenerPsicologoID(us.getUsuarioID()));
								    }else{
								    	rs = dtpa.cargarDatos();
								    }
								     
									
								
									rs.beforeFirst();

									while (rs.next()) {
								%>
								<option value="<%=rs.getInt("PacienteID")%>"><%=rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " " + rs.getString("Apellido1")
						+ " " + rs.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>

						<div class="clearfix"></div>
						<div class="form-group">

							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Fecha </label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="fechaEditar" name="fecha"
										placeholder="Fecha" title="Campo requerido" disabled>
									<span class="form-control-feedback"></span>
								</div>
								<div class="clearfix"></div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="form-styles">Objetivo
										de la sesión </label>
									<div class="col-sm-8">
										<textarea maxlength="500" class="form-control" id="objetivoEditar"
											rows="5" lang="es" spellcheck="true"></textarea>
										<small id="objetivorev_char_count"></small>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Actividades </label>
									<div class="col-sm-8">
										<textarea maxlength="500" class="form-control" id="actividadEditar"
											rows="5" lang="es" spellcheck="true"></textarea>
										<small id="actividadrev_char_count"></small>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Descripción </label>
									<div class="col-sm-8">
										<textarea maxlength="2500" class="form-control"
											id="descripcionEditar" rows="5" lang="es" spellcheck="true"></textarea>
										<small id="descripcionrev_char_count"></small>
									</div>
								</div>




							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-2">
									<button id="cancelar_nuevo_edit" type="reset"
										class="ajax-link action btn btn-default btn-label-left">
										<span><i class="fa fa-minus-circle txt-danger"></i></span>
										Cancelar
									</button>
								</div>
								<div class="col-sm-2">
									<button class="ajax-link action btn btn-primary btn-label-left"
										onClick="" title="Editar" id="btnEditar">
										<span><i class="fa fa-check-circle txt-success"></i></span>
										Editar
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- FIN DE FORMULARIO PARA EDITAR CONSULTA  -->

<!-- INICIO DE FORMULARIO PARA VISUALIZAR CONSULTA  -->

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-visualizar" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-eye"></i> <span>Consulta</span>
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
				<h4 class="page-header">Visualizar consulta</h4>
				<form class="form-horizontal" role="form"
					action="javascript:void(0);" onsubmit="">
					<div class="form-group">
						<label class="col-sm-2 control-label">Paciente</label>
						<div class="col-sm-5">
							<select class="populate placeholder" id="pacienteIdVisualizar"
								disabled>

								<option value="">-- Seleccione un paciente --</option>

								<%
									
								if(r.getRolId() == 3){
							    	rs = dtpa.cargarPacientesAPsicologosConsulta(dtcon.obtenerPsicologoID(us.getUsuarioID()));
							    }else{
							    	rs = dtpa.cargarDatos();
							    }
							     
								
								rs.beforeFirst();

									while (rs.next()) {
								%>
								<option value="<%=rs.getInt("PacienteID")%>"><%=rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " " + rs.getString("Apellido1")
						+ " " + rs.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>

						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Psicólogo</label>
							<div class="col-sm-5">
								<select class="populate placeholder" id="psicologoIdVisualizar"
									disabled>
									<option value="">-- Seleccione un psicólogo --</option>

									<%
										rp.beforeFirst();

										while (rp.next()) {
									%>
									<option value="<%=rp.getInt("PsicologoID")%>"><%=rp.getString("Nombre1") + " " + rp.getString("Nombre2") + " " + rp.getString("Apellido1")
						+ " " + rp.getString("Apellido2")%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Fecha </label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="fechaVisualizar"
										name="fechaVisualizar" placeholder="Fecha" disabled
										title="Campo requerido" > <span
										class="form-control-feedback"></span>
								</div>
								<div class="clearfix"></div>

								<div class="form-group">
									<label class="col-sm-2 control-label" for="form-styles">Objetivo
										de la sesión </label>
									<div class="col-sm-8">
										<textarea class="form-control" id="objetivoVisualizar"
											rows="5" disabled></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Actividades </label>
									<div class="col-sm-8">
										<textarea maxlength="500" class="form-control"
											id="actividadVisualizar" rows="5" disabled></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label"
										class="populate placeholder">Descripción </label>
									<div class="col-sm-8">
										<textarea class="form-control" id="descripcionVisualizar"
											rows="5" disabled></textarea>
									</div>
								</div>




							</div>
							<div class="clearfix"></div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-2">
									<button id="cerrar_visualizar" type="reset"
										class="ajax-link action btn btn-default btn-label-left">
										<span><i class="fa fa-check txt-success"></i></span> Cerrar
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- FIN DE FORMULARIO PARA VISUALIZAR CONSULTA -->



<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
						consultas</span>
				</div>

				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
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


				<table class="table table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Paciente</th>
							<th>Psicólogo</th>
							<th>Fecha</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
							//DtConsulta dtcon = new DtConsulta();
							DtVconsulta dtvc = new DtVconsulta();
							ResultSet resultset = null;
							if (r.getRolId() == 3) { //Carga TODOS los registros para Administrador y Directora
								resultset = dtvc.cargarVistaSoloPsicologo(dtcon.obtenerPsicologoID(us.getUsuarioID()));
								
							} else  { //Carga únicamente los registros relacionados un psicólogo
								resultset = dtvc.cargarVista();
							
							}
							resultset.beforeFirst();
							
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
							SimpleDateFormat fechaM = new SimpleDateFormat("dd-MM-yyyy");

							while (resultset.next()) {
						%>

						<tr>
							<td><%=resultset.getString("Nombre1pa")%> <%=resultset.getString("Nombre2pa")%>
								<%=resultset.getString("Apellido1pa")%> <%=resultset.getString("Apellido2pa")%>
							</td>
							<td><%=resultset.getString("Nombre1psi")%> <%=resultset.getString("Nombre2psi")%>
								<%=resultset.getString("Apellido1psi")%> <%=resultset.getString("Apellido2psi")%>
							</td>

							<td><%=resultset.getString("Fecha")%></td>
							<td>
							
							<% Date fecha = formatter.parse(resultset.getString("Fecha")); %>

								<button id='btnIdVisualizar'
									value=<%=resultset.getInt("ConsultaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									OnClick="visualizarDatos(this.value, 
										'<%=resultset.getInt("PacienteID")%>',
										'<%=resultset.getInt("PsicologoID")%>',
										'<%=resultset.getString("Objetivo")%>',
										'<%=resultset.getString("Actividad")%>',
										'<%=resultset.getString("Descripcion")%>',
										'<%=fechaM.format(fecha)%>');"
									value=<%=resultset.getInt("ConsultaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span> Ver consulta
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, 
										'<%=resultset.getInt("PacienteID")%>',
										'<%=resultset.getString("Objetivo")%>',
										'<%=resultset.getString("Actividad")%>',
										'<%=resultset.getString("Descripcion")%>',
										'<%=fechaM.format(fecha)%>');"
									value=<%=resultset.getInt("ConsultaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
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
							<th>Psicólogo</th>
							<th>Fecha</th>
							<th>Acciones</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	// Funciones del Websocket
// 	var wsUri = "ws://localhost:8080/IGMAB/serverendpointigmab";
// 	var websocket = new WebSocket(wsUri); //creamos el socket

// 	websocket.onopen = function(evt) { //manejamos los eventos...
// 		console.log("Conectado...");
// 	};

// 	websocket.onmessage = function(evt) {
// 		refrescar();
// 	};

// 	websocket.onerror = function(evt) {
// 		console.log("oho!.. error:" + evt.data);
// 	};

	// 	Método para ejecutar el websocket.onmessage y guardar
	function guardar() {
		guardarConsulta();

	}

	//Método para ejecutar el websocket.onmessage y actualizar
	function actualizar(idClicked) {
		actualizarConsulta(idClicked);

	}

	//Método para ejecutar el websocket.onmessage y eliminar
	function eliminar(idClicked) {
		confirm(function() {
			eliminarConsulta(idClicked);
		}, function() {
			infoAlert('Aviso', 'Eliminación cancelada');
		});

	}

	//Método para refrescar a través del servlet
	function refrescar() {
		var opcion = "refrescar";

		$.ajax({
			url : "SlConsulta",
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

	//Método para guardar el registro a través del servlet
	function guardarConsulta() {
		var fpacienteId = "";
		var fpsicologoId = "";
		var fcitaId = "";
		var fobjetivo = "";
		var factividad = "";
		var fdescripcion = "";
		var ffecha = "";

		var opcion = "guardar";

		fpacienteId = $("#pacienteId").val();
		fpsicologoId = $("#psicologoId").val();
		fcitaId = $("#citaId").val();
		fobjetivo = $("#objetivo").val();
		factividad = $("#actividad").val();
		fdescripcion = $("#descripcion").val();
		ffecha = $("#fecha").val();

		$.ajax({
			url : "SlConsulta",
			type : "post",
			datatype : 'html',
			data : {
				'fpacienteId' : fpacienteId,
				'fpsicologoId' : fpsicologoId,
				'fcitaId' : fcitaId,
				'fobjetivo' : fobjetivo,
				'factividad' : factividad,
				'fdescripcion' : fdescripcion,
				'ffecha' : ffecha,
				'opcion' : opcion
			},
			success : function(data) {

				$("#pacienteId").val(0).change();
				$("#psicologoId").val(0).change();
				$("#cita").val(null);
				$("#objetivo").val(null);
				$("#actividad").val(null);
				$("#descripcion").val(null);
				refrescar();
				//websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
				$('#frm-agrega').fadeOut();
			}
		});
	}

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarConsulta(idClicked) {
		var opcion = "";
		var fConsultaId = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlConsulta",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fConsultaId' : fConsultaId
			},
			success : function(data) {
				refrescar();
				//websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');

			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarConsulta(idClicked) {
		var opcion = "";
		var fConsultaId = idClicked;
		var fpacienteIdEditar = 0, fpsicologoIdEditar = 0, fcitaIdEditar = 0, fobjetivoEditar = "", factividadEditar = "", fdescripcionEditar = "", ffechaEditar = "", opcion = "guardar";

		opcion = "actualizar";

		fpacienteIdEditar = $("#pacienteIdEditar").val();
		fpsicologoIdEditar = $("#psicologoIdEditar").val();
		//fcitaIdEditar = $("#citaIdEditar").val();
		fobjetivoEditar = $("#objetivoEditar").val();
		factividadEditar = $("#actividadEditar").val();
		fdescripcionEditar = $("#descripcionEditar").val();
		ffechaEditar = $("#fechaEditar").val();

		$.ajax({
			url : "SlConsulta",
			type : "post",
			datatype : 'html',
			data : {
				'fConsultaId' : fConsultaId,
				'fpacienteIdEditar' : fpacienteIdEditar,
				'fpsicologoIdEditar' : fpsicologoIdEditar,
				//'fcitaIdEditar' : fcitaIdEditar,
				'fobjetivoEditar' : fobjetivoEditar,
				'factividadEditar' : factividadEditar,
				'fdescripcionEditar' : fdescripcionEditar,
				'ffechaEditar' : ffechaEditar,
				'opcion' : opcion
			},
			success : function(data) {
				$("#pacienteIdEditar").val(null);
				$("#psicologoIdEditar").val(null);
				//	$("#citaIdEditar").val(null);
				$("#objetivoEditar").val(null);
				$("#actividadEditar").val(null);
				$("#descripcionEditar").val(null);
				$("#fechaEditar").val(null);
				refrescar();
				//websocket.send("Modificar");

				//websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
				$('#frm-edita').fadeOut();
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(consultaId, pacienteId, objetivo, actividad,
			descripcion, fecha) {
		var fConsultaId = consultaId;
		var fpacienteId = pacienteId;
		//var fpsicologoId = psicologoId;
		//var fcitaId = citaId;
		var fobjetivo = objetivo;
		var factividad = actividad;
		var fdescripcion = descripcion;
		var ffecha = fecha;
		//var fhora= hora;

		$('#btnEditar').val(fConsultaId);
		$('#pacienteIdEditar').val(fpacienteId).change();
		//$('#psicologoIdEditar').val(fpsicologoId).change();
		//$('#citaId').val(citaId);
		$('#objetivoEditar').val(fobjetivo);
		$('#actividadEditar').val(factividad);
		$('#descripcionEditar').val(fdescripcion);
		$('#fechaEditar').val(ffecha);
		
		$('#frm-agrega').fadeOut();
		$('#frm-visualizar').fadeOut();
		$('#frm-edita').fadeIn();
	}

	// Formulario para visualizar

	function visualizarDatos(consultaId, pacienteId, psicologoId, objetivo,
			actividad, descripcion, fecha) {

		var fconsultaId = consultaId;
		var fpacienteId = pacienteId;
		var fpsicologoId = psicologoId;
		var fobjetivo = objetivo;
		var factividad = actividad;
		var fdescripcion = descripcion;
		var ffecha = fecha;

		$('#btnIdVisualizar').val(fconsultaId);
		$("#pacienteIdVisualizar").val(fpacienteId).change();
		$("#psicologoIdVisualizar").val(fpsicologoId).change();
		$("#objetivoVisualizar").val(fobjetivo);
		$("#actividadVisualizar").val(factividad);
		$("#descripcionVisualizar").val(fdescripcion);
		$("#fechaVisualizar").val(ffecha);
		
		$('#frm-agrega').fadeOut();
		$('#frm-edita').fadeOut();
		$("#frm-visualizar").fadeIn();
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

	function Selects() {
		$('#pacienteId').select({
			placeholder : "Seleccione un paciente"
		});
		$('#pacienteIdEditar').select({
			placeholder : "Seleccione un paciente"
		});
		$('#psicologoId').select({
			placeholder : "Seleccione un psicólogo"
		});
		$('#psicologoIdEditar').select({
			placeholder : "Seleccione un psicólogo"
		});
	}

	$(document)
			.ready(
					function() {
						//contadores de caracteres
						$('#objetivo')
								.on(
										'input propertychange',
										function() {
											var max_len = 500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$('#objetivorev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});
						$('#objetivoEditar')
								.on(
										'input propertychange',
										function() {
											var max_len = 500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$('#objetivoEditarrev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});

						$('#actividad')
								.on(
										'input propertychange',
										function() {
											var max_len = 500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$('#actividadrev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});
						$('#descripcionEditar')
								.on(
										'input propertychange',
										function() {
											var max_len = 500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$(
													'#descripcionEditarrev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});

						$('#descripcion')
								.on(
										'input propertychange',
										function() {
											var max_len = 2500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$('#descripcionrev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});
						$('#descripcionEditar')
								.on(
										'input propertychange',
										function() {
											var max_len = 2500;
											var len = $(this).val().trim().length;
											len = max_len - len;
											$(
													'#descripcionEditarrev_char_count')
													.text(
															len > 0 ? (len
																	+ ' caracter'
																	+ (len == 1 ? ''
																			: 'es') + ' restantes.')
																	: '');
										});

						$('#frm-agrega').hide();
						$('#frm-edita').hide();
						$('#frm-visualizar').hide();
						// Initialize datepicker
						
						
// 						$(function () {
//                        $.datepicker.setDefaults($.datepicker.regional["es"]);
//                        $("#fecha").datepicker({
//                        dateFormat: 'dd/mm/yy',
//                        firstDay: 1
//                        }).datepicker("setDate", new Date());
//                        });
 						var today = new Date();
						$('#fecha').datepicker({
							dateFormat : "dd-mm-yy"
						}).datepicker("setDate", new Date());
						//$('#fechaEditar').datepicker({dateFormat : "dd-mm-yy"}).datepicker("setDate", "0");
						// Load Timepicker plugin
						// 		LoadTimePickerScript(TimePicker);

						LoadDataTablesScripts(AllTables);
						// Add tooltip to form-controls
						$('.form-control').tooltip();
						// 		LoadSelectScript(Selects);

						// 		// Getter
						// 		var dateFormat = $( "#fecha" ).datepicker( "option", "dateFormat" );
						// 		var dateFormat2 = $( "#fechaEditar" ).datepicker( "option", "dateFormat" );

						// 		// Setter
						// 		$( "#fecha" ).datepicker( "option", "dateFormat", "dd-mm-yyyy" );
						// 		$( "#fechaEditar" ).datepicker( "option", "dateFormat2", "dd-mm-yyyy" );

						// Load TimePicker plugin and callback all time and date pickers
						LoadTimePickerScript(AllTimePickers);
						// Create jQuery-UI tabs
						$("#tabs").tabs();
						// Sortable for elements
						$(".sort").sortable({
							items : "div.col-sm-2",
							appendTo : 'div.box-content'
						});
						// Droppable for example of trash
						$(".drop div.col-sm-2").draggable({
							containment : '.dropbox'
						});
						$('#trash').droppable({
							drop : function(event, ui) {
								$(ui.draggable).remove();
							}
						});
						var icons = {
							header : "ui-icon-circle-arrow-e",
							activeHeader : "ui-icon-circle-arrow-s"
						};
						// Make accordion feature of jQuery-UI
						$("#accordion").accordion({
							icons : icons
						});
						// Create UI spinner
						$("#ui-spinner").spinner();
						// Add Drag-n-Drop to boxes
						//WinMove();

						/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
						$('#btn-agrega-abrir').click(function() {
							$('#frm-agrega').fadeIn();
							$('#frm-edita').fadeOut();
							$('#frm-visualizar').fadeOut();
						});
						$('#cancelar_nuevo').click(function() {
							$('#frm-agrega').fadeOut();
						});
						$('#cancelar_nuevo_edit').click(function() {
							$('#frm-edita').fadeOut();
						});
						$('#cerrar_visualizar').click(function() {
							$('#frm-visualizar').fadeOut();
						});

						/////////////////////////////CONTROLA EL COMBO DE PSICÓLOGO, SE OCULTA AL INICIAR SESIÓN COMO PSICÓLOGO/////////////////////////////
						<%if (r.getRolId() == 3) {%>
							$('#psicoIdGroup').hide();
							$('#psicoIdLabel').hide();
							$('#psicologoId')
								.val(<%=dtcon.obtenerPsicologoID(us.getUsuarioID())%>);
						<%}%>
	// Add drag-n-drop feature to boxes
						WinMove();
					});
</script>