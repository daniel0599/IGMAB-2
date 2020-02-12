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
			<li><a href="#">Usuario</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-user"></i> <span>Agregar Usuario</span>
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
						action="javascript:void(0);" onsubmit="compararGuardar();">
						<div class="col-sm-6">
							<h5 class="page-header">Nuevo Usuario</h5>
							<div class="form-group">
								<label class="col-sm-4 control-label">Usuario</label>
								<div class="col-sm-6">
									<input type="text" class="form-control "
										placeholder="Nombre de Usuario" data-toggle="tooltip"
										data-placement="bottom" id="usuario" name="usuario"
										title="El nombre de usuario o login es requerido" required>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">Contraseña</label>
								<div class="col-sm-6">
									<input id="password" type="password"
										class="form-control text-rpromedix has-rpromedix"
										placeholder="" data-toggle="tooltip" data-placement="bottom"
										name="password" title="La contraseña es requerida" required>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Confirmar
									Contraseña</label>
								<div class="col-sm-6">
									<input id="conf_password" type="password"
										class="form-control text-rpromedix has-rpromedix"
										placeholder="" data-toggle="tooltip" data-placement="bottom"
										name="conf_Password"
										title="Por seguridad es necesario que vuelva a escribir su contraseña"
										required>
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
									<button class="ajax-link action btn btn-primary btn-label-left"
										onClick="" title="Guardar">
										<span><i class="fa fa-check txt-success"></i></span>Guardar
									</button>
								</div>
							</div>

						</div>
					</form>
				</div>



			</div>
		</div>
		<div id="frm-edita" class="box">
			<div class="col-xs-12">
				<div id="frm-edita" class="box">
					<div class="box-header">
						<div class="box-name">
							<i class="fa fa-file-text-o"></i> <span>Cambiar Contraseña de
								Usuario</span>
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
<!-- 												<form id="agreg" class="form-horizontal" method="post" -->
<!-- 						action="javascript:void(0);" onsubmit="compararEditar();"> -->

							<h4 class="page-header">Nueva contraseña</h4>
							<div class="col-sm-8">
								<div class="form-group">

									<label class="col-sm-4 control-label">Usuario</label>
									<div class="col-sm-6">
										<input type="text" class="form-control has-rpromedix"
											placeholder="Nombre de Usuario" data-toggle="tooltip"
											data-placement="bottom" id="usuarioE" name="usuarioE"
											title="El nombre de usuario es requerido" disabled>
									</div>
								</div>

								<div class="form-group">

									<label class="col-sm-4 control-label">Contraseña</label>
									<div class="col-sm-6">
										<input id="passwordEditar" type="password"
											class="form-control text-rpromedix has-rpromedix"
											placeholder="" data-toggle="tooltip" data-placement="bottom"
											name="passwordEditar" title="La clave es requerida" required>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">Confirmar
										Contraseña</label>
									<div class="col-sm-6">
										<input type="password"
											class="form-control text-rpromedix has-rpromedix"
											placeholder="" data-toggle="tooltip" data-placement="bottom"
											id="confPasswordEditar" name="confPasswordEditar"
											title="Por seguridad es necesario que vuelva a escribir su clave"
											required>
									</div>
								</div>
							</div>
							<div class="col-sm-6">
								<h5 class="page-header">Acciones</h5>
								<div class="form-group">
									<div id="cancelar_nuevo_editar" class="col-sm-6 text-center">
										<button
											class="ajax-link action btn btn-default btn-label-left"
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
											onClick="compararEditar(this.value);" title="Editar">
											<span><i class="fa fa-check txt-success"></i></span> Editar
										</button>
									</div>
								</div>

							</div>
