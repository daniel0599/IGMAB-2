  <%@page import="entidades.*"%>
<%@page import="java.sql.ResultSet, java.text.SimpleDateFormat, java.util.Date"%>
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
	
	
	ResultSet rs = null;
	
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
	
	DtRespuesta dtres = new DtRespuesta();

%>
<input id="usuarioID" name="usuarioID" type="hidden" value=<%=us.getUsuarioID()%> checked>

<input id="TipoRol" name="TipoROl" type="hidden" value=<%=r.getRolId()%>  checked>
								
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Gestión paciente</a></li>
			<li><a href="#">Paciente</a></li>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<!-- Inicio de formulario para agregar paciente -->
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                <div id="frm-agrega" class="box">
                    <div class="box-header">
                        <div class="box-name">
                            <i class="fa fa-address-card-o"></i> <span>Registro de Paciente</span>
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
                        <form id="agregar" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="guardar();">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Primer nombre</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Primer nombre" data-toggle="tooltip"
                                           data-placement="bottom" id="nombre1" name="nombre1"
                                           title="El primer nombre es requerido" required />
                                </div>
                                <label class="col-sm-2 control-label">Segundo nombre</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Segundo nombre" data-toggle="tooltip"
                                           data-placement="bottom" id="nombre2" name="nombre2"
                                           title="El segundo nombre no es requerido"  />
                                </div>
                                <label class="col-sm-2 control-label">Primer apellido</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Primer apellido" data-toggle="tooltip"
                                           data-placement="bottom" id="apellido1" name="apellido1"
                                           title="El primer apellido es requerido" required />
                                </div>
                                <label class="col-sm-2 control-label">Segundo apellido</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Segundo apellido" data-toggle="tooltip"
                                           data-placement="bottom" id="apellido2" name="apellido2"
                                           title="El segundo apellido no es requerido" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Celular</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Número de celular" data-toggle="tooltip"
                                           data-placement="bottom" id="celular" name="celular"
                                           title="El número de celular no es requerido" />
                                </div>
                                <input type="hidden" class="form-control"
                                       placeholder="Edad" data-toggle="tooltip"
                                       data-placement="bottom" id="edad" name="edad"
                                       title="La edad es requerida" />


                                <label class="col-sm-2 control-label">Fecha de
                                    nacimiento</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                            placeholder="Fecha de nacimiento" data-toggle="tooltip"
                                            data-placement="bottom" id="fechaNac" name="fechaNac"
                                            title="La fecha de nacimiento es requerida" required />
                                </div>
                                <label class="col-sm-2 control-label">Sexo</label>
                                <div class="col-sm-4">
                                    <select id="sexo">
                                        <option>Seleccione</option>
                                        <option value=1>Hombre</option>
                                        <option value=0>Mujer</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 control-label">Estado civil</label>
                                <div class="col-sm-4">
                                    <select id="estadoCivil">
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

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Escolaridad</label>
                                <div class="col-sm-2">
                                    <select id="escolaridadId" required>
                                        <option value="">Seleccione la escolaridad</option>
                                        <%
                                            DtPaciente dtpp = new DtPaciente();
                                            ResultSet res = dtpp.cargarEscolaridades();
                                            res.beforeFirst();

                                            while (res.next()) {
                                        %>

                                        <option value="<%=res.getInt("EscolaridadID")%>"><%=res.getString("Nombre")%></option>

                                        <%
                                            }
                                        %>
                                    </select>
                                    <div class="checkbox">
                                    <label>Estudiante UCA
                                    <input type="checkbox" id="estudianteUCA">
                                    <i class="fa fa-square-o small"></i>
                                    </label>
                                    </div>

                                </div>

                                <div class="col-sm-2">
                                    <input type="text" class="form-control"
                                           placeholder="Escolaridad" data-toggle="tooltip"
                                           data-placement="bottom" id="escolaridad" name="escolaridad"
                                           title="La escolaridad es requerida" required />
                                </div>

                                <label class="col-sm-2 control-label">Dirección</label>
                                <div class="col-sm-4">
                                    <textarea maxlength="500" class="form-control" rows="4" id="direccion" lang="es" spellcheck="true"></textarea>
                                    <small id="expectativasrev_char_count"></small>
                                </div>

                                <label class="col-sm-2 control-label">Con quién vive</label>
                                <div class="col-sm-4">
                                    <select id="conQuienVive">
                                        <option>Seleccione</option>
                                        <option value="Solo/a">Solo/a</option>
					<option value="Madre">Madre</option>
                                        <option value="Padre">Padre</option>
                                        <option value="AbuelaMaterna">Abuela Materna</option>
                                        <option value="AbueloMaterno">Abuelo Materno</option>
                                        <option value="Abuela Paterna">Abuela Paterna</option>
                                        <option value="AbueloPaterno">Abuelo Paterno</option>
                                        <option value="Padres">Padres</option>
                                        <option value="Cónyuge">Cónyuge</option>
                                        <option value="Familia Nuclear">Familia Nuclear</option>
                                        <option value="Familia Externa">Familia Externa</option> 
                                        <option value="Otros">Otros</option>
                                    </select>
                                </div>

                                <label class="col-sm-2 control-label">Empleo</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Empleo/trabajo desempeñado"
                                           data-toggle="tooltip" data-placement="bottom" id="empleo"
                                           name="empleo" title="El empleo no es requerido" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Salario</label>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control"
                                           placeholder="Cantidad ganada en el trabajo desempeñado"
                                           data-toggle="tooltip" data-placement="bottom" id="salario"
                                           name="salario" title="El salario no es requerido" />
                                </div>
                                <label class="col-sm-2 control-label">Lugar de trabajo</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"
                                           placeholder="Lugar donde trabaja" data-toggle="tooltip"
                                           data-placement="bottom" id="lugarTrabajo" name="lugarTrabajo"
                                           title="El lugar de trabajo no es requerido" />
                                </div>
                                <label class="col-sm-2 control-label">¿Ha estado en
                                    terapia o recibido asistencia profesional para
                                    sus problemas?</label>
                                <div class="col-sm-4">
                                    <select id="terapia" required>
                                        <option>Seleccione</option>
                                        <option value=1>Sí</option>
                                        <option value=0>No</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 control-label">¿Ha estado internado por problemas psicológicos/psiquiátricos?</label>
                                <div class="col-sm-4">
                                    <select id="internado" required>
                                        <option>Seleccione</option>
                                        <option value=1>Sí</option>
                                        <option value=0>No</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" id="internadoGroup">
                                <label class="col-sm-2 control-label">En caso
                                    afirmativo:</label>
                                <div class="col-sm-4">
										<textarea class="form-control"
                                                  placeholder="¿Cuándo? ¿Dónde? ¿Por qué?"
                                                  data-toggle="tooltip" data-placement="bottom"
                                                  id="internadoAfirmativo" name="internadoAfirmativo"
                                                  title="No es requerido" lang="es" spellcheck="true" rows="5"></textarea>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="form-group">
                                <div id="cancelar_nuevo" class="col-sm-offset-2 col-sm-2">
                                    <button class="ajax-link action btn btn-default btn-label-left"
                                            type="reset" title="Cancelar">
                                        <span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
                                    </button>
                                </div>
                                <div class="col-sm-2">
                                    <button class="ajax-link action btn btn-primary btn-label-left"
                                            onClick="" title="Guardar">
                                        <span><i class="fa fa-check-circle txt-success"></i></span>Guardar
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Inicio de formulario para editar paciente -->
         <div class="row">
            <div class="col-xs-12 col-sm-12">
                <div id="frm-edita" class="box">
                    <div class="box-header">
                        <div class="box-name">
                            <i class="fa fa-file-text-o"></i> <span>Editar Paciente</span>
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
            <form id="edit" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Primer nombre</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Primer nombre" data-toggle="tooltip"
                               data-placement="bottom" id="nombre1Edit" name="nombre1"
                               title="El primer nombre es requerido" required />
                    </div>
                    <label class="col-sm-2 control-label">Segundo nombre</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Segundo nombre" data-toggle="tooltip"
                               data-placement="bottom" id="nombre2Edit" name="nombre2"
                               title="El segundo nombre no es requerido"  />
                    </div>
                    <label class="col-sm-2 control-label">Primer apellido</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Primer nombre" data-toggle="tooltip"
                               data-placement="bottom" id="apellido1Edit" name="apellido1"
                               title="El primer apellido es requerido" required />
                    </div>
                    <label class="col-sm-2 control-label">Segundo apellido</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Segundo apellido" data-toggle="tooltip"
                               data-placement="bottom" id="apellido2Edit" name="apellido2"
                               title="El segundo apellido no es requerido" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">Celular</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Número de celular" data-toggle="tooltip"
                               data-placement="bottom" id="celularEdit" name="celular"
                               title="El número de celular no es requerido" />

                    </div>

                    <input type="hidden" class="form-control"
                           placeholder="Edad" data-toggle="tooltip"
                           data-placement="bottom" id="edadEdit" name="edad"
                           title="La edad es requerida" />


                    <label class="col-sm-2 control-label">Fecha de
                        nacimiento</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Fecha de nacimiento" data-toggle="tooltip"
                               data-placement="bottom" id="fechaNacEdit" name="fechaNac"
                               title="La fecha de nacimiento es requerida" required />
                    </div>
                    <label class="col-sm-2 control-label">Sexo</label>
                    <div class="col-sm-4">
                        <select id="sexoEdit">
                            <option>Seleccione</option>
                            <option value=1>Hombre</option>
                            <option value=0>Mujer</option>
                        </select>
                    </div>
                    <label class="col-sm-2 control-label">Estado civil</label>
                    <div class="col-sm-4">
                        <select id="estadoCivilEdit">
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

                <div class="form-group">
                    <label class="col-sm-2 control-label">Escolaridad</label>
                    <div class="col-sm-2">
                        <select id="escolaridadIdEdit" required>
                            <option value="">Seleccione la escolaridad</option>
                            <%

                                res.beforeFirst();

                                while (res.next()) {
                            %>

                            <option value="<%=res.getInt("EscolaridadID")%>"><%=res.getString("Nombre")%></option>

                            <%
                                }
                            %>
                        </select>
                        <div class="checkbox">
                            <label>Estudiante UCA
                                <input type="checkbox" id="estudianteUCAEdit">
                                <i class="fa fa-square-o small"></i>
                            </label>
                        </div>
                    </div>

                    <div class="col-sm-2">
                        <input type="text" class="form-control"
                               placeholder="Escolaridad" data-toggle="tooltip"
                               data-placement="bottom" id="escolaridadEdit" name="escolaridad"
                               title="La escolarida es requerida" required />
                    </div>

                    <label class="col-sm-2 control-label">Dirección</label>
                    <div class="col-sm-4">
                        <textarea maxlength="500" class="form-control" rows="5" id="direccionEdit" lang="es" spellcheck="true"></textarea>
                        <small id="expectativasrev_char_count"></small>
                    </div>

                    <label class="col-sm-2 control-label">Con quién vive</label>
                    <div class="col-sm-4">
                        <select id="conQuienViveEdit">
                            <option>Seleccione</option>
                            <option value="Solo/a">Solo/a</option>
				<option value="Madre">Madre</option>
                            <option value="Padre">Padre</option>
                            <option value="AbuelaMaterna">Abuela Materna</option>
                            <option value="AbueloMaterno">Abuelo Materno</option>
                            <option value="Abuela Paterna">Abuela Paterna</option>
                            <option value="AbueloPaterno">Abuelo Paterno</option>
                            <option value="Padres">Padres</option>
                            <option value="Cónyuge">Cónyuge</option>
                            <option value="Familia Nuclear">Familia Nuclear</option>
                            <option value="Familia Nuclear">Familia Externa</option>
                            <option value="Otros">Otros</option>
                        </select>
                    </div>
                    <label class="col-sm-2 control-label">Empleo</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Empleo/trabajo desempeñado"
                               data-toggle="tooltip" data-placement="bottom" id="empleoEdit"
                               name="empleo" title="El empleo no es requerido" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">Salario</label>
                    <div class="col-sm-4">
                        <input type="number" class="form-control"
                               placeholder="Cantidad ganada en el trabajo desempeñado"
                               data-toggle="tooltip" data-placement="bottom" id="salarioEdit"
                               name="salario" title="El salario no es requerido" />
                    </div>
                    <label class="col-sm-2 control-label">Lugar de trabajo</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"
                               placeholder="Lugar donde trabaja" data-toggle="tooltip"
                               data-placement="bottom" id="lugarTrabajoEdit" name="lugarTrabajo"
                               title="El lugar de trabajo no es requerido" />
                    </div>
                    <label class="col-sm-2 control-label">¿Ha estado en
                        terapia o recibido asistencia profesional para
                        sus problemas?</label>
                    <div class="col-sm-4">
                        <select id="terapiaEdit" required>
                            <option>Seleccione</option>
                            <option value=1>Sí</option>
                            <option value=0>No</option>
                        </select>
                    </div>
                    <label class="col-sm-2 control-label">¿Ha estado internado por problemas psicológicos/psiquiátricos?</label>
                    <div class="col-sm-4">
                        <select id="internadoEdit" required>
                            <option>Seleccione</option>
                            <option value=1>Sí</option>
                            <option value=0>No</option>
                        </select>
                    </div>
                </div>
                <div class="form-group" id="internadoGroupEdit">
                    <label class="col-sm-2 control-label">En caso
                        afirmativo:</label>
                    <div class="col-sm-4">
										<textarea class="form-control"
                                                  placeholder="¿Cuándo? ¿Dónde? ¿Por qué?"
                                                  data-toggle="tooltip" data-placement="bottom"
                                                  id="internadoAfirmativoEdit" name="internadoAfirmativo"
                                                  title="No es requerido" lang="es" spellcheck="true" rows="5"></textarea>
                    </div>
                </div>
                <div class="clearfix"></div>
                <h5 class="page-header">Acciones</h5>
                <div class="form-group">
                    <div id="cancelar_nuevo_edit" class="col-sm-offset-2 col-sm-2">
                        <button
                                class="ajax-link action btn btn-default btn-label-left"
                                type="reset" title="Cancelar">
                            <span><i class="fa fa-minus-circle txt-danger"></i></span>
                            Cancelar
                        </button>
                    </div>
                    <div class="col-sm-2">
                        <button
                                id="btnEditar"
                                class="ajax-link action btn btn-primary btn-label-left"
                                onClick="" title="Editar">
                            <span><i class="fa fa-check-circle txt-success"></i></span>Editar
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
            </div>
        </div>
        <!-- Inicio de formulario para ver paciente -->
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                <div id="frm-visualiza" class="box">
                    <div class="box-header">
                        <div class="box-name">
                            <i class="fa fa-eye"></i> <span>Ver Paciente</span>
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
                        <h4 class="page-header">Formulario de visualización</h4>
                        <form class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="imprimir($('#btnImprimir').val());">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Primer nombre</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Primer nombre" data-toggle="tooltip"
                                           data-placement="bottom" id="nombre1View" name="nombre1"
                                           title="El primer nombre es requerido" required />
                                </div>
                                <label class="col-sm-2 control-label">Segundo nombre</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Segundo nombre" data-toggle="tooltip"
                                           data-placement="bottom" id="nombre2View" name="nombre2"
                                           title="El segundo nombre no es requerido"  />
                                </div>
                                <label class="col-sm-2 control-label">Primer apellido</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Primer nombre" data-toggle="tooltip"
                                           data-placement="bottom" id="apellido1View" name="apellido1"
                                           title="El primer apellido es requerido" required />
                                </div>
                                <label class="col-sm-2 control-label">Segundo apellido</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Segundo apellido" data-toggle="tooltip"
                                           data-placement="bottom" id="apellido2View" name="apellido2"
                                           title="El segundo apellido no es requerido" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Celular</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Número de celular" data-toggle="tooltip"
                                           data-placement="bottom" id="celularView" name="celular"
                                           title="El número de celular no es requerido" />

                                </div>

                                <input type="hidden" class="form-control"
                                       placeholder="Edad" data-toggle="tooltip"
                                       data-placement="bottom" id="edadView" name="edad"
                                       title="La edad es requerida" />


                                <label class="col-sm-2 control-label">Fecha de
                                    nacimiento</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Fecha de nacimiento" data-toggle="tooltip"
                                           data-placement="bottom" id="fechaNacView" name="fechaNac"
                                           title="La fecha de nacimiento es requerida" required />
                                </div>
                                <label class="col-sm-2 control-label">Sexo</label>
                                <div class="col-sm-4">
                                    <select disabled id="sexoView">
                                        <option>Seleccione</option>
                                        <option value=1>Hombre</option>
                                        <option value=0>Mujer</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 control-label">Estado civil</label>
                                <div class="col-sm-4">
                                    <select disabled id="estadoCivilView">
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

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Escolaridad</label>
                                <div class="col-sm-2">
                                    <select disabled id="escolaridadIdView" required>
                                        <option value="">Seleccione la escolaridad</option>
                                        <%

                                            res.beforeFirst();

                                            while (res.next()) {
                                        %>

                                        <option value="<%=res.getInt("EscolaridadID")%>"><%=res.getString("Nombre")%></option>

                                        <%
                                            }
                                        %>
                                    </select>
                                    <div class="checkbox">
                                        <label>Estudiante UCA
                                            <input type="checkbox" id="estudianteUCAView">
                                            <i class="fa fa-square-o small"></i>
                                        </label>
                                    </div>
                                </div>

                                <div class="col-sm-2">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Escolaridad" data-toggle="tooltip"
                                           data-placement="bottom" id="escolaridadView" name="escolaridad"
                                           title="La escolarida es requerida" required />
                                </div>

                                <label class="col-sm-2 control-label">Dirección</label>
                                <div class="col-sm-4">
                                    <textarea readonly maxlength="500" class="form-control" rows="5" id="direccionView" lang="es" spellcheck="true"></textarea>
                                    <small id="expectativasrev_char_count"></small>
                                </div>

                                <label class="col-sm-2 control-label">Con quién vive</label>
                                <div class="col-sm-4">
                                    <select disabled id="conQuienViveView">
                                        <option>Seleccione</option>
                                        <option value="Solo/a">Solo/a</option>
					    <option value="Madre">Madre</option>
                                        <option value="Padre">Padre</option>
                                        <option value="AbuelaMaterna">Abuela Materna</option>
                                        <option value="AbueloMaterno">Abuelo Materno</option>
                                        <option value="Abuela Paterna">Abuela Paterna</option>
                                        <option value="AbueloPaterno">Abuelo Paterno</option>
                                        <option value="Padres">Padres</option>
                                        <option value="Cónyuge">Cónyuge</option>
                                        <option value="Familia Nuclear">Familia Nuclear</option>
                                        <option value="Familia Externa">Familia Externa</option> 
                                        <option value="Otros">Otros</option>
                                    </select>
                                </div>

                                <label class="col-sm-2 control-label">Empleo</label>
                                <div class="col-sm-4">
                                    <input disabled type="text" class="form-control"
                                           placeholder="Empleo/trabajo desempeñado"
                                           data-toggle="tooltip" data-placement="bottom" id="empleoView"
                                           name="empleo" title="El empleo no es requerido" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Salario</label>
                                <div class="col-sm-4">
                                    <input readonly type="number" class="form-control"
                                           placeholder="Cantidad ganada en el trabajo desempeñado"
                                           data-toggle="tooltip" data-placement="bottom" id="salarioView"
                                           name="salario" title="El salario no es requerido" />
                                </div>
                                <label class="col-sm-2 control-label">Lugar de trabajo</label>
                                <div class="col-sm-4">
                                    <input readonly type="text" class="form-control"
                                           placeholder="Lugar donde trabaja" data-toggle="tooltip"
                                           data-placement="bottom" id="lugarTrabajoView" name="lugarTrabajo"
                                           title="El lugar de trabajo no es requerido" />
                                </div>
                                <label class="col-sm-2 control-label">¿Ha estado en
                                    terapia o recibido asistencia profesional para
                                    sus problemas?</label>
                                <div class="col-sm-4">
                                    <select disabled id="terapiaView" required>
                                        <option>Seleccione</option>
                                        <option value=1>Sí</option>
                                        <option value=0>No</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 control-label">¿Ha estado internado por problemas psicológicos/psiquiátricos?</label>
                                <div class="col-sm-4">
                                    <select disabled id="internadoView" required>
                                        <option>Seleccione</option>
                                        <option value=1>Sí</option>
                                        <option value=0>No</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">En caso
                                    afirmativo:</label>
                                <div class="col-sm-4">
										<textarea readonly  class="form-control"
                                                  placeholder="¿Cuándo? ¿Dónde? ¿Por qué?"
                                                  data-toggle="tooltip" data-placement="bottom"
                                                  id="internadoAfirmativoView" name="internadoAfirmativo"
                                                  title="No es requerido" lang="es" spellcheck="true" rows="5"></textarea>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="form-group">
                                <div id="cancelar_nuevo_view" class="col-sm-offset-2 col-sm-2">
                                    <button
                                            class="ajax-link action btn btn-default btn-label-left"
                                            type="reset" title="Cancelar">
                                        <span><i class="fa fa-minus-circle txt-danger"></i></span>
                                        Cancelar
                                    </button>
                                </div>
                                <div class="col-sm-2">
                                    <button
                                            id="btnImprimir"
                                            class="ajax-link action btn btn-primary btn-label-left"
                                            onClick="" title="Imprimir">
                                        <span><i class="fa fa-print "></i></span>Imprimir
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    	<!-- Inicio de formulario para transferir paciente -->
        <div class="row">
            <div class="col-xs-12 col-sm-12">
             <div id="frm-transferir" class="box">
             	<div class="box-header">
                <div class="box-name">
                            <i class="fa fa-exchange"></i> <span>Transferir Paciente</span>
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
				<h4 class="page-header">Transferencia de Paciente</h4>
				<form id="agreg" class="form-horizontal" method="post"
						action="javascript:void(0);" onsubmit="transferirPaciente();">
					<div class="col-sm-6">
						<h5 class="page-header">Datos</h5>
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

					</div>
					<div class="col-sm-6">
						<h5 class="page-header">Acciones</h5>
						<div class="form-group">
							<div id="cancelar_transferir" class="col-sm-6 text-center">
								<button
									class="ajax-link action btn btn-default btn-label-left"
									type="reset" title="Cancelar">
									<span>
										<i class="fa fa-minus-circle txt-danger">
										</i>
									</span>
									Cancelar
								</button>
							</div>
							<div class="col-sm-6 text-center">
								<button
									id="btnIdTransferir"
									class="ajax-link action btn btn-primary btn-label-left"
									onClick="" title="Transferir">
									<span>
										<i class="fa fa-check-circle txt-success">
										</i>
									</span>
									Transferir
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
</div>       

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-list"></i> <span>Lista de
						Pacientes</span>
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
							<div class="col-md-12 text-center">
								<button name="button" class="btn btn-primary" id="todas" onclick="refrescarInactivos()">Ver dados de baja</button>
                                <button name="button" class="btn btn-primary" id="dadosAlta" onclick="refrescarDatosAlta()">Ver dados de alta</button>
							<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#"
								title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i>
							</a>
							</div>
						</div>

					</div>
				</div>
				<table class="table table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Código</th>
							<th>Nombre</th>
							<th>Edad</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>

						<%
							ResultSet rspac=null;
						    DtConsulta dtcon = new DtConsulta();
							DtPaciente dtp = new DtPaciente();
							
						if (r.getRolId() == 1 || r.getRolId() == 4) { //Carga TODOS los registros para Administrador y Directora
							rspac = dtp.cargarDatos();
						
						} else if (r.getRolId() == 3) { //Carga únicamente los registros relacionados un psicólogo
							rspac = dtp.cargarPacientesAPsicologos(dtcon.obtenerPsicologoID(us.getUsuarioID()));
							
						}
							
							
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
							SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");
							rspac.beforeFirst();
							while (rspac.next()) {
						%>

						<tr>
							<td><%=rspac.getString("Expediente")%></td>
							<td><%=rspac.getString("Nombre1") + " "+ rspac.getString("Nombre2") + " " + rspac.getString("Apellido1") + " "+ rspac.getString("Apellido2")%></td>
							<td><%=rspac.getString("Edad")%></td>
							<%
							if(r.getRolId() == 1){
							%>
							<td>
								<% Date fecha = formatter.parse(rspac.getString("Fechanac")); %>
								
								<button id='btnIdVisualizar'
									class="btn btn-default btn-label-left"
									OnClick="cargarDatosVisualizar(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span> Ver paciente
								</button>
								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
								<input id="validacionPaciente" name="validacionPaciente" type="hidden" value=<%=dtres.validarPaciente(rs.getInt("PacienteID"))%>  checked>
								<button id="btnRespuesta"  onClick="redirect(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Ficha
								</button>
								<button id="btnRespuestaVista"  onClick="redirectII(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-eye"></i>
									</span> Ver ficha
								</button>
								<button id="btnTransferir"  onClick="transferir(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Transferir
								</button>
                                <button id="btnIdAlta"
                                        value=<%=rspac.getInt("PacienteID")%>
                                                class='ajax-link action btn btn-default btn-label-left'
                                onClick='eliminarAlta(this.value);'>
                                <span><i class="fa fa-trash-o txt-danger"></i></span>Dar de alta</button>
								<button id="btnIdEliminar"
									value=<%=rspac.getInt("PacienteID")%>
									class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>Dar de baja</button>
							</td>
							<%
							} 
							%>
							<% 
							if(r.getRolId() == 2){
							%>
							<td>
								<% Date fecha = formatter.parse(rspac.getString("Fechanac")); %>
								
								<button id='btnIdVisualizar'
									class="btn btn-default btn-label-left"
									OnClick="cargarDatosVisualizar(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span> Ver paciente
								</button>
								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
								<input id="validacionPaciente" name="validacionPaciente" type="hidden" value=<%=dtres.validarPaciente(rs.getInt("PacienteID"))%>  checked>
								<button id="btnRespuesta"  onClick="redirect(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Ficha
								</button>
								<button id="btnRespuestaVista"  onClick="redirectII(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-eye"></i>
									</span> Ver ficha
								</button>
								<button id="btnTransferir"  onClick="transferir(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Transferir
								</button>
                                <button id="btnIdAlta"
                                        value=<%=rspac.getInt("PacienteID")%>
                                                class='ajax-link action btn btn-default btn-label-left'
                                onClick='eliminarAlta(this.value);'>
                                <span><i class="fa fa-trash-o txt-danger"></i></span>Dar de alta</button>
								<button id="btnIdEliminar"
									value=<%=rspac.getInt("PacienteID")%>
									class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>Dar de baja</button>
							</td>
							<% 	
							} 
							%>
							<% 
							if(r.getRolId() == 3){
							%>
							 <td>
								<% Date fecha = formatter.parse(rspac.getString("Fechanac")); %>
								
								<button id='btnIdVisualizar'
									class="btn btn-default btn-label-left"
									OnClick="cargarDatosVisualizar(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span> Ver paciente
								</button>
	
								<input id="validacionPaciente" name="validacionPaciente" type="hidden" value=<%=dtres.validarPaciente(rspac.getInt("PacienteID"))%>  checked>
								
								<button id="btnRespuestaVista"  onClick="redirectII(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-eye"></i>
									</span> Ver ficha
								</button>
								<button id="btnTransferir"  onClick="transferir(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Transferir
								</button>
                                <button id="btnIdAlta"
                                        value=<%=rspac.getInt("PacienteID")%>
                                                class='ajax-link action btn btn-default btn-label-left'
                                onClick='eliminarAlta(this.value);'>
                                <span><i class="fa fa-trash-o txt-danger"></i></span>Dar de alta</button>
								<button id="btnIdEliminar"
									value=<%=rspac.getInt("PacienteID")%>
									class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>Dar de baja</button>

												
<%-- 								<%System.out.println("la validacion dijo que "+dtres.validarPaciente(rs.getInt("PAcienteID"))); %> --%>
							</td>
							<% 	
							}
							%>
							<% 
							if(r.getRolId() == 4){
							%>
							<td>
							  	<% Date fecha = formatter.parse(rspac.getString("Fechanac")); %>
								
								<button id='btnIdVisualizar'
									class="btn btn-default btn-label-left"
									OnClick="cargarDatosVisualizar(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-eye"></i></span> Ver paciente
								</button>
								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, '<%=rspac.getString("Nombre1")%>',
										'<%=rspac.getString("Nombre2")%>',
										'<%=rspac.getString("Apellido1")%>',
										'<%=rspac.getString("Apellido2")%>',
										'<%=rspac.getInt("Celular")%>',
										'<%=rspac.getString("Edad")%>',
										'<%=fechaM.format(fecha)%>',
										'<%=rspac.getInt("Sexo")%>',
										'<%=rspac.getInt("Estadocivil")%>',
										'<%=rspac.getString("Escolaridad")%>', 
										'<%=rspac.getString("Direccion")%>',
										'<%=rspac.getString("Conquienvive")%>',
										'<%=rspac.getString("Lugartrabajo")%>',
										'<%=rspac.getString("Empleo")%>',
										'<%=rspac.getString("Salario")%>',
										'<%=rspac.getInt("Terapia")%>',
										'<%=rspac.getInt("Internado")%>',
										'<%=rspac.getString("Internadoafirmativo")%>',
										'<%=rspac.getString("EscolaridadID")%>',
                                            '<%=rspac.getString("Uca")%>');"
									value=<%=rspac.getInt("PacienteID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>
								<input id="validacionPaciente" name="validacionPaciente" type="hidden" value=<%=dtres.validarPaciente(rs.getInt("PacienteID"))%>  checked>
								<button id="btnRespuesta"  onClick="redirect(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Ficha
								</button>
								<button id="btnRespuestaVista"  onClick="redirectII(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-eye"></i>
									</span> Ver ficha
								</button>
								<button id="btnTransferir"  onClick="transferir(this.value);"
									class="ajax-link action btn btn-default btn-label-left"
									value=<%=rspac.getInt("PacienteID")%>>
									<span> <i class="fa fa-edit"></i>
									</span> Transferir
								</button>
                                <button id="btnIdAlta"
                                        value=<%=rspac.getInt("PacienteID")%>
                                                class='ajax-link action btn btn-default btn-label-left'
                                onClick='eliminarAlta(this.value);'>
                                <span><i class="fa fa-trash-o txt-danger"></i></span>Dar de alta</button>
								<button id="btnIdEliminar"
									value=<%=rspac.getInt("PacienteID")%>
									class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'>
									<span><i class="fa fa-trash-o txt-danger"></i></span>Dar de baja</button>
							  						
<%-- 								<%System.out.println("la validacion dijo que "+dtres.validarPaciente(rs.getInt("PAcienteID"))); %> --%>
							
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
							<th>Código</th>
							<th>Nombre</th>
							<th>Edad</th>
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
	
	function redirect(idClicked) {
		var validacionPaciente = $("#validacionPaciente").val();
// 		successAlert('AVISO', "LA validacion dice que este paciente esta en "+validacionPaciente);
		if(validacionPaciente=="false"){
			var fpacienteId = "";
			fpacienteId = idClicked;
			window.location.href = "#ajax/respuesta.jsp?pacienteId=" + fpacienteId;
			location.reload();
		}else{
			infoAlert('AVISO', 'Este Paciente ya tiene registarda la plantilla de Respueta');
			setTimeout(function() {
				window.location.href = "#ajax/paciente.jsp";
				location.reload();
			  },2000);
			console.log("YA EXISTE LA respuesta volviendo a la lista de pacientes");
		}

	}
	
	function redirectII(idClicked) {
		var validacionPaciente = $("#validacionPaciente").val();
// 		successAlert('AVISO', "LA validacion dice que este paciente esta en "+validacionPaciente);
		if(validacionPaciente=="true"){
			var fpacienteId = "";
			fpacienteId = idClicked;
			window.location.href = "#ajax/respuestaVista.jsp?pacienteId=" + fpacienteId;
			location.reload();
		}else{
			infoAlert('AVISO', 'Este Paciente no ha registrado su respuesta');
			setTimeout(function() {
				window.location.href = "#ajax/paciente.jsp";
				location.reload();
			  },2000);
			console.log("sin respuesta volviendo a la lista de pacientes");
			//window.location.href = "#ajax/paciente.jsp";
			//location.reload();
		}

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y GUARDAR
	function guardar() {
		guardarPaciente();
		

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		actualizarPaciente(idClicked);
		
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarPaciente(idClicked);
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
		
	}

	function eliminarAlta(idClicked) {
        confirm(function(){
            eliminarPacienteAlta(idClicked);
        }, function(){
            infoAlert('Aviso', 'Eliminación cancelada');
        });
    }

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		var TipoRol = "";
		var usuarioID = "";
		
		opcion = "refrescar";

		fTipoRol = $("#TipoRol").val();
		fusuarioID = $("#usuarioID").val();
		
		$.ajax({
			url : "SlPaciente",
			type : "post",
			datatype : 'html',
			data : {
				fTipoRol : fTipoRol,
				fusuarioID : fusarioID,
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

	function refrescarInactivos() {
        var opcion = "";
        var TipoRol = "";
		var usuarioID = "";
		
		fTipoRol = $("#TipoRol").val();
		fusuarioID = $("#usuarioID").val();
        opcion = "refrescarInactivos";

        $.ajax({
            url : "SlPaciente",
            type : "post",
            datatype : 'html',
            data : {
            	'fTipoRol' : fTipoROl,
            	'fusuarioID' : fusuarioID,
                'opcion' : opcion
            },
            success : function(data) {
                $('#datatable-1').html(data);
                $('#datatable-1').dataTable().fnDestroy();
                AllTables();
                $('#datatable-1').addClass(
                    "table table-hover table-heading table-datatable");
                infoAlert('Aviso', 'Pacientes inactivos cargados');
            }

        });
	}

	function refrescarDatosAlta() {
        var opcion = "";
        var TipoRol = "";
		var usuarioID = "";
		
        opcion = "refrescarDatosAlta";
        fTipoRol = $("#TipoRol").val();
		fusuarioID = $("#usuarioID").val();
        console.log("REfrescar datos alta");
        
        $.ajax({
            url : "SlPaciente",
            type : "post",
            datatype : 'html',
            data : {
            	
            	'fTipoRol' : fTipoRol,
            	'fusuarioID' : fusuarioID,
                'opcion' : opcion
            },
            success : function(data) {
                $('#datatable-1').html(data);
                $('#datatable-1').dataTable().fnDestroy();
                AllTables();
                $('#datatable-1').addClass(
                    "table table-hover table-heading table-datatable");
                infoAlert('Aviso', 'Pacientes dados de alta cargados');
            }

        });
    }

	function reactivar(idClicked) {
	    var opcion = "";
	    var fpacienteId1 = 0;
	    opcion = "reactivar";
        fpacienteId1 = idClicked;

        $.ajax({
            url : "SlPaciente",
            type : "post",
            datatype : 'html',
            data : {
                'opcion' : opcion,
				'fpacienteId1' : fpacienteId1
            },
            success : function(data) {
                refrescarInactivos();
                successAlert('Listo', 'Reactivado exitosamente');
            }

        });
	}

    function reactivarDadosAlta(idClicked) {
        var opcion = "";
        var fpacienteId2 = 0;
        opcion = "reactivarDadosAlta";
        fpacienteId2 = idClicked;

        $.ajax({
            url : "SlPaciente",
            type : "post",
            datatype : 'html',
            data : {
                'opcion' : opcion,
                'fpacienteId2' : fpacienteId2
            },
            success : function(data) {
                refrescarDatosAlta();
                successAlert('Listo', 'Reactivado exitosamente');
            }

        });
    }

	//MÉTODO PARA GUARDAR EL REGISTRO A TRAVÉS DEL SERVLET
	function guardarPaciente() {
		var fexpediente = "";
		var fnombre1 = "";
		var fnombre2 = "";
		var fapellido1 = "";
		var fapellido2 = "";
		var fcelular = ""; 
		var fedad = ""; 
		var ffechaNac = "";
		var fsexo = 0;
		var festadoCivil = 0;
		var fescolaridad = "";
		var fdireccion = "";
		var fconquienvive = "";
		var flugarTrabajo = "";
		var fempleo = "";
		var fsalario = "";
		var fterapia = 0;
		var finternado = 0;
		var finternadoAfirmativo = "";
		var fescolaridadId = 0;
		var opcion = "";
		var festudianteUCA = 0;

		opcion = "guardar";
		fnombre1 = $("#nombre1").val();
		fnombre2 = $("#nombre2").val();
		fapellido1 = $('#apellido1').val();
		fapellido2 = $('#apellido2').val();
		fcelular = $('#celular').val();
		ffechaNac = $('#fechaNac').val();
		fsexo = $('#sexo').val();
		festadoCivil = $('#estadoCivil').val();
		fescolaridad = $('#escolaridad').val();
		fdireccion = $('#direccion').val();
		fconquienvive = $('#conQuienVive').val();
		fempleo = $('#empleo').val();
		flugarTrabajo = $('#lugarTrabajo').val();
		fsalario = $('#salario').val();
		fterapia = $('#terapia').val();
		finternado = $('#internado').val();
		finternadoAfirmativo = $('#internadoAfirmativo').val();
		fescolaridadId = $('#escolaridadId').val();

		if($('#estudianteUCA').is(":checked")) {
		    festudianteUCA = 1;
        }
		
		//Crear el código de expediente
		fexpediente = fapellido1.charAt(0);
		fexpediente += fapellido2.charAt(0);
		fexpediente += fnombre1.charAt(0);
		fexpediente += fnombre2.charAt(0);
		fexpediente += ffechaNac.substring(0, 2);
		fexpediente += ffechaNac.substring(3, 5);
		fexpediente += ffechaNac.substring(8, 10);
		
		//Calcular edad
		var fecha = new Date();
		var year = fecha.getFullYear();
		var age = parseInt(ffechaNac.substring(6, 10));
		var realAge = year - age;
		console.log("realAge is: "+realAge);
		$('#edad').val(realAge);
		fedad = $('#edad').val();
		
		
		
		//alert(fexpediente);

		$.ajax({
			url : "SlPaciente",
			type : "post",
			datatype : 'html',
			data : {
				'fexpediente' : fexpediente,
				'fnombre1' : fnombre1,
				'fnombre2' : fnombre2,
				'fapellido1' : fapellido1,
				'fapellido2' : fapellido2,
				'fcelular' : fcelular,
				'fedad' : fedad,
				'ffechaNac' : ffechaNac,
				'fsexo' : fsexo,
				'festadoCivil' : festadoCivil,
				'fescolaridad' : fescolaridad,
				'fdireccion' : fdireccion,
				'fconquienvive' : fconquienvive,
				'fempleo' : fempleo,
				'flugarTrabajo' : flugarTrabajo,
				'fsalario' : fsalario,
				'fterapia' : fterapia,
				'finternado' : finternado,
				'finternadoAfirmativo' : finternadoAfirmativo,
				'fescolaridadId' : fescolaridadId,
                'festudianteUCA' : festudianteUCA,
				'opcion' : opcion
			},
			success : function(data) {
                websocket.send("Guardar");
                successAlert('Listo', 'Guardado exitosamente');
                $("#agregar")[0].reset();
                $('#frm-agrega').fadeOut();


			}

		});

	}
	

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarPaciente(idClicked) {
		var opcion = "";
		var fpacienteId = idClicked;
		opcion = "eliminar";

		$.ajax({
			url : "SlPaciente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fpacienteId' : fpacienteId
			},
			success : function(data) {
				websocket.send("Eliminar");
				successAlert('Listo', 'Eliminado exitosamente');
                $("#edit")[0].reset();

			}

		});

	}

    function eliminarPacienteAlta(idClicked) {
        var opcion = "";
        var fpacienteId2 = idClicked;
        opcion = "eliminarAlta";

        $.ajax({
            url : "SlPaciente",
            type : "post",
            datatype : 'html',
            data : {
                'opcion' : opcion,
                'fpacienteId2' : fpacienteId2
            },
            success : function(data) {
                websocket.send("Eliminar");
                successAlert('Listo', 'Eliminado exitosamente');
                //$("#edit")[0].reset();

            }

        });

    }

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarPaciente(idClicked) {
		var opcion = "";
		var fpacienteId = idClicked;
		var fnombre1;
		var fnombre2;
		var fapellido1;
		var fapellido2;
		var fcelular; 
		var fedad; 
		var ffechaNac;
		var fsexo;
		var festadoCivil;
		var fescolaridad;
		var fdireccion;
		var fconquienvive;
		var flugarTrabajo;
		var fempleo;
		var fsalario;
		var fterapia;
		var finternado;
		var finternadoAfirmativo;
		var fescolaridadId;
		var festudianteUCA = 0;

		opcion = "actualizar";
		fnombre1 = $("#nombre1Edit").val();
		fnombre2 = $("#nombre2Edit").val();
		fapellido1 = $('#apellido1Edit').val();
		fapellido2 = $('#apellido2Edit').val();
		fcelular = $('#celularEdit').val();
		ffechaNac = $('#fechaNacEdit').val();
		fsexo = $('#sexoEdit').val();
		festadoCivil = $('#estadoCivilEdit').val();
		fescolaridad = $('#escolaridadEdit').val();
		fdireccion = $('#direccionEdit').val();
		fconquienvive = $('#conQuienViveEdit').val();
		fempleo = $('#empleoEdit').val();
		flugarTrabajo = $('#lugarTrabajoEdit').val();
		fsalario = $('#salarioEdit').val();
		fterapia = $('#terapiaEdit').val();
		finternado = $('#internadoEdit').val();
		finternadoAfirmativo = $('#internadoAfirmativoEdit').val();
		fescolaridadId = $('#escolaridadIdEdit').val();

        if($('#estudianteUCAEdit').is(":checked")) {
            festudianteUCA = 1;
        }
		
		//Calcular edad
		var fecha = new Date();
		var year = fecha.getFullYear();
		var age = parseInt(ffechaNac.substring(6, 10));
		var realAge = year - age;
		console.log("realAgeEdit is: "+realAge);
		$('#edadEdit').val(realAge);
		fedad = $('#edadEdit').val();
		
		$.ajax({
			url : "SlPaciente",
			type : "post",
			datatype : 'html',
			data : {
				'fpacienteId' : fpacienteId,
				'fnombre1' : fnombre1,
				'fnombre2' : fnombre2,
				'fapellido1' : fapellido1,
				'fapellido2' : fapellido2,
				'fcelular' : fcelular,
				'fedad' : fedad,
				'ffechaNac' : ffechaNac,
				'fsexo' : fsexo,
				'festadoCivil' : festadoCivil,
				'fescolaridad' : fescolaridad,
				'fdireccion' : fdireccion,
				'fconquienvive' : fconquienvive,
				'fempleo' : fempleo,
				'flugarTrabajo' : flugarTrabajo,
				'fsalario' : fsalario,
				'fterapia' : fterapia,
				'finternado' : finternado,
				'finternadoAfirmativo' : finternadoAfirmativo,
				'fescolaridadId' : fescolaridadId,
                'festudianteUCA' : festudianteUCA,
				'opcion' : opcion
			},
			success : function(data) {
				$("#edit")[0].reset();
				$('#frm-edita').fadeOut();
				websocket.send("Modificar");
				successAlert('Listo', 'Actualizado exitosamente');
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO PARA ACTUALIZAR
	function cargarDatos(pacienteId, nombre1, nombre2, apellido1, apellido2, celular, edad, fechaNac, sexo, estadoCivil, escolaridad, direccion, conQuienVive, lugarTrabajo, empleo, salario, terapia, internado, internadoAfirmativo, escolaridadId, estudianteUCA) {
		var fpacienteId = pacienteId;
		var fnombre1 = nombre1;
		var fnombre2 = nombre2;
		var fapellido1 = apellido1;
		var fapellido2 = apellido2;
		var fcelular = celular; 
		var fedad = edad; 
		var ffechaNac = fechaNac;
		var fsexo = sexo;
		var festadoCivil = estadoCivil;
		var fescolaridad = escolaridad;
		var fdireccion = direccion;
		var fconquienvive = conQuienVive;
		var flugarTrabajo = lugarTrabajo;
		var fempleo = empleo;
		var fsalario = salario;
		var fterapia = terapia;
		var finternado = internado;
		var finternadoAfirmativo = internadoAfirmativo;
		var fescolaridadId = escolaridadId;
		var festudianteUCA = estudianteUCA;

		$('#btnEditar').val(fpacienteId);
		
		$("#nombre1Edit").val(fnombre1);
		$("#nombre2Edit").val(fnombre2);
		$('#apellido1Edit').val(fapellido1);
		$('#apellido2Edit').val(fapellido2);
		$('#celularEdit').val(fcelular);
		$('#edadEdit').val(fedad);
		$('#fechaNacEdit').val(ffechaNac);
		$('#sexoEdit').val(fsexo).change();
		$('#estadoCivilEdit').val(festadoCivil).change();
		$('#escolaridadEdit').val(fescolaridad);
		$('#direccionEdit').val(fdireccion);
		$('#conQuienViveEdit').val(fconquienvive).change();
		$('#empleoEdit').val(fempleo);
		$('#lugarTrabajoEdit').val(flugarTrabajo);
		$('#salarioEdit').val(fsalario);
		$('#terapiaEdit').val(fterapia).change();
		$('#internadoEdit').val(finternado).change();
		$('#internadoAfirmativoEdit').val(finternadoAfirmativo);
		$('#escolaridadIdEdit').val(fescolaridadId).change();
		if(festudianteUCA==1) {
		    $('#estudianteUCAEdit').prop('checked', true).change();
        } else {
            $('#estudianteUCAEdit').prop('checked', false).change();
        }
		
		$('#frm-edita').fadeIn();
		$('#frm-agrega').fadeOut();
	}
	
	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO PARA VISUALIZAR
	function cargarDatosVisualizar(pacienteId, nombre1, nombre2, apellido1, apellido2, celular, edad, fechaNac, sexo, estadoCivil, escolaridad, direccion, conQuienVive, lugarTrabajo, empleo, salario, terapia, internado, internadoAfirmativo, escolaridadId, estudianteUCA) {
		var fpacienteId = pacienteId;
		var fnombre1 = nombre1;
		var fnombre2 = nombre2;
		var fapellido1 = apellido1;
		var fapellido2 = apellido2;
		var fcelular = celular; 
		var fedad = edad; 
		var ffechaNac = fechaNac;
		var fsexo = sexo;
		var festadoCivil = estadoCivil;
		var fescolaridad = escolaridad;
		var fdireccion = direccion;
		var fconquienvive = conQuienVive;
		var flugarTrabajo = lugarTrabajo;
		var fempleo = empleo;
		var fsalario = salario;
		var fterapia = terapia;
		var finternado = internado;
		var finternadoAfirmativo = internadoAfirmativo;
		var fescolaridadId = escolaridadId;

		$('#btnImprimir').val(fpacienteId);
		
		$("#nombre1View").val(fnombre1);
		$("#nombre2View").val(fnombre2);
		$('#apellido1View').val(fapellido1);
		$('#apellido2View').val(fapellido2);
		$('#celularView').val(fcelular);
		$('#edadView').val(fedad);
		$('#fechaNacView').val(ffechaNac);
		$('#sexoView').val(fsexo).change();
		$('#estadoCivilView').val(festadoCivil).change();
		$('#escolaridadView').val(fescolaridad);
		$('#direccionView').val(fdireccion);
		$('#conQuienViveView').val(fconquienvive).change();
		$('#empleoView').val(fempleo);
		$('#lugarTrabajoView').val(flugarTrabajo);
		$('#salarioView').val(fsalario);
		$('#terapiaView').val(fterapia).change();
		$('#internadoView').val(finternado).change();
		$('#internadoAfirmativoView').val(finternadoAfirmativo);
		$('#escolaridadIdView').val(fescolaridadId).change();
		if(estudianteUCA==1) {
            $('#estudianteUCAView').prop('checked', true).change();
        } else {
            $('#estudianteUCAView').prop('checked', false).change();
        }
		
		$('#frm-agrega').fadeOut();
		$('#frm-edita').fadeOut();
		$('#frm-visualiza').fadeIn();
	}
	
	function imprimir(pacienteId){
		window.open("SlReporteInfoPacientes?pacienteId="+pacienteId, '_blank');
	}
	
	function transferir(pacienteId){
		var fpacienteId = pacienteId;
		$('#btnIdTransferir').val(pacienteId);
		$('#frm-transferir').fadeIn();
	}
	
	function transferirPaciente(){
		var opcion = "";
		var fpsicologoId = $('#psicologoId').val();
		var fpacienteId = $('#btnIdTransferir').val();
		opcion = "transferir";

		$.ajax({
			url : "SlPaciente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fpsicologoId' : fpsicologoId,
				'fpacienteId' : fpacienteId
			},
			success : function(data) {
				successAlert('Listo', 'Transferencia exitosa');
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
	/////////////////////////////CONTROLAR EL EVENTO FADEIN DE LA VENTANA EDITAR/////////////////////////////
// 	function editOrDeleteCustomer(event) {
// 		var link = jQuery(event.currentTarget);
// 		var url = link.attr('href');
// 		jQuery.get(url, function(data) {
// 			$('#frm-edita').fadeIn();
// 		});
// 	}
	// Add Drag-n-Drop feature
	
	$(document).ready(function() {
		
		//Contadores de caracteres
		$('#direccion').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#rev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		
		$('#direccionEdit').on('input propertychange', function() {
			var max_len = 500;
			var len = $(this).val().trim().length; 
			    len = max_len -len;
			    $('#rev_char_count').text(len > 0 ? (len + ' caracter' + (len == 1 ? '' : 'es')  + ' restantes.') : '');	
		});	
		
		$('#internado').change(function () {
			if(this.selectedIndex === 1) {
				$('#internadoGroup').fadeIn();	
			}
			else {
				$('#internadoGroup').fadeOut();
			}
		});
		
		$('#internadoEdit').change(function () {
			if(this.selectedIndex === 1) {
				$('#internadoGroupEdit').fadeIn();	
			}
			else {
				$('#internadoGroupEdit').fadeOut();
			}
		});
		
		$('#internadoGroup').hide();
		$('#internadoGroupEdit').hide();
		
		
		$("#fechaNac").mask("99/99/9999",{placeholder:"dd/mm/aaaa"});
		$("#celular").mask("99999999");
		
		$("#fechaNacEdit").mask("99/99/9999",{placeholder:"dd/mm/aaaa"});
		$("#celularEdit").mask("99999999");
		$("#salarioEdit").mask("9999999");
		
		$('#frm-agrega').hide();
		$('#frm-edita').hide();
		$('#frm-visualiza').hide();
		$('#frm-transferir').hide();
		
		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);
		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			var TipoRol = "";
			TipoRol = $("#TipoRol").val();
			if(TipoRol != 3){
				$('#frm-agrega').fadeIn();
				$('#frm-edita').fadeOut()
				
			}
			
		});
		$('#cancelar_nuevo').click(function() {
			$('#frm-agrega').fadeOut();
		});
		$('#cancelar_nuevo_edit').click(function() {
			$('#frm-edita').fadeOut();
		});
		
		$('#cancelar_nuevo_view').click(function() {
			$('#frm-visualiza').fadeOut();
		});
		$('#cancelar_transferir').click(function() {
			$('#frm-transferir').fadeOut();
		});
		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////
		WinMove();
	}); 
</script>
