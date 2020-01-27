<%@page import="entidades.*"%>
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
			<li><a href="#">Seguridad y mantenimiento</a></li>
			<li><a href="#">Asignar rol a usuario</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-user"></i> <span>Asignar Rol a Usuario</span>
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
				<div class="row padding-opc">
					<form id="agreg" class="form-horizontal" method="post"
						  action="javascript:void(0);" onsubmit="guardar();">
						<div class="col-sm-6">
							<h5 class="page-header">Datos</h5>
							
							<div class="form-group">
								<label class="col-sm-6 control-label text-rpromedix">Usuario</label>
								<div class="col-sm-6">
									<select id="usuario" name="users" class="populate placeholder"
										required>
										<option>Seleccione</option>
										<%
											DtUsuario dtu = new DtUsuario();
											ResultSet rp = dtu.cargarDatos();
											rp.beforeFirst();

											while (rp.next()) {
										%>
										<option value="<%=rp.getInt("UsuarioID")%>"><%=rp.getString("Usuario")%></option>
										<%
											}
										%>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-6 control-label text-rpromedix">Rol</label>
								<div class="col-sm-6">
									<select id="rol" name="roles" class="populate placeholder"
										required>
										<option>Seleccione</option>
										<%
											DtRol dtr = new DtRol();
											rp = dtr.cargarDatos();
											rp.beforeFirst();

											while (rp.next()) {
										%>
										<option value="<%=rp.getInt("RolID")%>"><%=rp.getString("Nombre")%></option>
										<%
											}
										%>
									</select>
								</div>
							</div>

						</div>
						<div class="clearfix"></div>
					<h5 class="page-header">Acciones</h5>
					<div class="form-group">
						<div id="cancelar_nuevo" class="col-sm-6 text-center">
							<button
									class="ajax-link action btn btn-default btn-label-left"
									type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span>
								Cancelar
							</button>
						</div>
						<div class="col-sm-6 text-center">
							<button
									class="ajax-link action btn btn-primary btn-label-left"
									onClick="" title="Guardar">
								<span><i class="fa fa-check-circle txt-success"></i></span>Guardar
							</button>
						</div>
					</div>
					<div class="clearfix"></div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-user"></i><span>Usuarios y sus Roles</span>
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
				<table id="datatable-1"
					class="table table-hover table-heading table-datatable">
					<thead>
						<tr>
							<th>Usuario</th>
							<th>Rol</th>
							<th>Acción</th>
						</tr>
					</thead>


					<tbody>
						<%
							DtRolUsuario dtur = new DtRolUsuario();
							rs = dtur.cargarVista();
							
							ResultSet rt=dtur.cargarDatos();
							rt.beforeFirst();
							
							rs.beforeFirst();
							while (rs.next() && rt.next()) {
						%>
						<tr>
							<td><%=rs.getString("Usuario")%></td>
							<td><%=rs.getString("Nombre")%></td>
							<td><button id="btnIdEliminar"
									value=<%=rt.getInt("rol_usuario")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick='eliminar(this.value);'><span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar</button>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>

					<tfoot>
						<tr>
							<th>Usuario</th>
							<th>Rol</th>
							<th>Acción</th>
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

	websocket.onmessage = function(evt) { 
		refrescar();
	};

	websocket.onerror = function(evt) {
		console.log("oho!.. error:" + evt.data);
	};

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar() {
		asignarRol();
	}
	
	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarRolUsuario(idClicked);
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
	}
	
	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "refrescar";

		$.ajax({
			url : "SlRolUsuario",
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
						"table table-bordered table-striped table-hover table-heading table-datatable");
			}

		});

	}


	function asignarRol() {
		var fIdRol = "";
		var fIdUsuario = "";
		var opcion="guardar";

		fIdRol = $("#rol").val();
		fIdUsuario = $("#usuario").val();

		$.ajax({
			url : "SlRolUsuario",
			type : "post",
			datatype : 'html',
			data : {
				'fIdRol' : fIdRol,
				'opcion' : opcion,
				'fIdUsuario' : fIdUsuario
			},
			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				AllTables();
				$("#rol").val(null);
				$("#usuario").val(null);
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
				websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
			}

		});

	}

	function eliminarRolUsuario(idClicked) {
		var opcion = "eliminar";
		var fIdRolUsuario = idClicked;

		$.ajax({
			url : "SlRolUsuario",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fIdRolUsuario' : fIdRolUsuario
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');

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

	$(document).ready(function() {

		$('#frm-agrega').hide();
		$('#frm-edita').hide();

		LoadDataTablesScripts(AllTables);
		// Add tooltip to form-controls
		$('.form-control').tooltip();

		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			$('#frm-agrega').fadeIn();
		});
		$('#cancelar_nuevo').click(function() {
			$('#frm-agrega').fadeOut();
		});
		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();
	});
</script>