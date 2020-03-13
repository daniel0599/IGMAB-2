<%@page import="datos.*"%>
<%@page import="entidades.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; chaet=UTF-8"
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
		response.sendRedirect("../Home.jsp");
		return;
	}
	
	if(!permiso)
	{
		response.sendRedirect("error.jsp");
	}

%>
<input id="TipoRol" name="TipoRol" type="hidden" value=<%=r.getRolId()%>  checked>

<input id="usuarioID" name="usuarioID" type="hidden" value=<%=us.getUsuarioID()%> checked>

<%
if(r.getRolId() == 3 || r.getRolId() == 5){
%>	

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#" class="active ajax-link">Gestión paciente</a></li>
			<li><a href="#">Historia clínica</a></li>

		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Crear Historia Clinica</span>
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
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteId">
								<option value="">-- Selecciona el paciente --</option>
								<%
									//DtVHistoriaClinicaUnica dtpu = new DtVHistoriaClinicaUnica();
								DtPaciente dtpac = new DtPaciente();
								//rspso = dtpac.cargarPacientesAPsicologos(us.getUsuarioID());
									ResultSet rpu = dtpac.cargarPacientesAPsicologos(us.getUsuarioID());
									rpu.beforeFirst();

									while (rpu.next()) {
								%>

								<option value="<%=rpu.getInt("PacienteID")%>"><%=rpu.getString("Nombre1") + " " + rpu.getString("Nombre2") + " " + rpu.getString("Apellido1")
						+ " " + rpu.getString("Apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" lang="es" spellcheck="true" class="form-control" rows="5" id="motivoConsulta" required></textarea>
								<small id="rev_char_count"></small>  
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento actual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" 
									id="historiaPadecimiento" placeholder="Desde cuando, frecuencia, intensidad, qué ha hecho para manejar el problema o situación, sintomas, causas, tratamiento o soluciones anteriores, resultados y logro, a qué personas y de que manera afecta el problema? Situaciones ocurridas cercanas en el tiempo que puedan asociarse al origen del problema. Ocurre algo actualmente que pueda estar incidiendo en el problema, algún otro problema o situacion que le llame la atención"></textarea>
									<small id="historiaPadecimientorev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="expectativas" lang="es" spellcheck="true" placeholder="Como espera que se le ayude"></textarea>
								<small id="expectativasrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="antecedentesHeredoFamiliares" lang="es" spellcheck="true" placeholder="Enfermedades padecidas, medicamentos que tomo, alcohol u otras drogas, estado de animo, atención psiquiátrica y/o psicológica, suicidios, ideas, hospitalizaciones, caidas"></textarea>
									<small id="antecedentesHeredoFamiliaresrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPersonalesNoPatologicos" lang="es" spellcheck="true" placeholder="Vivienda y condiciones generales, alimentación, sueño, pasatiempos"></textarea>
									<small id="antecedentesPersonalesNoPatologicosrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPatologicosPersonales" lang="es" spellcheck="true" placeholder="Enfermedades padecidas, duración-cronocidad, hospitalización, tiempos. accidentes, caídas, crisis convulsivas, estado de salud actual" ></textarea>
									<small id="antecedentesPatologicosPersonalesrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPatologicosFamiliares" lang="es" spellcheck="true" placeholder="Enfermedades padecidas en la familia, fisicas y mentales, uso de drogas u alcohol, hospitalizaciones de la madre u otros cuidadores"></textarea>
									<small id="antecedentesPatologicosFamiliaresrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el núcleo familiar</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="relacionConElNucleoFamilar" lang="es" spellcheck="true" placeholder="Como es la relación con ellos, se integra, socializa, se retrae, se aísla, quienes viven con él/ella, describa relación con madre, padre, hermanos, esposo/a, otros, etc"></textarea>
									<small id="relacionConElNucleoFamilarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="areaEscolar" lang="es" spellcheck="true" placeholder="Historia escolar, edad de ingreso, adaptación inicial, preescolar; Ha tenido cambios de escuela, repetición de grado, porque? Habitos de estudio: tiempo dedicado, donde y cuando? Cambios de colegio, ultimos estudios"></textarea>
								<small id="areaEscolarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloSocial" lang="es" spellcheck="true" placeholder="Integración a las relaciones sociales con amigos y compañeros de clases, actividades sociales que realiza, frecuencia, intereses de trabajo y actividades libres, tiempo libre"></textarea>
								<small id="desarrolloSocialrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloLaboral" lang="es" spellcheck="true" placeholder="Últimos trabajos en orden cronologico, cargos que ocupaba, donde, cuanto tiempo, cuanto ganaba, porque salio"></textarea>
								<small id="desarrolloLaboralrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloSexual" lang="es" spellcheck="true" placeholder="Juegos sexuales infantiles, con quien, edad, manipulacion de genitales o masturbación, conocimientos, interés, educación sexual, abusos sexuales, primeras relaciones, menarquia, preparación, edad de inicio, vida sexual, con quien satisfactoria o no, porque? Frecuencia desde que inicio, cuantas parejas ha tenido, enfermedades de transmisión sexual"></textarea>
								<small id="desarrolloSexualrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloConyugal" lang="es" spellcheck="true" placeholder="Como es la relación de pareja, descripción, numero de hijos, abortos, descripción de comunicación, solución de problemas, satisfacción, comparten planes o actividades en común"></textarea>
								<small id="desarrolloConyugalrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="desarrolloEspiritual" lang="es" spellcheck="true" placeholder="Actividades de crecimiento personal, religiosas, comunitarias, otras"></textarea>
									<small id="desarrolloEspiritualrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="aspectoYConductaGeneral" lang="es" spellcheck="true"></textarea>
									<small id="aspectoYConductaGeneralrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y esté relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea maxlength="300" class="form-control" rows="5" id="algoMasAgregar" lang="es" spellcheck="true"></textarea>
								<small id="algoMasAgregarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresión
								diagnostica</label>
							<div class="col-sm-8">
								<textarea maxlength="1000"  class="form-control" rows="5"
									id="impresionDiagnostica" lang="es" spellcheck="true"></textarea>
									<small id="impresionDiagnosticarev_char_count"></small>
							</div>

						</div>

					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo" type="reset"
								class="ajax-link action btn btn-default btn-label-left">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button class="ajax-link action btn btn-primary btn-label-left"
								onClick="" title="Guardar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Guardar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>



<!-- Inicio de formulario para editar una historia clinica -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Actualizar Historia Clinica</span>
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
				<h4 class="page-header">Formulario de actualización</h4>
				<form class="form-horizontal" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="form-group">
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteEditar" disabled>
								<option value="">-- Selecciona el paciente --</option>
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
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="motivoConsultaEditar" lang="es" spellcheck="true"></textarea>
									<small id="Editarrev_char_count"></small>  
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="historiaPadecimientoEditar" lang="es" spellcheck="true"></textarea>
									<small id="historiaPadecimientoEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea class="form-control" maxlength="1000" rows="5" id="expectativasEditar" lang="es" spellcheck="true"></textarea>
								<small id="expectativasEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="antecedentesHeredoFamiliaresEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesHeredoFamiliaresEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPersonalesNoPatologicosEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPersonalesNoPatologicosEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPatologicosPersonalesEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPatologicosPersonalesEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPatologicosFamiliaresEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPatologicosFamiliaresEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el nucleo familiar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="relacionConElNucleoFamilarEditar" lang="es" spellcheck="true"></textarea>
									<small id="relacionConElNucleoFamilarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000" id="areaEscolarEditar" lang="es" spellcheck="true"></textarea>
								<small id="areaEscolarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloSocialEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloSocialEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloLaboralEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloLaboralEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloSexualEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloSexualEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloConyugalEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloConyugalEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloEspiritualEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloEspiritualEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="aspectoYConductaGeneralEditar" lang="es" spellcheck="true"></textarea>
									<small id="aspectoYConductaGeneralEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y este relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="300"
									id="algoMasAgregarEditar" lang="es" spellcheck="true"></textarea>
									<small id="algoMasAgregarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresion
								diagnostica</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="impresionDiagnosticaEditar" lang="es" spellcheck="true"></textarea>
									<small id="impresionDiagnosticaEditarrev_char_count"></small>
							</div>

						</div>

					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo_editar"
								class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button id="btnEditar"
								class="ajax-link btn btn-primary btn-label-left" onClick=""
								title="Editar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Editar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- fin formulario -->


<!-- Formulario para visualizar -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-visualizar" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-eye"></i> <span>Visualizar Historia Clinica</span>
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
				<form class="form-horizontal" method="post"
						action="javascript:void(0);" onsubmit="imprimir($('#btnImprimir').val());">
					<div class="form-group">
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteIdVi" disabled>
								<option value="">-- Selecciona el paciente --</option>
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
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="motivoConsultaVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="historiaPadecimientoVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="expectativasVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesHeredoFamiliaresVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPersonalesNoPatologicosVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPatologicosPersonalesVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPatologicosFamiliaresVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el nucleo familiar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="relacionConElNucleoFamilarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="areaEscolarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloSocialVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloLaboralVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloSexualVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="desarrolloConyugalVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="desarrolloEspiritualVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="aspectoYConductaGeneralVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y esté relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="algoMasAgregarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresión
								diagnostica</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="impresionDiagnosticaVi" disabled></textarea>
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
						
						<div class="col-sm-2">
										<button
											id="btnImprimir"
											class="ajax-link action btn btn-primary btn-label-left"
											onClick="" title="Imprimir">
											<span><i class="fa fa-print"></i></span>Imprimir
										</button>
									</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- fin -->


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
						pacientes</span>
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

				<table
					class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Paciente</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
						DtConsulta dtcon = new DtConsulta();
							DtVHistoriaClinicaPaciente dtc = new DtVHistoriaClinicaPaciente();
							rs = dtc.cargarVistaApsicologo(dtcon.obtenerPsicologoID(us.getUsuarioID())) ;
							rs.beforeFirst();
							while (rs.next()) {
						%>
						<tr>
							
                            <td><%=rs.getString("Nombre1") + " "+ rs.getString("Nombre2") + " " + rs.getString("Apellido1") + " "+ rs.getString("Apellido2")%> </td>
														<%
							if(r.getRolId() == 1){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<%
							} 
							%>
							<% 
							if(r.getRolId() == 2){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<% 	
							} 
							%>
							<% 
							if(r.getRolId() == 3){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>
								
									<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>

								
							</td>
							<% 	
							}
							%>
							<% 
							if(r.getRolId() == 4){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<%
							}
							%>
							<% 
							if(r.getRolId() == 5){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<%
							}
							%>
						</tr>
						<%
							}
						%>
					</tbody>
					<tfoot>
						<tr>
							<th>Paciente</th>
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
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#" class="active ajax-link">Gestión paciente</a></li>
			<li><a href="#">Historia clínica</a></li>

		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Crear Historia Clinica</span>
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
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteId">
								<option value="">-- Selecciona el paciente --</option>
								<%
									DtVHistoriaClinicaUnica dtpu = new DtVHistoriaClinicaUnica();
									ResultSet rpu = dtpu.cargarVista();
									rpu.beforeFirst();

									while (rpu.next()) {
								%>

								<option value="<%=rpu.getInt("pacienteID")%>"><%=rpu.getString("nombre1") + " " + rpu.getString("nombre2") + " " + rpu.getString("apellido1")
						+ " " + rpu.getString("apellido2")%></option>

								<%
									}
								%>
							</select>
						</div>
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" lang="es" spellcheck="true" class="form-control" rows="5" id="motivoConsulta" required></textarea>
								<small id="rev_char_count"></small>  
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento actual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" 
									id="historiaPadecimiento" placeholder="Desde cuando, frecuencia, intensidad, qué ha hecho para manejar el problema o situación, sintomas, causas, tratamiento o soluciones anteriores, resultados y logro, a qué personas y de que manera afecta el problema? Situaciones ocurridas cercanas en el tiempo que puedan asociarse al origen del problema. Ocurre algo actualmente que pueda estar incidiendo en el problema, algún otro problema o situacion que le llame la atención"></textarea>
									<small id="historiaPadecimientorev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="expectativas" lang="es" spellcheck="true" placeholder="Como espera que se le ayude"></textarea>
								<small id="expectativasrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="antecedentesHeredoFamiliares" lang="es" spellcheck="true" placeholder="Enfermedades padecidas, medicamentos que tomo, alcohol u otras drogas, estado de animo, atención psiquiátrica y/o psicológica, suicidios, ideas, hospitalizaciones, caidas"></textarea>
									<small id="antecedentesHeredoFamiliaresrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPersonalesNoPatologicos" lang="es" spellcheck="true" placeholder="Vivienda y condiciones generales, alimentación, sueño, pasatiempos"></textarea>
									<small id="antecedentesPersonalesNoPatologicosrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPatologicosPersonales" lang="es" spellcheck="true" placeholder="Enfermedades padecidas, duración-cronocidad, hospitalización, tiempos. accidentes, caídas, crisis convulsivas, estado de salud actual" ></textarea>
									<small id="antecedentesPatologicosPersonalesrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea maxlength="500" class="form-control" rows="5"
									id="antecedentesPatologicosFamiliares" lang="es" spellcheck="true" placeholder="Enfermedades padecidas en la familia, fisicas y mentales, uso de drogas u alcohol, hospitalizaciones de la madre u otros cuidadores"></textarea>
									<small id="antecedentesPatologicosFamiliaresrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el núcleo familiar</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="relacionConElNucleoFamilar" lang="es" spellcheck="true" placeholder="Como es la relación con ellos, se integra, socializa, se retrae, se aísla, quienes viven con él/ella, describa relación con madre, padre, hermanos, esposo/a, otros, etc"></textarea>
									<small id="relacionConElNucleoFamilarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="areaEscolar" lang="es" spellcheck="true" placeholder="Historia escolar, edad de ingreso, adaptación inicial, preescolar; Ha tenido cambios de escuela, repetición de grado, porque? Habitos de estudio: tiempo dedicado, donde y cuando? Cambios de colegio, ultimos estudios"></textarea>
								<small id="areaEscolarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloSocial" lang="es" spellcheck="true" placeholder="Integración a las relaciones sociales con amigos y compañeros de clases, actividades sociales que realiza, frecuencia, intereses de trabajo y actividades libres, tiempo libre"></textarea>
								<small id="desarrolloSocialrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloLaboral" lang="es" spellcheck="true" placeholder="Últimos trabajos en orden cronologico, cargos que ocupaba, donde, cuanto tiempo, cuanto ganaba, porque salio"></textarea>
								<small id="desarrolloLaboralrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloSexual" lang="es" spellcheck="true" placeholder="Juegos sexuales infantiles, con quien, edad, manipulacion de genitales o masturbación, conocimientos, interés, educación sexual, abusos sexuales, primeras relaciones, menarquia, preparación, edad de inicio, vida sexual, con quien satisfactoria o no, porque? Frecuencia desde que inicio, cuantas parejas ha tenido, enfermedades de transmisión sexual"></textarea>
								<small id="desarrolloSexualrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5" id="desarrolloConyugal" lang="es" spellcheck="true" placeholder="Como es la relación de pareja, descripción, numero de hijos, abortos, descripción de comunicación, solución de problemas, satisfacción, comparten planes o actividades en común"></textarea>
								<small id="desarrolloConyugalrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="desarrolloEspiritual" lang="es" spellcheck="true" placeholder="Actividades de crecimiento personal, religiosas, comunitarias, otras"></textarea>
									<small id="desarrolloEspiritualrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea maxlength="1000" class="form-control" rows="5"
									id="aspectoYConductaGeneral" lang="es" spellcheck="true"></textarea>
									<small id="aspectoYConductaGeneralrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y esté relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea maxlength="300" class="form-control" rows="5" id="algoMasAgregar" lang="es" spellcheck="true"></textarea>
								<small id="algoMasAgregarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresión
								diagnostica</label>
							<div class="col-sm-8">
								<textarea maxlength="1000"  class="form-control" rows="5"
									id="impresionDiagnostica" lang="es" spellcheck="true"></textarea>
									<small id="impresionDiagnosticarev_char_count"></small>
							</div>

						</div>

					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo" type="reset"
								class="ajax-link action btn btn-default btn-label-left">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button class="ajax-link action btn btn-primary btn-label-left"
								onClick="" title="Guardar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Guardar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>



<!-- Inicio de formulario para editar una historia clinica -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Actualizar Historia Clinica</span>
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
				<h4 class="page-header">Formulario de actualización</h4>
				<form class="form-horizontal" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="form-group">
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteEditar" disabled>
								<option value="">-- Selecciona el paciente --</option>
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
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="motivoConsultaEditar" lang="es" spellcheck="true"></textarea>
									<small id="Editarrev_char_count"></small>  
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="historiaPadecimientoEditar" lang="es" spellcheck="true"></textarea>
									<small id="historiaPadecimientoEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea class="form-control" maxlength="1000" rows="5" id="expectativasEditar" lang="es" spellcheck="true"></textarea>
								<small id="expectativasEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="antecedentesHeredoFamiliaresEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesHeredoFamiliaresEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPersonalesNoPatologicosEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPersonalesNoPatologicosEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPatologicosPersonalesEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPatologicosPersonalesEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="500"
									id="antecedentesPatologicosFamiliaresEditar" lang="es" spellcheck="true"></textarea>
									<small id="antecedentesPatologicosFamiliaresEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el nucleo familiar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="relacionConElNucleoFamilarEditar" lang="es" spellcheck="true"></textarea>
									<small id="relacionConElNucleoFamilarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000" id="areaEscolarEditar" lang="es" spellcheck="true"></textarea>
								<small id="areaEscolarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloSocialEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloSocialEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloLaboralEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloLaboralEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloSexualEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloSexualEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloConyugalEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloConyugalEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="desarrolloEspiritualEditar" lang="es" spellcheck="true"></textarea>
									<small id="desarrolloEspiritualEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="aspectoYConductaGeneralEditar" lang="es" spellcheck="true"></textarea>
									<small id="aspectoYConductaGeneralEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y este relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="300"
									id="algoMasAgregarEditar" lang="es" spellcheck="true"></textarea>
									<small id="algoMasAgregarEditarrev_char_count"></small>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresion
								diagnostica</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" maxlength="1000"
									id="impresionDiagnosticaEditar" lang="es" spellcheck="true"></textarea>
									<small id="impresionDiagnosticaEditarrev_char_count"></small>
							</div>

						</div>

					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo_editar"
								class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button id="btnEditar"
								class="ajax-link btn btn-primary btn-label-left" onClick=""
								title="Editar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Editar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- fin formulario -->


<!-- Formulario para visualizar -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div id="frm-visualizar" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-eye"></i> <span>Visualizar Historia Clinica</span>
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
				<form class="form-horizontal" method="post"
						action="javascript:void(0);" onsubmit="imprimir($('#btnImprimir').val());">
					<div class="form-group">
						<label class="col-sm-3 control-label">Seleccione paciente</label>
						<div class="col-sm-5">
							<select name="country" id="pacienteIdVi" disabled>
								<option value="">-- Selecciona el paciente --</option>
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
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Motivo
								de consulta</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="motivoConsultaVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Historia
								del padecimiento</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="historiaPadecimientoVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Expectativas</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="expectativasVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								Heredo-Familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesHeredoFamiliaresVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								personales no patologicos</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPersonalesNoPatologicosVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos personales</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPatologicosPersonalesVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Antecedentes
								patologicos familiares</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="antecedentesPatologicosFamiliaresVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Relación
								con el nucleo familiar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="relacionConElNucleoFamilarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Área
								escolar</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="areaEscolarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								social</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloSocialVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								laboral</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloLaboralVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								sexual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="desarrolloSexualVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								conyugal, pareja</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="desarrolloConyugalVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Desarrollo
								espiritual</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="desarrolloEspiritualVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Aspecto
								y conducta general</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="aspectoYConductaGeneralVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Alguna
								otra cosa que quiera decir y esté relacionadacon el problema del
								niño/a</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5" id="algoMasAgregarVi" disabled></textarea>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="form-styles">Impresión
								diagnostica</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="5"
									id="impresionDiagnosticaVi" disabled></textarea>
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
						
						<div class="col-sm-2">
										<button
											id="btnImprimir"
											class="ajax-link action btn btn-primary btn-label-left"
											onClick="" title="Imprimir">
											<span><i class="fa fa-print"></i></span>Imprimir
										</button>
									</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- fin -->


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
						pacientes</span>
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

				<table
					class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Paciente</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
							rs.close();
							rs=null;
						    
						    DtVHistoriaClinicaPaciente dtc = new DtVHistoriaClinicaPaciente();
							rs = dtc.cargarVista();
							rs.beforeFirst();
							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("Nombre1") + " "+ rs.getString("Nombre2") + " " + rs.getString("Apellido1") + " "+ rs.getString("Apellido2")%> </td>
							<%
							if(r.getRolId() == 1){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<%
							} 
							%>
							<% 
							if(r.getRolId() == 2){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<% 	
							} 
							%>
							<% 
							if(r.getRolId() == 3){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								
							</td>
							<% 	
							}
							%>
							<% 
							if(r.getRolId() == 4){
							%>
							<td>
								<button id="btnIdVisualizar"
									value=<%=rs.getInt("HistoriaclinicaID")%>
									class='ajax-link action btn btn-default btn-label-left'
									onClick="visualizarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
									'<%=rs.getString("Padecimientoactual")%>',
									'<%=rs.getString("Expectativa")%>',
									'<%=rs.getString("Padecimientoh_f")%>',
									'<%=rs.getString("Antecedentespersonalesnp")%>',
									'<%=rs.getString("Antecedentespatologicosp")%>',
									'<%=rs.getString("Antecedentespatologicosf")%>',
									'<%=rs.getString("Relacionnucleof")%>',
									'<%=rs.getString("Areaescolar")%>',
									'<%=rs.getString("Desarrollosocial")%>',
									'<%=rs.getString("Desarrollolaboral")%>',
									'<%=rs.getString("Desarrollosexual")%>',
									'<%=rs.getString("Desarrolloconyugal")%>',
									'<%=rs.getString("Desarrolloespiritual")%>',
									'<%=rs.getString("Aspectoconductageneral")%>',
									'<%=rs.getString("Algomasagregar")%>',
									'<%=rs.getString("Impresiondiagnostica")%>',
									'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span>
									Ver Historia Clinica
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									onclick="cargarDatos(this.value, '<%=rs.getString("Motivoconsulta")%>',
										'<%=rs.getString("Padecimientoactual")%>',
										'<%=rs.getString("Expectativa")%>',
										'<%=rs.getString("Padecimientoh_f")%>',
										'<%=rs.getString("Antecedentespersonalesnp")%>',
										'<%=rs.getString("Antecedentespatologicosp")%>',
										'<%=rs.getString("Antecedentespatologicosf")%>',
										'<%=rs.getString("Relacionnucleof")%>',
										'<%=rs.getString("Areaescolar")%>',
										'<%=rs.getString("Desarrollosocial")%>',
										'<%=rs.getString("Desarrollolaboral")%>',
										'<%=rs.getString("Desarrollosexual")%>',
										'<%=rs.getString("Desarrolloconyugal")%>',
										'<%=rs.getString("Desarrolloespiritual")%>',
										'<%=rs.getString("Aspectoconductageneral")%>',
										'<%=rs.getString("Algomasagregar")%>',
										'<%=rs.getString("Impresiondiagnostica")%>',
										'<%=rs.getInt("PacienteID")%>');"
									value=<%=rs.getInt("HistoriaclinicaID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
							</td>
							<%
							}
							%>
						</tr>
						<%
							}
						%>
					</tbody>
					<tfoot>
						<tr>
							<th>Paciente</th>
							<th>Acciones</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
 

<%
}
%>

<script type="text/javascript">
// 	var wsUri = "ws://localhost:8080/IGMAB/serverendpointigmab";
// 	var websocket = new WebSocket(wsUri); //creamos el socket

// 	websocket.onopen = function(evt) { //manejamos los eventos...
// 		console.log("Conectado...");
// 	};

// 	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
// 		//alert("Hubo cambio en la base de datos. Actualiza la página para verlos");
// 		//log("Mensaje recibido:" + evt.data);
// 		refrescar();

// 	};

// 	websocket.onerror = function(evt) {
// 		console.log("oho!.. error:" + evt.data);
// 	};

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar() {
		guardarHistoriaClinica();
		//websocket.send("Guardar");

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarHistoriaClinica(idClicked);
		//websocket.send("Modificar");
	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";

		$.ajax({
			url : "SlHistoriaClinica",
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
	function refrescarApsicologo() {
		var fusuarioID = "";
		fusuarioID = $('#usuarioID').val();
		var opcion = "";
		opcion = "refrescarApsicologo";

		$.ajax({
			url : "SlHistoriaClinica",
			type : "post",
			datatype : 'html',
			data : {
				'fusuarioID' : fusuarioID,
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


	//MÉTODO PARA GUARDAR EL REGISTRO A TRAVÉS DEL SERVLET
	function guardarHistoriaClinica() {
		 var tiporol =  0;
			tiporol = $('#TipoRol').val();
		var fpacienteId = 0;
		var fmotivoConsulta = "";
		var fhistoriaPadecimiento = "";
		var fexpectativas = "";
		var fantecedentesHeredoFamiliares = "";
		var fantecedentesPersonalesNoPatologicos = "";
		var fantecedentesPatologicosPersonales = "";
		var fantecedentesPatologicosFamiliares = "";
		var frelacionConElNucleoFamilar = "";
		var fareaEscolar = "";
		var fdesarrolloSocial = "";
		var fdesarrolloLaboral = "";
		var fdesarrolloSexual = "";
		var fdesarrolloConyugal = "";
		var fdesarrolloEspiritual = "";
		var faspectoYConductaGeneral = "";
		var falgoMasAgregar = "";
		var impresionDiagnostica = "";

		var opcion = "";

		opcion = "guardar";
		fpacienteId = $("#pacienteId").val();
		fmotivoConsulta = $("#motivoConsulta").val();
		fhistoriaPadecimiento = $("#historiaPadecimiento").val();
		fexpectativas = $("#expectativas").val();
		fantecedentesHeredoFamiliares = $("#antecedentesHeredoFamiliares")
				.val();
		fantecedentesPersonalesNoPatologicos = $(
				"#antecedentesPersonalesNoPatologicos").val();
		fantecedentesPatologicosPersonales = $(
				"#antecedentesPatologicosPersonales").val();
		fantecedentesPatologicosFamiliares = $(
				"#antecedentesPatologicosFamiliares").val();
		frelacionConElNucleoFamilar = $("#relacionConElNucleoFamilar").val();
		fareaEscolar = $("#areaEscolar").val();
		fdesarrolloSocial = $("#desarrolloSocial").val();
		fdesarrolloLaboral = $("#desarrolloLaboral").val();
		fdesarrolloSexual = $("#desarrolloSexual").val();
		fdesarrolloConyugal = $("#desarrolloConyugal").val();
		fdesarrolloEspiritual = $("#desarrolloEspiritual").val();
		faspectoYConductaGeneral = $("#aspectoYConductaGeneral").val();
		falgoMasAgregar = $("#algoMasAgregar").val();
		impresionDiagnostica = $("#impresionDiagnostica").val();

		$
				.ajax({
					url : "SlHistoriaClinica",
					type : "post",
					datatype : 'html',
					data : {
						'opcion' : opcion,
						'fpacienteId' : fpacienteId,
						'fmotivoConsulta' : fmotivoConsulta,
						'fhistoriaPadecimiento' : fhistoriaPadecimiento,
						'fexpectativas' : fexpectativas,
						'fantecedentesHeredoFamiliares' : fantecedentesHeredoFamiliares,
						'fantecedentesPersonalesNoPatologicos' : fantecedentesPersonalesNoPatologicos,
						'fantecedentesPatologicosPersonales' : fantecedentesPatologicosPersonales,
						'fantecedentesPatologicosFamiliares' : fantecedentesPatologicosFamiliares,
						'frelacionConElNucleoFamilar' : frelacionConElNucleoFamilar,
						'fareaEscolar' : fareaEscolar,
						'fdesarrolloSocial' : fdesarrolloSocial,
						'fdesarrolloLaboral' : fdesarrolloLaboral,
						'fdesarrolloSexual' : fdesarrolloSexual,
						'fdesarrolloConyugal' : fdesarrolloConyugal,
						'fdesarrolloEspiritual' : fdesarrolloEspiritual,
						'faspectoYConductaGeneral' : faspectoYConductaGeneral,
						'falgoMasAgregar' : falgoMasAgregar,
						'impresionDiagnostica' : impresionDiagnostica
					},
					success : function(data) {
						if(tiporol == 3 || tiporol == 5){
							$("#pacienteId").val(null);
							$("#motivoConsulta").val(null);
							$("#historiaPadecimiento").val(null);
							$("#expectativas").val(null);
							$("#antecedentesHeredoFamiliares").val(null);
							$("#antecedentesPersonalesNoPatologicos").val(null);
							$("#antecedentesPatologicosPersonales").val(null);
							$("#antecedentesPatologicosFamiliares").val(null);
							$("#relacionConElNucleoFamilar").val(null);
							$("#areaEscolar").val(null);
							$("#desarrolloSocial").val(null);
							$("#desarrolloLaboral").val(null);
							$("#desarrolloSexual").val(null);
							$("#desarrolloConyugal").val(null);
							$("#desarrolloEspiritual").val(null);
							$("#aspectoYConductaGeneral").val(null);
							$("#algoMasAgregar").val(null);
							$("#impresionDiagnostica").val(null);
							$('#frm-agrega').fadeOut();
							//websocket.send("Guardar");
							refrescarApsicologo();
							successAlert('Listo', 'Guardado exitosamente');

							
						}else{
							$("#pacienteId").val(null);
							$("#motivoConsulta").val(null);
							$("#historiaPadecimiento").val(null);
							$("#expectativas").val(null);
							$("#antecedentesHeredoFamiliares").val(null);
							$("#antecedentesPersonalesNoPatologicos").val(null);
							$("#antecedentesPatologicosPersonales").val(null);
							$("#antecedentesPatologicosFamiliares").val(null);
							$("#relacionConElNucleoFamilar").val(null);
							$("#areaEscolar").val(null);
							$("#desarrolloSocial").val(null);
							$("#desarrolloLaboral").val(null);
							$("#desarrolloSexual").val(null);
							$("#desarrolloConyugal").val(null);
							$("#desarrolloEspiritual").val(null);
							$("#aspectoYConductaGeneral").val(null);
							$("#algoMasAgregar").val(null);
							$("#impresionDiagnostica").val(null);
							$('#frm-agrega').fadeOut();
							//websocket.send("Guardar");
							refrescar();
							successAlert('Listo', 'Guardado exitosamente');

					
						}
						
					}

				});

	}

	//Metodo para actualizar
	function actualizarHistoriaClinica(idClicked) {
		var tiporol =  0;
		tiporol = $('#TipoRol').val();
		var fHistoriaClinicaId = idClicked;
		var fmotivoConsultEditar = "";
		var fhistoriaPadecimientoEditar = "";
		var fexpectativasEditar = "";
		var fantecedentesHeredoFamiliaresEditar = "";
		var fantecedentesPersonalesNoPatologicosEditar = "";
		var fantecedentesPatologicosPersonalesEditar = "";
		var fantecedentesPatologicosFamiliaresEditar = "";
		var frelacionConElNucleoFamilarEditar = "";
		var fareaEscolarEditar = "";
		var fdesarrolloSocialEditar = "";
		var fdesarrolloLaboralEditar = "";
		var fdesarrolloSexualEditar = "";
		var fdesarrolloConyugalEditar = "";
		var fdesarrolloEspiritualEditar = "";
		var faspectoYConductaGeneralEditar = "";
		var falgoMasAgregarEditar = "";
		var impresionDiagnosticaEditar = "";
		var fpacienetIdEditar="";

		opcion = "actualizar";
		
		fpacienteIdEditar = $("#pacienteEditar").val();
		fmotivoConsultaEditar = $("#motivoConsultaEditar").val();
		fhistoriaPadecimientoEditar = $("#historiaPadecimientoEditar").val();
		fexpectativasEditar = $("#expectativasEditar").val();
		fantecedentesHeredoFamiliaresEditar = $("#antecedentesHeredoFamiliaresEditar").val();
		fantecedentesPersonalesNoPatologicosEditar = $("#antecedentesPersonalesNoPatologicosEditar").val();
		fantecedentesPatologicosPersonalesEditar = $("#antecedentesPatologicosPersonalesEditar").val();
		fantecedentesPatologicosFamiliaresEditar = $("#antecedentesPatologicosFamiliaresEditar").val();
		frelacionConElNucleoFamilarEditar = $("#relacionConElNucleoFamilarEditar").val();
		fareaEscolarEditar = $("#areaEscolarEditar").val();
		fdesarrolloSocialEditar = $("#desarrolloSocialEditar").val();
		fdesarrolloLaboralEditar = $("#desarrolloLaboralEditar").val();
		fdesarrolloSexualEditar = $("#desarrolloSexualEditar").val();
		fdesarrolloConyugalEditar = $("#desarrolloConyugalEditar").val();
		fdesarrolloEspiritualEditar = $("#desarrolloEspiritualEditar").val();
		faspectoYConductaGeneralEditar = $("#aspectoYConductaGeneralEditar").val();
		falgoMasAgregarEditar = $("#algoMasAgregarEditar").val();
		impresionDiagnosticaEditar = $("#impresionDiagnosticaEditar").val();

		$
				.ajax({
					url : "SlHistoriaClinica",
					type : "post",
					datatype : 'html',
					data : {

						'opcion' : opcion,
						'fHistoriaClinicaId' : fHistoriaClinicaId,
						'fpacienteIdEditar' : fpacienteIdEditar,
						'fmotivoConsultaEditar' : fmotivoConsultaEditar,
						'fhistoriaPadecimientoEditar' : fhistoriaPadecimientoEditar,
						'fexpectativasEditar' : fexpectativasEditar,
						'fantecedentesHeredoFamiliaresEditar' : fantecedentesHeredoFamiliaresEditar,
						'fantecedentesPersonalesNoPatologicosEditar' : fantecedentesPersonalesNoPatologicosEditar,
						'fantecedentesPatologicosPersonalesEditar' : fantecedentesPatologicosPersonalesEditar,
						'fantecedentesPatologicosFamiliaresEditar' : fantecedentesPatologicosFamiliaresEditar,
						'frelacionConElNucleoFamilarEditar' : frelacionConElNucleoFamilarEditar,
						'fareaEscolarEditar' : fareaEscolarEditar,
						'fdesarrolloSocialEditar' : fdesarrolloSocialEditar,
						'fdesarrolloLaboralEditar' : fdesarrolloLaboralEditar,
						'fdesarrolloSexualEditar' : fdesarrolloSexualEditar,
						'fdesarrolloConyugalEditar' : fdesarrolloConyugalEditar,
						'fdesarrolloEspiritualEditar' : fdesarrolloEspiritualEditar,
						'faspectoYConductaGeneralEditar' : faspectoYConductaGeneralEditar,
						'falgoMasAgregarEditar' : falgoMasAgregarEditar,
						'impresionDiagnosticaEditar' : impresionDiagnosticaEditar
					},
					success : function(data) {
						if(tiporol == 3 || tiporol == 5){
							$("#motivoConsultaEditar").val(null);
							$("#historiaPadecimientoEditar").val(null);
							$("#expectativasEditar").val(null);
							$("#antecedentesHeredoFamiliaresEditar").val(null);
							$("#antecedentesPersonalesNoPatologicosEditar").val(null);
							$("#antecedentesPatologicosPersonalesEditar").val(null);
							$("#antecedentesPatologicosFamiliaresEditar").val(null);
							$("#relacionConElNucleoFamilarEditar").val(null);
							$("#areaEscolarEditar").val(null);
							$("#desarrolloSocialEditar").val(null);
							$("#desarrolloLaboralEditar").val(null);
							$("#desarrolloSexualEditar").val(null);
							$("#desarrolloConyugalEditar").val(null);
							$("#desarrolloEspiritualEditar").val(null);
							$("#aspectoYConductaGeneralEditar").val(null);
							$("#algoMasAgregarEditar").val(null);
							$("#impresionDiagnosticaEditar").val(null);

							//websocket.send("Modificar");
							refrescarApsicologo();
							$('#frm-edita').fadeOut();
							successAlert('Listo', 'Actualizado exitosamente');

						}else{
							$("#motivoConsultaEditar").val(null);
							$("#historiaPadecimientoEditar").val(null);
							$("#expectativasEditar").val(null);
							$("#antecedentesHeredoFamiliaresEditar").val(null);
							$("#antecedentesPersonalesNoPatologicosEditar").val(null);
							$("#antecedentesPatologicosPersonalesEditar").val(null);
							$("#antecedentesPatologicosFamiliaresEditar").val(null);
							$("#relacionConElNucleoFamilarEditar").val(null);
							$("#areaEscolarEditar").val(null);
							$("#desarrolloSocialEditar").val(null);
							$("#desarrolloLaboralEditar").val(null);
							$("#desarrolloSexualEditar").val(null);
							$("#desarrolloConyugalEditar").val(null);
							$("#desarrolloEspiritualEditar").val(null);
							$("#aspectoYConductaGeneralEditar").val(null);
							$("#algoMasAgregarEditar").val(null);
							$("#impresionDiagnosticaEditar").val(null);

							//websocket.send("Modificar");
							refrescar();
							$('#frm-edita').fadeOut();
							successAlert('Listo', 'Actualizado exitosamente');

						}
						
					}

				});

	}
	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO

	function cargarDatos(historiaClinicaId, motivoConsulta,
			historiaPadecimiento, expectativas, antecedentesHeredoFamiliares,
			antecedentesPersonalesNoPatologicos,
			antecedentesPatologicosPersonales,
			antecedentesPatologicosFamiliares, relacionConElNucleoFamilar,
			areaEscolar, desarrolloSocial, desarrolloLaboral, desarrolloSexual,
			desarrolloConyugal, desarrolloEspiritual, aspectoYConductaGeneral,
			algoMasAgregar, impresionDiagnostica,pacienteId) {

		var fhistoriaClinicaId = historiaClinicaId;
		var fpacienteId = pacienteId;
		var fmotivoConsulta = motivoConsulta;
		var fhistoriaPadecimiento = historiaPadecimiento;
		var fexpectativas = expectativas;
		var fantecedentesHeredoFamiliares = antecedentesHeredoFamiliares;
		var fantecedentesPersonalesNoPatologicos = antecedentesPersonalesNoPatologicos;
		var fantecedentesPatologicosPersonales = antecedentesPatologicosPersonales;
		var fantecedentesPatologicosFamiliares = antecedentesPatologicosFamiliares;
		var frelacionConElNucleoFamilar = relacionConElNucleoFamilar;
		var fareaEscolar = areaEscolar;
		var fdesarrolloSocial = desarrolloSocial;
		var fdesarrolloLaboral = desarrolloLaboral;
		var fdesarrolloSexual = desarrolloSexual;
		var fdesarrolloConyugal = desarrolloConyugal;
		var fdesarrolloEspiritual = desarrolloEspiritual;
		var faspectoYConductaGeneral = aspectoYConductaGeneral;
		var falgoMasAgregar = algoMasAgregar;
		var fimpresionDiagnostica = impresionDiagnostica;

		$('#btnEditar').val(fhistoriaClinicaId);
		$("#pacienteEditar").val(fpacienteId).change();
		$("#motivoConsultaEditar").val(fmotivoConsulta);
		$("#historiaPadecimientoEditar").val(fhistoriaPadecimiento);
		$("#expectativasEditar").val(fexpectativas);
		$("#antecedentesHeredoFamiliaresEditar").val(fantecedentesHeredoFamiliares);
		$("#antecedentesPersonalesNoPatologicosEditar").val(fantecedentesPersonalesNoPatologicos);
		$("#antecedentesPatologicosPersonalesEditar").val(fantecedentesPatologicosPersonales);
		$("#antecedentesPatologicosFamiliaresEditar").val(fantecedentesPatologicosFamiliares);
		$("#relacionConElNucleoFamilarEditar").val(frelacionConElNucleoFamilar);
		$("#areaEscolarEditar").val(areaEscolar);
		$("#desarrolloSocialEditar").val(fdesarrolloSocial);
		$("#desarrolloLaboralEditar").val(fdesarrolloLaboral);
		$("#desarrolloSexualEditar").val(fdesarrolloSexual);
		$("#desarrolloConyugalEditar").val(fdesarrolloConyugal);
		$("#desarrolloEspiritualEditar").val(fdesarrolloEspiritual);
		$("#aspectoYConductaGeneralEditar").val(faspectoYConductaGeneral);
		$("#algoMasAgregarEditar").val(falgoMasAgregar);
		$("#impresionDiagnosticaEditar").val(fimpresionDiagnostica);

		$('#frm-edita').fadeIn();
		$('#frm-agrega').fadeOut();
		$('#frm-visualizar').fadeOut();

	}

	// Formulario para visualizar
	function visualizarDatos(historiaClinicaId, motivoConsulta,
			historiaPadecimiento, expectativas, antecedentesHeredoFamiliares,
			antecedentesPersonalesNoPatologicos,
			antecedentesPatologicosPersonales,
			antecedentesPatologicosFamiliares, relacionConElNucleoFamilar,
			areaEscolar, desarrolloSocial, desarrolloLaboral, desarrolloSexual,
			desarrolloConyugal, desarrolloEspiritual, aspectoYConductaGeneral,
			algoMasAgregar, impresionDiagnostica, pacienteId) {

		var fhistoriaClinicaId = historiaClinicaId;
		var fpacienteId = pacienteId;
		var fmotivoConsulta = motivoConsulta;
		var fhistoriaPadecimiento = historiaPadecimiento;
		var fexpectativas = expectativas;
		var fantecedentesHeredoFamiliares = antecedentesHeredoFamiliares;
		var fantecedentesPersonalesNoPatologicos = antecedentesPersonalesNoPatologicos;
		var fantecedentesPatologicosPersonales = antecedentesPatologicosPersonales;
		var fantecedentesPatologicosFamiliares = antecedentesPatologicosFamiliares;
		var frelacionConElNucleoFamilar = relacionConElNucleoFamilar;
		var fareaEscolar = areaEscolar;
		var fdesarrolloSocial = desarrolloSocial;
		var fdesarrolloLaboral = desarrolloLaboral;
		var fdesarrolloSexual = desarrolloSexual;
		var fdesarrolloConyugal = desarrolloConyugal;
		var fdesarrolloEspiritual = desarrolloEspiritual;
		var faspectoYConductaGeneral = aspectoYConductaGeneral;
		var falgoMasAgregar = algoMasAgregar;
		var fimpresionDiagnostica = impresionDiagnostica;

		$('#btnImprimir').val(historiaClinicaId);
		
		$('#btnIdActualizar').val(fhistoriaClinicaId);
		$("#pacienteIdVi").val(fpacienteId).change();
		$("#motivoConsultaVi").val(fmotivoConsulta);
		$("#historiaPadecimientoVi").val(fhistoriaPadecimiento);
		$("#expectativasVi").val(fexpectativas);
		$("#antecedentesHeredoFamiliaresVi").val(fantecedentesHeredoFamiliares);
		$("#antecedentesPersonalesNoPatologicosVi").val(fantecedentesPersonalesNoPatologicos);
		$("#antecedentesPatologicosPersonalesVi").val(fantecedentesPatologicosPersonales);
		$("#antecedentesPatologicosFamiliaresVi").val(fantecedentesPatologicosFamiliares);
		$("#relacionConElNucleoFamilarVi").val(frelacionConElNucleoFamilar);
		$("#areaEscolarVi").val(areaEscolar);
		$("#desarrolloSocialVi").val(fdesarrolloSocial);
		$("#desarrolloLaboralVi").val(fdesarrolloLaboral);
		$("#desarrolloSexualVi").val(fdesarrolloSexual);
		$("#desarrolloConyugalVi").val(fdesarrolloConyugal);
		$("#desarrolloEspiritualVi").val(fdesarrolloEspiritual);
		$("#aspectoYConductaGeneralVi").val(faspectoYConductaGeneral);
		$("#algoMasAgregarVi").val(falgoMasAgregar);
		$("#impresionDiagnosticaVi").val(fimpresionDiagnostica);

		$('#frm-edita').fadeOut();
		$('#frm-agrega').fadeOut();
		$('#frm-visualizar').fadeIn();

	}
	function imprimir(historiaClinicaId){
		window.open("SlReporteHistoriaClinica?historiaClinicaId="+historiaClinicaId, '_blank');
	}
	//Fin
	


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
		
		//Contadores de caracteres
		$('#motivoConsulta').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#rev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		
		$('#historiaPadecimiento').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#historiaPadecimientorev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#expectativas').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#expectativasrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesHeredoFamiliares').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesHeredoFamiliaresrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPersonalesNoPatologicos').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPersonalesNoPatologicosrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPatologicosPersonales').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPatologicosPersonalesrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPatologicosFamiliares').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPatologicosFamiliaresrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#relacionConElNucleoFamilar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#relacionConElNucleoFamilarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#areaEscolar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#areaEscolarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloSocial').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloSocialrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloLaboral').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloLaboralrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloConyugal').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloConyugalrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloEspiritual').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloEspiritualrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#aspectoYConductaGeneral').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#aspectoYConductaGeneralrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloSexual').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloSexualrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#algoMasAgregar').on('input propertychange', function() {
			var max_len = 300;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#algoMasAgregarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#impresionDiagnostica').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#impresionDiagnosticarev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		
		//Editar
		$('#motivoConsultaEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#Editarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		
		$('#historiaPadecimientoEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#historiaPadecimientoEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#expectativasEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#expectativasEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesHeredoFamiliaresEditar').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesHeredoFamiliaresEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPersonalesNoPatologicosEditar').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPersonalesNoPatologicosEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPatologicosPersonalesEditar').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPatologicosPersonalesEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#antecedentesPatologicosFamiliaresEditar').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#antecedentesPatologicosFamiliaresEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#relacionConElNucleoFamilarEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#relacionConElNucleoFamilarEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#areaEscolarEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#areaEscolarEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloSocialEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloSocialEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloLaboralEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloLaboralEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloConyugalEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloConyugalEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloEspiritualEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloEspiritualEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#aspectoYConductaGeneralEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#aspectoYConductaGeneralEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#desarrolloSexualEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#desarrolloSexualEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#algoMasAgregarEditar').on('input propertychange', function() {
			var max_len = 300;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#algoMasAgregarEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		$('#impresionDiagnosticaEditar').on('input propertychange', function() {
			var max_len = 1000;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#impresionDiagnosticaEditarrev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		//fin de contadores
		$('#frm-agrega').hide();
		$('#frm-edita').hide();
		$('#frm-visualizar').hide();
		// Initialize datepicker
		$('#fecha').datepicker({
			setDate : new Date()
		});
		$('#fechaEditar').datepicker({
			setDate : new Date()
		});

		// Load Timepicker plugin
		/*LoadTimePickerScript(TimePicker);*/

		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		LoadDataTablesScripts(AllTables);
		$('.form-control').tooltip();

		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
		
				$('#frm-agrega').fadeIn();
				$('#frm-edita').fadeOut()
				$('frm-visualizar').fadeOut();
			
		
			
		});
		$('#cancelar_nuevo').click(function() {
			$('#frm-agrega').fadeOut();
		});
		$('#cancelar_nuevo_editar').click(function() {
			$('#frm-edita').fadeOut();
		});
		$('#cerrar_visualizar').click(function() {
			$('#frm-visualizar').fadeOut();
		});
		
		//asd
		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();
	});
</script>