<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="datos.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Último corregido -->
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
			<li><a href="#">Preguntas</a></li>
			<li><a href="#">Título pregunta</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">

		<!-- INICIO DE FORMULARIO PARA AGREGAR UN TÍTULO PREGUNTA  -->

		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Formulario de Registro
						Título Pregunta</span>
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
					<!-- 					<form class="form-horizontal" method="post"	action="./#"> -->
					<div class="col-sm-6">
						<h5 class="page-header">Formulario</h5>
						<div class="form-group">
							<label class="col-sm-6 control-label">Título Pregunta:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control"
									placeholder="Ej: sensaciones, sentimientos"
									data-toggle="tooltip" data-placement="bottom" id="descripcion"
									name="descripcion" title="El título es requerido" required />
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
								<button class="ajax-link action btn btn-primary btn-label-left" onClick="guardar();"
									title="Guardar">
									<span><i class="fa fa-check-circle txt-success"></i></span>Guardar
									</button>
							</div>
						</div>

					</div>
					<!-- 					</form> -->
				</div>
			</div>
		</div>

		<!-- FIN DE FORMULARIO PARA AGREGAR UN TIPO  -->

		<!-- INICIO DE FORMULARIO PARA EDITAR UN TIPO  -->

		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Formulario de Registro Título Pregunta</span>
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
					<!-- 					<form class="form-horizontal" method="post"	action="./#"> -->
					<div class="col-sm-6">
						<h5 class="page-header">Formulario</h5>
						<div class="form-group">
							<label class="col-sm-6 control-label">Título Pregunta:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control"
									placeholder="Ej: sensaciones, sentimientos"
									data-toggle="tooltip" data-placement="bottom"
									id="descripcionEditar" name="descripcionEditar"
									title="El título es requerido" required />
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
					<!-- 					</form> -->
				</div>




			</div>
		</div>

		<!-- FIN DE FORMULARIO PARA EDITAR UN TÍTULO PREGUNTA  -->

	</div>
</div>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Lista de Títulos Pregunta</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar Título Pregunta</span>
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
							<th>Título</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
							DtTituloPregunta dttresp = new DtTituloPregunta();
							rs = dttresp.cargarDatos();
							rs.beforeFirst();

							while (rs.next()) {
						%>

						<tr>
							<td><%=rs.getString("Descripcion")%></td>
							<td><button id="btnIdEliminar"
									value=<%=rs.getInt("TitulopreguntaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>
									Eliminar</button>
									
								<button id='btnIdActualizar'
									onClick="cargarDatos(this.value, '<%=rs.getString("Descripcion")%>');"
									value=<%=rs.getInt("TitulopreguntaID")%> class="btn btn-primary btn-label-left">
									<span><i class="fa fa-edit"></i></span>
									Actualizar</button></td>
						</tr>

						<%
							}
						%>

					</tbody>
					<tfoot>
						<tr>
							<th>Título</th>
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
		guardarTituloPregunta();

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarTituloPregunta(idClicked);
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarTituloPregunta(idClicked);
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";

		$.ajax({
			url : "SlTituloPregunta",
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
	function guardarTituloPregunta() {
		var fdescripcion = "";
		var opcion = "";

		opcion = "guardar";
		fdescripcion = $("#descripcion").val();

		$.ajax({
			url : "SlTituloPregunta",
			type : "post",
			datatype : 'html',
			data : {
				'fdescripcion' : fdescripcion,
				'opcion' : opcion
			},
			success : function(data) {
				$("#descripcion").val(null);
				websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
			}

		});

	}

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarTituloPregunta(idClicked) {
		var opcion = "";
		var fTituloPreguntaId = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlTituloPregunta",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fTituloPreguntaId' : fTituloPreguntaId
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');

			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarTituloPregunta(idClicked) {
		var opcion = "";
		var fTituloPreguntaId = idClicked;
		var fDescripcionEditar = "";

		opcion = "actualizar";
		fDescripcionEditar = $("#descripcionEditar").val();
		$.ajax({
			url : "SlTituloPregunta",
			type : "post",
			datatype : 'html',
			data : {
				'fTituloPreguntaId' : fTituloPreguntaId,
				'fDescripcionEditar' : fDescripcionEditar,
				'opcion' : opcion
			},
			success : function(data) {
				$("#descripcionEditar").val(null);
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
				$('#frm-edita').fadeOut();
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(TituloPreguntaId, descripcion) {
		var fTituloPreguntaId = TituloPreguntaId;
		var fDescripcion = descripcion;

		$('#btnEditar').val(fTituloPreguntaId);
		$('#descripcionEditar').val(fDescripcion);
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
</script>