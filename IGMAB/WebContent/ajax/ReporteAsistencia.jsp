<%@page import="datos.DTPsicologo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*;"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
			<li><a href="#">Asistencia</a></li>
		</ol>
	</div>
</div>

<div class="col-xs-12">
	<div class="box">
		<div class="box-header">
			<div class="box-name">
				<i class="fa fa-bell-o"></i> <span>Lista de Asistencia</span>
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
			<h4 class="page-header">Criterios de búsqueda</h4>
			<form class="form-horizontal" method="post" action="./">
				<div class="form-group">
					<label class="col-sm-3 control-label">Seleccione el
						psicologo</label>
					<div class="col-sm-5">
						<select name="country" id="psicologoId">
							<option value="">Seleccione el psicologo</option>
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
					<div class="clearfix"></div>
					<div class="form-group has-error has-feedback">
						<label class="col-sm-3 control-label">Fechas de asistencia</label>
						<div class="col-sm-2">
							<input type="text" id="fechaOrigen" class="form-control" autocomplete="off"
								placeholder="Fecha Inicio"> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
						<div class="col-sm-2">
							<input type="text" id="fechaCierre" class="form-control" autocomplete="off"
								placeholder="Fecha Fin"> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
					</div>


				</div>
				<div class="form-group has-feedback">
					<div class="col-sm-12 text-right">
						<a class="ajax-link action" href="#" id="consultar"
							onclick="busqueda();"><i class="fa fa-search fa-2x"></i><label
							class="boton-busqueda">Consultar</label></a>
					</div>
				</div>

			</form>
			<h4 class="page-header">Resultados de la búsqueda</h4>
				<div align="right">
					<a class="ajax-link action" href="#" id="imprimir" onclick="imprimir();">
					<i class="fa fa-print fa-2x"></i> 
					<span>Imprimir Listado</span>
					</a>
				</div>
				<div class="form-group has-feedback">
					<table class="table table-hover table-heading table-datatable" id="datatable-2">
						<thead>
							<tr>
								<th>Nombre completo</th>
								<th>Fecha</th>
								<th>Hora de entrada</th>
								<th>Hora de salida</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
						<tfoot>
							<tr>
								<th>Nombre completo</th>
								<th>Fecha</th>
								<th>Hora de entrada</th>
								<th>Hora de salida</th>
							</tr>
						</tfoot>
					</table>
				</div>
		</div>
	</div>
</div>

<script type="text/javascript">

///////////// FUNCION BUSQUEDA ////////////////////
function busqueda()
{
	var psicologoId ="";
	var fechaOrigen = "";
	var fechaCierre = "";
	
	psicologoId = $("#psicologoId").val();
	fechaOrigen = $("#fechaOrigen").val();
	fechaCierre = $('#fechaCierre').val();
	
	if(psicologoId == 0)
		{
		psicologoId = "";
		}

	
		$.ajax
	({
		url: "SlReporteAsistencia",
		type: "post",
		datatype: 'html',
		data: {'psicologoId' :psicologoId, 'fechaOrigen' :fechaOrigen, 'fechaCierre' : fechaCierre},
		success: function(data)
		{
			$('#datatable-2').html(data);
			$('#datatable-2').dataTable().fnDestroy();
			LoadDataTablesScripts(AllTables);
			$('#datatable-2').dataTable({ 
				"aaData": orgContent,
	            "bLengthChange": true //used to hide the property  
			});
		}
	});
}

///////////////////////////// IMPRIMIR /////////////////////////////
function imprimir()
{
	var psicologoId ="";
	var fechaOrigen = "";
	var fechaCierre = "";
	
	psicologoId = $("#psicologoId").val();
	fechaOrigen = $("#fechaOrigen").val();
	fechaCierre = $('#fechaCierre').val();
	
	if(psicologoId == 0)
		{
		psicologoId = "";
		}
		
	window.open("SlReporteAsistencia?psicologoId="+psicologoId+"&fechaOrigen="+fechaOrigen+"&fechaCierre="+fechaCierre, '_blank');
}



/////////////////////////////DATATABLES PLUGIN CON 3 VARIANTES DE CONFIGURACIONES/////////////////////////////
	function AllTables() 
	{
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
// Add Drag-n-Drop feature
	$(document).ready(function() {	
/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);
/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
/////////////////////////////MENSAJES EN PANTALLA/////////////////////////////


////////////////////////////INICIALIZAR LAS FECHAS CON SUS INTERVALOS	/////////////////////////////
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
            changeMonth: true,
            changeYear : true,
            yearRange : "-10:+10",
        };

        $.datepicker.setDefaults($.datepicker.regional['es']);

		$('#fechaOrigen').datepicker({
			setDate : new Date(),
			dateFormat : 'yy-mm-dd',
			changeMonth: true,
			changeYear : true,
			yearRange : "-10:+10",

		});
		$('#fechaCierre').datepicker({
			setDate : new Date(),
			dateFormat : 'yy-mm-dd',
			changeMonth: true,
			changeYear : true,
			yearRange : "-10:+10",
		});


/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();	
	});
</script>


