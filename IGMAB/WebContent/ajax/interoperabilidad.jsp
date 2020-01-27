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

	
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Interoperabilidad</a></li>
			<li><a href="#">Test SQL DB</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">

	</div>
</div>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Lista de
						Empleados</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="box-name">
<!-- 					<i class="fa fa-location-arrow"></i> <span>Agregar -->
<!-- 						Parentesco</span> -->
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
							<th>Nombre</th>
							<th>Apellido</th>
							<th>Edad</th>
							<th>Salario</th>
						</tr>
					</thead>
					<tbody>
						<%
							DtInteroperabilidad dtp = DtInteroperabilidad.getInstance();
							ResultSet rs;
							rs = dtp.cargarDatos();
							rs.beforeFirst();

							while(rs.next()) {
						%>

						<tr>
							<td><%=rs.getString("Nombre1")%></td>
							<td><%=rs.getString("Apellido1")%></td>
							<td><%=rs.getString("Edad")%></td>
							<td><%=rs.getString("Salario")%></td>
<!-- 							<td><button id="btnIdEliminar" -->
<%-- 									value=<%=rs.getInt("EmpleadoID")%> --%>
<!-- 									class='ajax-link action btn btn-default btn-label-left' -->
<!-- 									onClick='eliminar(this.value);'> -->
<!-- 									<span><i class="fa fa-trash-o txt-danger"></i></span>Eliminar</button> -->
<!-- 								<button id='btnIdActualizar' -->
<%-- 									onClick="cargarDatos(this.value, '<%=rs.getString("Parentesco")%>');" --%>
<%-- 									value=<%=rs.getInt("ParentescoID")%> class='btn btn-primary btn-label-left'> --%>
<!-- 									<span><i class="fa fa-edit"></i></span> -->
<!-- 									Actualizar</button> -->
<!-- 							</td> -->
						</tr>

						<%
							}
						%>

					</tbody>
					<tfoot>
						<tr>
							<th>Nombre</th>
							<th>Apellido</th>
							<th>Edad</th>
							<th>Salario</th>
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
		guardarParentesco();

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarParentesco(idClicked);
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarParentesco(idClicked);
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
		
	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";

		$.ajax({
			url : "SlParentescoAjax",
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
	function guardarParentesco() {
		var fparentesco = "";
		var opcion = "";

		opcion = "guardar";
		fparentesco = $("#parentesco").val();

		$.ajax({
			url : "SlParentescoAjax",
			type : "post",
			datatype : 'html',
			data : {
				'fparentesco' : fparentesco,
				'opcion' : opcion
			},
			success : function(data) {
				$("#parentesco").val(null);
				websocket.send("Guardar");
				successAlert('Listo', 'Guardado exitosamente');
			}

		});

	}

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarParentesco(idClicked) {
		var opcion = "";
		var fIdParentesco = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlParentescoAjax",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fIdParentesco' : fIdParentesco
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');

			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarParentesco(idClicked) {
		var opcion = "";
		var fParentescoId = idClicked;
		var fParentescoEditar = "";

		opcion = "actualizar";
		fParentescoEditar = $("#parentescoEditar").val();
		$.ajax({
			url : "SlParentescoAjax",
			type : "post",
			datatype : 'html',
			data : {
				'fParentescoId' : fParentescoId,
				'fParentescoEditar' : fParentescoEditar,
				'opcion' : opcion
			},
			success : function(data) {
				$("#parentescoEditar").val(null);
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
				$('#frm-edita').fadeOut();
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(parentescoId, parentesco) {
		var fParentescoId = parentescoId;
		var fParentesco = parentesco;

		$('#btnEditar').val(fParentescoId);
		$('#parentescoEditar').val(fParentesco);
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
	//  	function editOrDeleteCustomer(event) 
	//  	{
	//  	    var link = jQuery(event.currentTarget);
	//  	    var url = link.attr('href');
	//  	    jQuery.get(url, function(data) {
	//  	       $('#frm-edita').fadeIn();
	//  	    });
	//  	}
	// Add Drag-n-Drop feature
	

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