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
<input id="usuarioID" name="usuarioID" type="hidden" value=<%=us.getUsuarioID()%> checked>
<input id="TipoRol" name="TipoROl" type="hidden" value=<%=r.getRolId()%>  checked>
<%
if(r.getRolId() == 3 || r.getRolId() == 5){
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
					<i class="fa fa-address-card-o"></i> <span>Agregar Pariente
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
			<div class="box-content">
				<div class="row">
					<h4 class="page-header">Registrar pariente a paciente</h4>
                      <form id="agregar" class="form-horizontal" role="form" action="javascript:void(0);" onsubmit="guardar();">
					<div class="col-sm-6">
						<h5 class="page-header">Datos</h5>
						<div class="form-group">
							<label class="col-sm-2 control-label">Pariente</label>
							<div class="col-sm-5">
								<select name="pariente" id="pariente" required>
									<option value="">Seleccione</option>
									<%
										ResultSet rspsi;
									    DtPariente dtpar = new DtPariente();
										rspsi = dtpar.cargarDatosApsicologo(us.getUsuarioID());
										rspsi.beforeFirst();
										while (rspsi.next()) {
									%>
									<option value="<%=rspsi.getInt("ParienteIDpar")%>"><%=rspsi.getString("Nombre1par")%>
										<%=rspsi.getString("Apellido1par")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Paciente</label>
							<div class="col-sm-5">
								<select name="paciente" id="paciente" required>
									<option value="">Seleccione</option>
									<%
									ResultSet rspso;
									DtPaciente dtpac = new DtPaciente();
										rspso = dtpac.cargarPacientesAPsicologos(us.getUsuarioID());
										rspso.beforeFirst();
										while (rspso.next()) {
									%>
									<option value="<%=rspso.getInt("PacienteID")%>"><%=rspso.getString("Nombre1")%>
										<%=rspso.getString("Apellido1")%></option>
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
							<div id="cancelar_nuevo" class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-default btn-label-left"
									type="reset" title="Cancelar">
									<span><i class="fa fa-minus-circle txt-danger"></i></span>
									Cancelar
								</button>
							</div>
							<div class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-primary btn-label-left"
									 onClick="" title="Guardar">
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

<div class="row">
	<div class="col-xs-12 col-sm-12">
<!--  INCICIO DE FORMULARIO PARA AGREGAR UN PSICOLOGO -->

		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Actualizar Pariente
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
			<div class="box-content">
				<div class="row">
					<h4 class="page-header">Modificar pariente a paciente</h4>
                      <form id="edit" class="form-horizontal" role="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="col-sm-6">
						<h5 class="page-header">Datos</h5>
						<div class="form-group">
							<label class="col-sm-2 control-label">Pariente</label>
							<div class="col-sm-5">
								<select name="pariente" id="ParienteEditar" required>
									<option value="">Seleccione</option>
									<%
										ResultSet rspsie;
									 
										rspsie = dtpar.cargarDatosApsicologo(us.getUsuarioID());
										rspsie.beforeFirst();
										while (rspsie.next()) {
									%>
									<option value="<%=rspsie.getInt("ParienteIDpar")%>"><%=rspsie.getString("Nombre1par")%>
										<%=rspsie.getString("Apellido1par")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Paciente</label>
							<div class="col-sm-5">
								<select name="paciente" id="PacienteEditar" required>
									<option value="">Seleccione</option>
									<%
									ResultSet rspsoe;
								
										rspsoe = dtpac.cargarPacientesAPsicologos(us.getUsuarioID());
										rspsoe.beforeFirst();
										while (rspsoe.next()) {
									%>
									<option value="<%=rspsoe.getInt("PacienteID")%>"><%=rspsoe.getString("Nombre1")%>
										<%=rspsoe.getString("Apellido1")%></option>
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
		                 <button id="btnEditar"
							class="ajax-link btn btn-primary btn-label-left"
							onCLick="" title="Editar">
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
	</div>
</div>







<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
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
						ResultSet rsvv1 = dtvpp.cargarVistaApsicologo(us.getUsuarioID());
							rsvv1.beforeFirst();
							while (rsvv1.next()) {
						%>
						<tr>
							<td><%=rsvv1.getString("Nombre1par") + " "
						+ rsvv1.getString("Apellido1par") + " " + rsvv1.getString("Apellido2par")%></td>
							<td><%=rsvv1.getString("Nombre1pac") + " "
						+ rsvv1.getString("Apellido1pac") + " " + rsvv1.getString("Apellido2pac")%></td>
							
							<td><button id='btnIdActualizar'
									onClick="cargarDatos('<%=rsvv1.getInt("ParPacID")%>', '<%=rsvv1.getInt("PacienteIDpac")%>', '<%=rsvv1.getInt("ParienteIDpar")%>');"
									value=<%=rsvv1.getInt("ParPacID")%>
									class="btn btn-primary btn-label-left">
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

<%
}else{
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
					<i class="fa fa-address-card-o"></i> <span>Agregar Pariente
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
			<div class="box-content">
				<div class="row">
					<h4 class="page-header">Registrar pariente a paciente</h4>
                      <form id="agregar" class="form-horizontal" role="form" action="javascript:void(0);" onsubmit="guardar();">
					<div class="col-sm-6">
						<h5 class="page-header">Datos</h5>
						<div class="form-group">
							<label class="col-sm-2 control-label">Pariente</label>
							<div class="col-sm-5">
								<select name="pariente" id="pariente" required>
									<option value="">Seleccione</option>
									<%
										ResultSet rs5;
									    DtPariente dtpar = new DtPariente();
										rs5 = dtpar.cargarDatos();
										rs5.beforeFirst();
										while (rs5.next()) {
									%>
									<option value="<%=rs5.getInt("ParienteID")%>"><%=rs5.getString("Nombre1")%>
										<%=rs5.getString("Apellido1")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Paciente</label>
							<div class="col-sm-5">
								<select name="paciente" id="paciente" required>
									<option value="">Seleccione</option>
									<%
									ResultSet rs6;
									DtPaciente dtpac = new DtPaciente();
										rs6 = dtpac.cargarDatos();
										rs6.beforeFirst();
										while (rs6.next()) {
									%>
									<option value="<%=rs6.getInt("PacienteID")%>"><%=rs6.getString("Nombre1")%>
										<%=rs6.getString("Apellido1")%></option>
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
							<div id="cancelar_nuevo" class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-default btn-label-left"
									type="reset" title="Cancelar">
									<span><i class="fa fa-minus-circle txt-danger"></i></span>
									Cancelar
								</button>
							</div>
							<div class="col-sm-6 text-center">
								<button class="ajax-link action btn btn-primary btn-label-left"
									 onClick="" title="Guardar">
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
<div class="row">
	<div class="col-xs-12 col-sm-12">
	
<!--INICIO DE FORMULARIO PARA EDITAR  UN PSICOLOGO -->
<div id="frm-edita" class="box">
	<div class="box-header">
		<div class="box-name">
			<i class="fa fa-exchange"></i> <span>Editar Pariente a
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
	<div class="box-content">
		<div class="row">
			  <h4 class="page-header">Editar Pariente a Paciente</h4>
			 <form id="edit" class="form-horizontal" role= "form" method="post" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
			<div class="col-sm-6">
				<h5 class="page-header">Datos</h5>

				<div class="form-group">
					<label class="col-sm-2 control-label">Pariente</label>
					<div class="col-sm-5">
						<select name="ParienteEditar" id="ParienteEditar" required>
							<option value="">Seleccione</option>
							<%
							ResultSet rs7;	
							DtPariente dtpare = new DtPariente();
								rs7 = dtpare.cargarDatos();
								rs7.beforeFirst();
								while (rs7.next()) {
							%>
							<option value="<%=rs7.getInt("ParienteID")%>"><%=rs7.getString("Nombre1")%><%=rs7.getString("Apellido1")%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Paciente</label>
					<div class="col-sm-5">
						<select name="PacienteEditar" id="PacienteEditar" required>
							<option value="">Seleccione</option>
							<%
							ResultSet rs8;	
							DtPaciente dtpace = new DtPaciente();
								rs8 = dtpace.cargarDatos();
								rs8.beforeFirst();
								while (rs8.next()) {
							%>
							<option value="<%=rs8.getInt("PacienteID")%>"><%=rs8.getString("Nombre1")%><%=rs8.getString("Apellido1")%></option>
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
		                 <button id="btnEditar"
							class="ajax-link btn btn-primary btn-label-left"
							onCLick="" title="Editar">
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
</div>
</div>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
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
							ResultSet rsvv2 = dtvpp.cargarVista();
							rsvv2.beforeFirst();
							while (rsvv2.next()) {
						%>
						<tr>
							<td><%=rsvv2.getString("Nombre1par") + " "
						+ rsvv2.getString("Apellido1par") + " " + rsvv2.getString("Apellido2par")%></td>
							<td><%=rsvv2.getString("Nombre1") + " "
						+ rsvv2.getString("Apellido1") + " " + rsvv2.getString("Apellido2")%></td>
							
							<td><button id='btnIdActualizar'
									onClick="cargarDatos('<%=rsvv2.getInt("ParPacID")%>', '<%=rsvv2.getInt("PacienteID")%>', '<%=rsvv2.getInt("ParienteID")%>');"
									value=<%=rsvv2.getInt("ParPacID")%>
									class="btn btn-primary btn-label-left">
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
<%}%>
<script type="text/javascript">
	/////////////////////////////FUNCIONES DEL WEBSOCKET/////////////////////////////
// 	var wsUri = "ws://localhost:8080/IGMAB/serverendpointigmab";
// 	var websocket = new WebSocket(wsUri); //instanciamos el socket
	
		
// 		websocket.onopen = function(evt) { //manejamos los eventos...
// 			console.log("Conectado...");
// 		};
// 		websocket.onmessage = function(evt) { // cuando se recibe un mensaje
// 			refrescar();
// 		};
// 		websocket.onerror = function(evt) {
// 			console.log("oho!.. error:" + evt.data);
// 		};
			

//	MEtodo para ejecutar el websocket. onmessage y guardar
	function guardar() {
		guardarParientePaciente();
		console.log("Se guardo");
	}
	//Metodo para ejecutar el WEBSOCKET ; ON MESSGE Y ACTUALIZAR
	function actualizar(idClicked) {
		var id;
		id = idClicked;
		actualizarParientePaciente(id);
	}
	
	function refrescarApsicologo(){
		console.log("adentro del refrescar de psicologo");
		var fusuarioID = "";
		fusuarioID = $('#usuarioID').val();
		var opcion = "";
		opcion = "refrescarApsicologo";
		//var table = $('#datatable-1').DataTable();
		$.ajax({
			url : "SLParientePaciente",
			type : "post",
			datatype : 'html',
			data : {
				'fusuarioID' : fusuarioID,
				'opcion' : opcion
			},
			success : function(data) {
				console.log("Se fue al servlet a armar la datatable");
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				AllTables();
				$('#datatable-1').addClass(
						"dataTables_wrapper form-inline");
			}
		});
		console.log("Saliendo del refrescar de psicologo");
	}
	//METODO PARA REFRESCAR EL DATATABLE A TRAVËS DEL SERVLET
	function refrescar() {
// 		var tiporol = 0;
// 		tiporol = $('TipoRol').val();
// 		
		
		console.log("adentro del refrescar");
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
				console.log("Se fue al servlet a armar la datatable");
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				AllTables();
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
			}
		});
		
		console.log("Saliendo del refrescar");
		
	}
		
	//Método para guardar el psicologo a través del servlet
	function guardarParientePaciente() {
		var opcion ="";
		var fParienteID;
		var fPacienteID;
		
    var fusuarioID = 0;
    var tiporol =  0;
	tiporol = $('#TipoRol').val();
		fusuarioID = $('#usuarioID').val();
		
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
				'fusuarioID' : fusuarioID,
				'opcion' : opcion
			},
			success : function(data) {
				//websocket.send("Guardar");
				
				
				if(tiporol == 3 || tiporol == 5){
					refrescarApsicologo();
					successAlert('Listo', 'Guardado exitosamente');
					$('#pariente').val(null);
					$('#paciente').val(null);
					$("#agregar")[0].reset();
					$('#frm-agrega').fadeOut();
					
				}else{
					successAlert('Listo', 'Guardado exitosamente');
					$('#pariente').val(null);
					$('#paciente').val(null);
					$("#agregar")[0].reset();
					$('#frm-agrega').fadeOut();
					refrescar();
			
				}
				
			}
		});
	}

	//METODO PARA ACTUALIZAR EL REGISTRO
function actualizarParientePaciente(idClicked) {
	   console.log("dentro de actualizar pariente paciente");
		var opcion = "";
	    var fParientePacienteID = idClicked;
	    var fparienteEditar = 0;
		var fpacienteEditar = 0;
		var tiporol =  0;
		tiporol = $('#TipoRol').val();
		
		opcion = "actualizar";
		fparienteEditar = $("#ParienteEditar").val();
		fpacienteEditar = $("#PacienteEditar").val();

		$.ajax({
			url : "SLParientePaciente",
			type : "POST",
			datatype : 'html',
			data : {
				'fParientePacienteID' : fParientePacienteID,
				'fparienteEditar' : fparienteEditar,
				'fpacienteEditar' : fpacienteEditar,
				'opcion' : opcion
			},
			success : function(data) {
				
				
				if(tiporol == 3 || tiporol == 5){
					refrescarApsicologo();
					$("#edit")[0].reset();
					$('#frm-edita').fadeOut();
					successAlert('Listo', 'Actualizado exitosamente');
					
				}else{
					refrescar();
					$("#edit")[0].reset();
					$('#frm-edita').fadeOut();
					successAlert('Listo', 'Actualizado exitosamente');
			
				}
			

			},
			error: function(errorThrown){
				infoAlert('AVISO', 'no se pudo actualizar bien');
				
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
	function cargarDatos(ParPacID, PacienteID, ParienteID) {
		var fParPacID = ParPacID;
		var fPacienteID = PacienteID;
		var fParienteID = ParienteID;
	
		$('#frm-edita').fadeIn();
		$('#frm-agrega').fadeOut();
		$('#btnEditar').val(fParPacID);
		
		$('#PacienteEditar').val(fPacienteID).change();
		$('#ParienteEditar').val(fParienteID).change();
		
		console.log("Se cargaron los datos apara editar");
		
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

		$('#frm-edita').hide();
		$('#frm-agrega').hide();

		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);
		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			
				$('#frm-agrega').fadeIn();
				$('#frm-edita').fadeOut()
				
			
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