<!-- 												</form> -->
						</div>
					</div>
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
					<i class="fa fa-list"></i><span>Lista de Usuarios</span>
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
							<th>Fecha Creación</th>
							<th>Acciones</th>
						</tr>
					</thead>


					<tbody>
						<%
							DtUsuario dtu = new DtUsuario();
							rs = dtu.cargarDatos();
							rs.beforeFirst();

							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("Usuario")%></td>
							<td><%=rs.getString("Fechacreacion")%></td>
							<td><button id="btnIdEliminar"
									value=<%=rs.getInt("UsuarioID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar
								</button>
								<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getString("Usuario")%>');"
									value=<%=rs.getInt("UsuarioID")%>
									class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
						</tr>
						<%
							}
						%>
					</tbody>

					<tfoot>
						<tr>
							<th>Usuario</th>
							<th>Fecha Creación</th>
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

	// 	websocket.onopen = function(evt) { //manejamos los eventos...
	// 		System.out.println("Conectado...");
	// 	};

	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
		//alert("Hubo cambio en la base de datos. Actualiza la página para verlos");
		//log("Mensaje recibido:" + evt.data);
		refrescar();
	};

	websocket.onerror = function(evt) {
		console.log("oho!.. error:" + evt.data);
	};

	function checkPassword(str)
	  {
	    // at least one number, one lowercase and one uppercase letter
	    // at least six characters
	    var re = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/;
	    return re.test(str);
	  }

	
	//Función para comparar las contraseñas que sean iguales, en caso de no serlo se manda un mensaje al usuario
	function compararGuardar() {
		var aprobada=checkPassword(document.getElementById("password").value);
		
		if(aprobada==false){
			alert("La contraseña debe contener por lo menos seis caracteres, un caracter en mayúscula, un caracter en minúscula y un número ");
		}
		else if (aprobada==true && document.getElementById("password").value==document.getElementById("conf_password").value) {
			guardar();
		} else {
			alert('Las contraseñas no coinciden, por favor verifique que las contraseñas sean iguales');
		}
	}
	
	function compararEditar(idClicked) {
		var aprobada=checkPassword(document.getElementById("passwordEditar").value);
		
		if(aprobada==false){
			alert("La contraseña debe contener por lo menos seis caracteres, un caracter en mayúscula, un caracter en minúscula y un número ");
		}
		else if (aprobada==true && document.getElementById("passwordEditar").value==document.getElementById("confPasswordEditar").value) {
			actualizar(idClicked);
		} else {
			alert('Las contraseñas no coinciden, por favor intentelo de nuevo');
		}
	}
	
	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar() {
		guardarUsuario();

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarUsuario(idClicked);
		websocket.send("Modificar");

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function() {
			eliminarUsuario(idClicked);
		}, function() {
			infoAlert('Aviso', 'Eliminación cancelada');
		});

	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "refrescar";

		$.ajax({
			url : "SlUsuario",
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

	//MÉTODO PARA GUARDAR EL REGISTRO A TRAVÉS DEL SERVLET
	function guardarUsuario() {
		var fusuario = "";
		var fpassword = "";
		var opcion = "";

		opcion = "guardar";
		fusuario = $("#usuario").val();
		fpassword = $("#password").val();

		$.ajax({
			url : "SlUsuario",
			type : "post",
			datatype : 'html',
			data : {
				'fusuario' : fusuario,
				'fpassword' : fpassword,
				'opcion' : opcion
			},
			success : function(data) {
				if(data=="1") {
					errorAlert("El usuario ya existe");
				}
				else {
					$("#usuario").val(null);
					$("#password").val(null);
					$("#conf_password").val(null);
					websocket.send("Guardar");
					successAlert('Listo', 'Guardado exitosamente');
					$('#frm-agrega').fadeOut();
				}
			}

		});

	}

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarUsuario(idClicked) {
		var opcion = "";
		var fUsuarioId = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlUsuario",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fUsuarioId' : fUsuarioId
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');

			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarUsuario(idClicked) {
		var opcion = "";
		var fUsuarioId = idClicked;
		var fpasswordEditar = "";
		var fusuario = ";"

		opcion = "actualizar";
		fpasswordEditar = $("#passwordEditar").val();
		fusuario = $("#usuarioE").val();
		
		$.ajax({
			url : "SlUsuario",
			type : "post",
			datatype : 'html',
			data : {
				'fUsuarioId' : fUsuarioId,
				'fpasswordEditar' : fpasswordEditar,
				'opcion' : opcion
			},
			success : function(data) {
				$("#passwordEditar").val(null);
				$("#confPasswordEditar").val(null);
				$("#usuarioE").val(null);
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
				$('#frm-edita').fadeOut();
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(UsuarioId, usuario) {
		var fUsuarioId = UsuarioId;
		var fusuarioe = usuario;

		$('#usuarioE').val(fusuarioe);
		$('#btnEditar').val(fUsuarioId);
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
		$('#cancelar_nuevo_editar').click(function() {
			$('#frm-edita').fadeOut();
		});
		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();
	});
</script>