<%@page import="entidades.*"%>
<%@page import="java.util.*, java.sql.ResultSet, java.text.SimpleDateFormat"%>
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
		response.sendRedirect("Home.jsp");
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
			<li><a href="#">Asistencia</a></li>
			<li><a href="#">Gestión Asistencia</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Agregar nueva
						asistencia</span>
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
					<form class="form-horizontal" method="post"
						action="javascript:void(0);">
						<div class="col-sm-6">
							<h5 class="page-header">Datos</h5>
							<div class="row form-group">
								<label class="col-sm-6 control-label">Psicólogo:</label>
								<div class="col-sm-6">
									<select id="psicologo">
										<option>Seleccione</option>
										<%
											DTPsicologo dtpsi = new DTPsicologo();
											 rs = dtpsi.cargarDatos();
											rs.beforeFirst();
											while (rs.next()) {
										%>
										<option value="<%=rs.getInt("PsicologoID")%>"><%=rs.getString("Nombre1")+" "+rs.getString("Nombre2")+" "+rs.getString("Apellido1")+" "+rs.getString("Apellido2")%></option>

										<%
											}
										%>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-6 control-label">Fecha:</label>
								<div class="col-sm-6">
									<% 
										SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
							        	SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
										Calendar cal = Calendar.getInstance();
														
									%>
									<input type="text" class="form-control" placeholder=""
										data-toggle="tooltip" data-placement="bottom" id="fecha"
										name="fecha" title="La fecha de hoy" required readonly="readonly" value="<%=formatter.format(new java.util.Date())%>"/>
								</div>
								<label class="col-sm-6 control-label">Hora:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" placeholder=""
										data-toggle="tooltip" data-placement="bottom" id="hora"
										name="hora" title="La hora" required readonly="readonly" value="<%=time.format(cal.getTime()) %>"/>
								</div>
							</div>

						</div>
						<div class="col-sm-6">
							<h5 class="page-header">Acciones</h5>
							<div class="form-group">
								<div id="cancelar_nuevo" class="col-sm-2 text-center">
<!-- 									<button class="ajax-link action btn btn-default btn-label-left" -->
<!-- 										type="reset" title="Cancelar"> -->
<!-- 										<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar -->
<!-- 									</button> -->
								</div>
								<div class="col-sm-6 text-center">
									<!-- 									<button class="ajax-link action" onClick="guardarParentesco();" title="Guardar"> -->
									<!-- 										Guardar -->
									<!-- 									</button> -->
									<button class="ajax-link action btn btn-primary btn-label-left"
										onClick="" title="Entrada">
										<span><i class="fa fa-clock-o"></i></span>Entrada
									</button>
									<button class="ajax-link action btn btn-primary btn-label-left"
										onClick="" title="Entrada">
										<span><i class="fa fa-clock-o txt-danger"></i></span>Salida
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
<!-- <div class="row"> -->
<!-- 	<div class="col-xs-12"> -->
<!-- 		<div class="box"> -->
<!-- 			<div class="box-header"> -->
<!-- 				<div class="box-name"> -->
<!-- 					<i class="fa fa-location-arrow"></i> <span>Lista de -->
<!-- 						Asistencia</span> -->
<!-- 				</div> -->
<!-- 				<div class="box-icons"> -->
<!-- 					<a class="collapse-link"> <i class="fa fa-chevron-up"></i> -->
<!-- 					</a> <a class="expand-link"> <i class="fa fa-expand"></i> -->
<!-- 					</a> <a class="close-link"> <i class="fa fa-times"></i> -->
<!-- 					</a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
<!-- 			</div> -->
<!-- 			<div class="box-content no-padding"> -->
<!-- 				<div class="row padding-opc"> -->
<!-- 					<div class="col-md-12"> -->
<!-- 						<div class="col-md-12 col-xs-12 col-sm-12 agregar"> -->
<!-- 							<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#" -->
<!-- 								title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->

<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<table class="table table-hover table-heading table-datatable" -->
<!-- 					id="datatable-1"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th>ID-Psicologo</th> -->
<!-- 							<th>Fecha</th> -->
<!-- 							<th>Hora Entrada</th> -->
<!-- 							<th>Hora Salida</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->

<%-- 						<% --%>
<!--  							DTAsistencia dta = DTAsistencia.getInstance(); -->
							
<!-- 							listaAsistencia = dta.CargarAsistencias(); -->

<!--  							for (Asistencia a : listaAsistencia) { -->
<%-- 						%> --%>

<!-- 						<tr> -->
<%-- 							<td><%=a.getPsicologoID()%></td> --%>
<%-- 							<td><%=a.getFecha()%></td> --%>
<%-- 							<td><%=a.getHoraEntrada()%></td> --%>
<%-- 							<td><%=a.getHoraSalida()%></td> --%>

<!-- 						</tr> -->

<%-- 						<% --%>
<!-- // 							} -->
<%-- 						%> --%>

<!-- 					</tbody> -->
<!-- 					<tfoot> -->
<!-- 						<tr> -->
<!-- 							<th>ID-Psicologo</th> -->
<!-- 							<th>Fecha</th> -->
<!-- 							<th>Hora Entrada</th> -->
<!-- 							<th>Hora Salida</th> -->
<!-- 						</tr> -->
<!-- 					</tfoot> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<script type="text/javascript">
	$(document).ready(function() {
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
		WinMove();
	});
</script>

<script type="text/javascript">
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
		//$('#frm-agrega').hide();
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
		});
		$('#cancelar_nuevo').click(function() {
			$('#frm-agrega').fadeOut();
		});
		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();
	});
</script>