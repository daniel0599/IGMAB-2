<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
			<li><a href="#">Pacientes</a></li>
		</ol>
	</div>
</div>

<div class="row">

	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> 
					<span>Lista de Pacientes</span>
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
					
					<div class="form-group has-feedback">
						<label class="col-sm-2 text-gpromedix control-label">Rango de edad 1:</label>
						<div class="col-sm-4 has-rpromedix">
							<input type="text" class="form-control"
										placeholder="Ej. 12" data-toggle="tooltip"
										data-placement="bottom" id="edad" name="edad"
										title="Primer valor del rango" required/>
						</div>

						<label class="col-sm-2 text-gpromedix control-label">Rango de edad 2:</label>
						<div class="col-sm-4 has-rpromedix">
							<input type="text" class="form-control"
								   placeholder="Ej. 18" data-toggle="tooltip"
								   data-placement="bottom" id="edad2" name="edad2"
								   title="Segundo valor del rango" required/>
						</div>

						<label class="col-sm-2 text-gpromedix control-label">Sexo:</label>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
								<select id="sexo" name="sexo" class="populate placeholder">
									<option value="2">Seleccione</option>
									<option value="1">Hombre</option>
									<option value="0">Mujer</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group has-feedback">
						<label class="col-sm-2 text-gpromedix control-label">Estado civil:</label>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
								<select id="estadocivil" name="estadocivil" class="populate placeholder">
									    <option>Seleccione</option>
                                        <option value=0>Soltero/a</option>
                                        <option value=1>Casado/a</option>
                                        <option value=2>Divorciado/a</option>
                                        <option value=3>Viudo/a</option>
                                        <option value=4>En una relación</option>
                                        <option value=5>Acompañado/a</option>
                                  </select>
							</div>
						</div>
						
					</div>
					
					
					<div class="form-group has-feedback">
						<div class="col-sm-12 text-right">
							<a class="ajax-link action" href="#" id="consultar" onclick="busqueda();"><i class="fa fa-search fa-2x"></i><label class="boton-busqueda">Consultar</label></a>								
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
								<th>Edad</th>
								<th>Sexo</th>
								<th>Estado civil</th>
								<th>Fecha de ingreso</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
						<tfoot>
							<tr>
								<th>Nombre completo</th>
								<th>Edad</th>
								<th>Sexo</th>
								<th>Estado civil</th>
								<th>Fecha de ingreso</th>
							</tr>
						</tfoot>
					</table>
				</div>
				
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

///////////// FUNCION BUSQUEDA ////////////////////
function busqueda()
{
	var edad ="";
	var edad2 = "";
	var sexo = "";
	var estadocivil = "";
	
	edad = $("#edad").val();
	edad2 = $('#edad2').val();
	sexo = $("#sexo").val();
	estadocivil = $('#estadocivil').val();
	
	if(edad == null)
		{
		edad = "";
		}
	if(edad2 == null)
	{
	edad2 = "";
	}
	if(sexo == 2)
		{
		sexo = "";
		}
	if(estadocivil == 2)
		{
		estadocivil = "";
		}
	
	console.log("edad: "+edad);
		$.ajax
	({
		url: "SlReportePacientes",
		type: "post",
		datatype: 'html',
		data: {'edad' :edad, 'sexo' :sexo, 'estadocivil' : estadocivil, 'edad2' : edad2},
		success: function(data)
		{
			console.log("edad2: "+edad2);
			$('#datatable-2').html(data);
			$('#datatable-2').dataTable().fnDestroy();
			LoadDataTablesScripts(AllTables);
			
		}
	});
}

///////////////////////////// IMPRIMIR /////////////////////////////
function imprimir()
{
	var edad ="";
	var edad2= "";
	var sexo = "";
	var estadocivil = "";
	
	edad = $("#edad").val();
    edad2 = $('#edad2').val();
	sexo = $("#sexo").val();
	estadocivil = $('#estadocivil').val();
	
	if(edad == null)
	{
	edad = "";
	}
	if(sexo == 2)
	{
	sexo = "";
	}
	if(estadocivil == 2)
	{
	estadocivil = "";
	}
		
	window.open("SlReportePacientes?edad="+edad+"&sexo="+sexo+"&estadocivil="+estadocivil+"&edad2="+edad2, '_blank');
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
		$('#fecha_cita').datepicker({
			setDate : new Date(),
			dateFormat : 'dd-mm-yy',
			changeMonth: true,
			changeYear : true,
			yearRange : "-0:+200",
			minDate: "-0d"
		});


/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();	
	});
</script>