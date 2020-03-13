<%@page
	import="entidades.*, datos.*, java.util.*, java.sql.*,java.text.SimpleDateFormat, java.util.Date"%>

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
		response.sendRedirect("../Home.jsp");
		return;
	}
	
	if(!permiso)
	{
		response.sendRedirect("error.jsp");
	}

%>
<input id="usuarioID" name="usuarioID" type="hidden" value=<%=us.getUsuarioID()%> checked>
<input id="TipoRol" name="TipoRol" type="hidden" value=<%=r.getRolId()%>  checked>
<%
if(r.getRolId() == 3 || r.getRolId() == 5){
%>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#" class="active ajax-link">Gestión paciente</a>
			<li><a href="#">Pariente</a>
		</ol>
	</div>
</div>

<!-- inicio de formulario para editar un pariente -->

<div class="row">
	<div class="col-xs-12 col-sm-12">

		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Registro Pariente</span>
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
							<input type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre" id="primerNombre" name="primerNombre" required>
						</div>
						<label class="col-sm-2 control-label">Segundo nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombre" name="segundoNombre">
						</div>
						<label class="col-sm-2 control-label">Primer apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellido"
									name="primerApellido" required>
						</div>
						<label class="col-sm-2 control-label">Segundo apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellido"
									name="segundoApellido">
						</div>
					</div>

                    <div class="form-group">
					<label class="col-sm-2 control-label">Ocupacion</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Ocupacion" id="ocupacion" name="ocupacion">
						</div>
						<label class="col-sm-2 control-label">Lugar de trabajo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajo"
									name="lugarTrabajo">
						</div>
						<label class="col-sm-2 control-label">Cargo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Cargo" id="cargo" name="cargo">
<!-- 							<span class="fa fa-check-square-o txt-success form-control-feedback"></span> -->
						</div>
						<label class="col-sm-2 control-label">Salario</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" placeholder="Salario" id="salario" name="salario">
						</div>
					</div>

                    <div class="form-group">
						<label class="col-sm-2 control-label">Edad</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Edad"
									id="edad" name="edad" required>
							
						</div>
						<label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select id="escolaridadId" required>
                                <option value="">Escolaridad</option>
                                <%
                                    DtPaciente dtpp = new DtPaciente();
                                    ResultSet res1 = dtpp.cargarEscolaridades();
                                    res1.beforeFirst();

                                    while (res1.next()) {
                                %>

                                <option value="<%=res1.getInt("EscolaridadID")%>"><%=res1.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select id="escolaridaddetalle" required>
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option>
                                         <option value="12">Concluida</option>  
                                        <option value="13">Otro</option>
                                    </select>
                                </div>		
					</div>

                    <div class="form-group">
						<label class="col-sm-2 control-label">Estado de vida</label>
						<div class="col-sm-4">
							<select id="estadoVida">
									<option value=2>Seleccione</option>
									<option value=1>Vivo(a)</option>
									<option value=0>Fallecido(a)</option>
								</select>
						</div>
                        <div id="causaMuerteDiv">
						<label class="col-sm-2 control-label">Causa de muerte</label>
						<div class="col-sm-4" >
							<input type="text" class="form-control"
									placeholder="Causa de muerte" data-toggle="tooltip"
									data-placement="bottom" title="Causa de muerte"
									id="causaMuerte" name="causaMuerte">
                        </div>
					    </div>
                    </div>

                    <div class="form-group">
							<label class="col-sm-2 control-label">Parentesco</label>
							<div class="col-sm-4">
								<select name="parentesco" id="parentesco">
									<option>Seleccione</option>
									
									<%
										rs.close();
										rs = null;
										DtParentesco dtpar = new DtParentesco();
										rs = dtpar.cargarDatos();
										rs.beforeFirst();

										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

									<%
										}
									%>
								</select>
							</div>
							<label class="col-sm-2 control-label">¿Este pariente es
								tutor?</label>
							<div class="col-sm-4">
								<select id="tutor">
                                    <option>Seleccione</option>
									<option value=1>Sí</option>
									<option value=0>No</option>
								</select>
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

<!-- inicio de formulario para editar un pariente -->

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<!-- Inicio de formulario -->
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Formulario de
						Actualización Pariente</span>
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
 				<form id="editar" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="form-group">
						<label class="col-sm-2 control-label">Primer nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre"  id="primerNombreEditar"
										name="primerNombre">
						</div>
						<label class="col-sm-2 control-label">Segundo nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombreEditar"
										name="segundoNombre">
						</div>
						<label class="col-sm-2 control-label">Primer apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellidoEditar"
										name="primerApellido">
						</div>
						<label class="col-sm-2 control-label">Segundo apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellidoEditar"
										name="segundoApellido">
						</div>
					</div>

                    <div class="form-group has-success has-feedback">
					<label class="col-sm-2 control-label">Ocupacion</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Ocupacion" id="ocupacionEditar" name="ocupacion">
						</div>
						<label class="col-sm-2 control-label">Lugar de trabajo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajoEditar"
									name="lugarTrabajo">
						</div>
						<label class="col-sm-2 control-label">Cargo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Cargo" id="cargoEditar" name="cargo">
<!-- 							<span class="fa fa-check-square-o txt-success form-control-feedback"></span> -->
						</div>
						<label class="col-sm-2 control-label">Salario</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" placeholder="Salario" id="salarioEditar" name="salario">
						</div>
					</div>

                    <div class="form-group has-warning has-feedback">
						<label class="col-sm-2 control-label">Edad</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Edad"
									id="edadEditar" name="edad">
							
						</div>
					<label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select id="escolaridadIdEditar" required>
                                <option value="">Escolaridad</option>
                                <%

                                    res1.beforeFirst();

                                    while (res1.next()) {
                                %>

                                <option value="<%=res1.getInt("EscolaridadID")%>"><%=res1.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select id="escolaridaddetalleedit">
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option> 
                                         <option value="12">Concluida</option> 
                                        <option value="13">Otro</option>
                                    </select>
                                </div>
					</div>

                    <div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Estado de vida</label>
						<div class="col-sm-4">
							<select id="estadoVidaEditar">
									
									<option value=1>Vivo(a)</option>
									<option value=0>Fallecido(a)</option>
								</select>
						</div>
						<label class="col-sm-2 control-label">Causa de muerte</label>
						<div class="col-sm-4">
							<input type="text" class="form-control"
									placeholder="Causa de muerte" data-toggle="tooltip"
									data-placement="bottom" title="Causa de muerte"
									id="causaMuerteEditar" name="causaMuerte">
						
					    </div>
                    </div>

                    <div class="form-group">
							<label class="col-sm-2 control-label">Parentesco</label>
							<div class="col-sm-4">
								<select name="parentesco" id="parentescoidEditar"
										>
										
										<%
											rs.beforeFirst();

											while (rs.next()) {
										%>
										<option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

										<%
											}
										%>
									</select>
							</div>
							<label class="col-sm-2 control-label">¿Este pariente es
								tutor?</label>
							<div class="col-sm-4">
								<select id="tutorEditar" >
									
									<option value=1>Si</option>
									<option value=0>No</option>
								</select>
							</div>
					</div>

                    <div class="clearfix"></div>
					<div class="form-group">
						<div id="cancelar_nuevo_editar" class="col-sm-offset-2 col-sm-2">
							<button class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button id="btnEditar"
								class="ajax-link btn btn-primary btn-label-left"
								onClick="" title="Editar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Editar
							</button>
						</div>
					</div>
 				</form> 
            </div>
		</div>
	</div>
</div>

<!-- Formulario visualizar -->
<div class="row">
    <div class="col-xs-12 col-sm-12">
        <!-- Inicio de formulario -->
        <div id="frm-visualizar" class="box">
            <div class="box-header">
                <div class="box-name">
                    <i class="fa fa-eye"></i> <span>Ver Pariente</span>
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
                <h4 class="page-header">Ver registro</h4>
                <form class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="guardar();">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Primer nombre</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre" id="primerNombreVi" name="primerNombre" required>
                        </div>
                        <label class="col-sm-2 control-label">Segundo nombre</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombreVi" name="segundoNombre">
                        </div>
                        <label class="col-sm-2 control-label">Primer apellido</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellidoVi"
                                   name="primerApellido" required>
                        </div>
                        <label class="col-sm-2 control-label">Segundo apellido</label>
                        <div class="col-sm-4">
                            <input readonly type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellidoVi"
                                   name="segundoApellido">
                        </div>
                    </div>

                    <div class="form-group has-success has-feedback">
                        <label class="col-sm-2 control-label">Ocupacion</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Ocupacion" id="ocupacionVi" name="ocupacion">
                        </div>
                        <label class="col-sm-2 control-label">Lugar de trabajo</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajoVi"
                                   name="lugarTrabajo">
                        </div>
                        <label class="col-sm-2 control-label">Cargo</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Cargo" id="cargoVi" name="cargo">
                            <span class="fa fa-check-square-o txt-success form-control-feedback"></span>
                        </div>
                        <label class="col-sm-2 control-label">Salario</label>
                        <div class="col-sm-4">
                            <input disabled readonly type="number" class="form-control" placeholder="Salario" id="salarioVi" name="salario">
                        </div>
                    </div>

                    <div class="form-group has-warning has-feedback">
                        <label class="col-sm-2 control-label">Edad</label>
                        <div class="col-sm-4">
                        <input disabled type="text" class="form-control" placeholder="Edad"
                               id="edadVi" name="edad" required>
                        <span class="fa fa-calendar txt-danger form-control-feedback"></span>
                        </div>

                        <label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select disabled id="escolaridadIdVi" required>
                                <option value="">Escolaridad</option>
                                <%
                               // DtPaciente dtpp = new DtPaciente();
                                ResultSet res11 = dtpp.cargarEscolaridades();
                                
                                    res11.beforeFirst();

                                    while (res11.next()) {
                                %>

                                <option value="<%=res11.getInt("EscolaridadID")%>"><%=res11.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select disabled id="escolaridaddetalleView">
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option>
                                        <option value="12">Concluida</option> 
                                        <option value="13">Otro</option>
                                    </select>
                                </div>
                    </div>

                    <div class="form-group has-error has-feedback">
                        <label class="col-sm-2 control-label">Estado de vida</label>
                        <div class="col-sm-4">
                            <select disabled id="estadoVidaVi">
                                <option value=2>Seleccione</option>
                                <option value=1>Vivo(a)</option>
                                <option value=0>Fallecido(a)</option>
                            </select>
                        </div>
                        <div id="causaMuerteDivVi">
                            <label class="col-sm-2 control-label">Causa de muerte</label>
                            <div class="col-sm-4" >
                                <input disabled type="text" class="form-control"
                                       placeholder="Causa de muerte" data-toggle="tooltip"
                                       data-placement="bottom" title="Causa de muerte"
                                       id="causaMuerteVi" name="causaMuerte">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Parentesco</label>
                        <div class="col-sm-4">
                            <select disabled name="parentesco" id="parentescoidVi">
                                <option>Seleccione</option>

                                <%
                                rs.close();
								rs = null;
							//	DtParentesco dtpar = new DtParentesco();
								rs = dtpar.cargarDatos();
                                    rs.beforeFirst();

                                    while (rs.next()) {
                                %>
                                <option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <label class="col-sm-2 control-label">¿Este pariente es
                            tutor?</label>
                        <div class="col-sm-4">
                            <select disabled id="tutorVi">
                                <option>Seleccione</option>
                                <option value=1>Si</option>
                                <option value=0>No</option>
                            </select>
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
                    </div>
                </form>
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
						parientes</span>
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

				<table class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Nombre completo</th>
							<th>Estado de vida</th>
							<th>Edad</th>
							<th>Tutor</th>
							<th>Parentesco</th>
							<th>Acciones</th>
						</tr>
					</thead>

					<tbody>
						<%
						//DtConsulta dtcon = new DtConsulta();
							DtPariente dtpari = new DtPariente();
							ResultSet rp = dtpari.cargarDatosApsicologo(us.getUsuarioID());
                          //  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                            //SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");
							rp.beforeFirst();
							while (rp.next()) {
						%>
						<tr>

							<td><%=rp.getString("Nombre1par") + " " + rp.getString("Nombre2par") + " " + rp.getString("Apellido1par")
						+ " " + rp.getString("Apellido2par")%></td>
							<%
								if (rp.getInt("Estadovidapar") == 1) {
							%>
							<td>Vivo</td>
							<%
								}
							%>
							<%
								if (rp.getInt("Estadovidapar") == 0) {
							%>
							<td>Fallecido</td>
							<%
								}
							%>
							<td><%=rp.getString("Edadpar")%></td>
							<%
								if (rp.getInt("Tutorpar") == 1) {
							%>
							<td>Si</td>
							<%
								}
							%>
							<%
								if (rp.getInt("Tutorpar") == 0) {
							%>
							<td>No</td>
							<%
								}
							%>
							<td><%=rp.getString("Parentescopar")%></td>
							
                            <td> 
<%--                                 <% Date fecha = formatter.parse(rp.getString("Fechanac")); %> --%>
                              <button id="btnIdVisualizar"
								onClick="visualizarDatos(this.value, '<%=rp.getString("Nombre1par")%>',
								'<%=rp.getString("Nombre2par")%>',
								'<%=rp.getString("Apellido1par")%>',
								'<%=rp.getString("Apellido2par")%>',
								'<%=rp.getString("Ocupacionpar")%>',
								'<%=rp.getString("Lugartrabajopar")%>',
								'<%=rp.getString("Cargopar")%>',
								'<%=rp.getString("Salariomensualpar")%>',
								'<%=rp.getString("Edadpar")%>',
<%-- 								'<%=fechaM.format(fecha)%>', --%>
								'<%=rp.getInt("EscolaridadIDpar")%>',
								'<%=rp.getString("Escolaridadpar")%>',
								'<%=rp.getInt("Estadovidapar")%>',
								'<%=rp.getString("Causamuertepar")%>',
								'<%=rp.getInt("ParentescoIDpar")%>',
								'<%=rp.getInt("Tutorpar")%>');"
								value=<%=rp.getInt("ParienteIDpar")%> class="btn btn-info">
								<span><i class="fa fa-eye"></i></span>
								Ver Pariente
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, '<%=rp.getString("Nombre1par")%>',
										'<%=rp.getString("Nombre2par")%>',
										'<%=rp.getString("Apellido1par")%>',
										'<%=rp.getString("Apellido2par")%>',
                                            '<%=rp.getString("Ocupacionpar")%>',
                                            '<%=rp.getString("Lugartrabajopar")%>',
                                            '<%=rp.getString("Cargopar")%>',
                                            '<%=rp.getString("Salariomensualpar")%>',
                                            '<%=rp.getString("Edadpar")%>',
<%--                                             '<%=fechaM.format(fecha)%>', --%>
                                            '<%=rp.getInt("EscolaridadIDpar")%>',
                                            '<%=rp.getString("Escolaridadpar")%>',
										'<%=rp.getInt("Estadovidapar")%>',
										'<%=rp.getString("Causamuertepar")%>',
                                            '<%=rp.getInt("ParentescoIDpar")%>',
										'<%=rp.getInt("Tutorpar")%>');"
									value=<%=rp.getInt("ParienteIDpar")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>

								<button id="btnIdEliminar" value=<%=rp.getInt("ParienteIDpar")%>
										class='ajax-link action btn btn-default btn-label-left'
								onClick='eliminar(this.value);'>
								<span><i class="fa fa-trash-o txt-danger"></i></span> Eliminar
								</button>
								
								

							</td>

							
						</tr>
						<%
							}
						%>

					</tbody>
					<tfoot>
						<tr>
                            <th>Nombre completo</th>
                            <th>Estado de vida</th>
                            <th>Edad</th>
                            <th>Tutor</th>
                            <th>Parentesco</th>
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
			<li><a href="#" class="active ajax-link">Gestión paciente</a>
			<li><a href="#">Pariente</a>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<!-- Inicio de formulario -->
		<div id="frm-agrega" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-address-card-o"></i> <span>Registro Pariente</span>
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
							<input type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre" id="primerNombre" name="primerNombre" required>
						</div>
						<label class="col-sm-2 control-label">Segundo nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombre" name="segundoNombre">
						</div>
						<label class="col-sm-2 control-label">Primer apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellido"
									name="primerApellido" required>
						</div>
						<label class="col-sm-2 control-label">Segundo apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellido"
									name="segundoApellido">
						</div>
					</div>

                    <div class="form-group">
					<label class="col-sm-2 control-label">Ocupacion</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Ocupacion" id="ocupacion" name="ocupacion">
						</div>
						<label class="col-sm-2 control-label">Lugar de trabajo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajo"
									name="lugarTrabajo">
						</div>
						<label class="col-sm-2 control-label">Cargo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Cargo" id="cargo" name="cargo">
<!-- 							<span class="fa fa-check-square-o txt-success form-control-feedback"></span> -->
						</div>
						<label class="col-sm-2 control-label">Salario</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" placeholder="Salario" id="salario" name="salario">
						</div>
					</div>

                    <div class="form-group">
						<label class="col-sm-2 control-label">Edad</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Edad"
									id="edad" name="edad" required>
							<span class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select id="escolaridadId" required>
                                <option value="">Escolaridad</option>
                                <%
                                    DtPaciente dtpp = new DtPaciente();
                                    ResultSet res1 = dtpp.cargarEscolaridades();
                                    res1.beforeFirst();

                                    while (res1.next()) {
                                %>

                                <option value="<%=res1.getInt("EscolaridadID")%>"><%=res1.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select id="escolaridaddetalle" required>
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option>
                                         <option value="12">Concluida</option>  
                                        <option value="13">Otro</option>
                                    </select>
                                </div>		
					</div>

                    <div class="form-group">
						<label class="col-sm-2 control-label">Estado de vida</label>
						<div class="col-sm-4">
							<select id="estadoVida">
									<option value=2>Seleccione</option>
									<option value=1>Vivo(a)</option>
									<option value=0>Fallecido(a)</option>
								</select>
						</div>
                        <div id="causaMuerteDiv">
						<label class="col-sm-2 control-label">Causa de muerte</label>
						<div class="col-sm-4" >
							<input type="text" class="form-control"
									placeholder="Causa de muerte" data-toggle="tooltip"
									data-placement="bottom" title="Causa de muerte"
									id="causaMuerte" name="causaMuerte">
                        </div>
					    </div>
                    </div>

                    <div class="form-group">
							<label class="col-sm-2 control-label">Parentesco</label>
							<div class="col-sm-4">
								<select name="parentesco" id="parentesco">
									<option>Seleccione</option>
									
									<%
										rs.close();
										rs = null;
										DtParentesco dtpar = new DtParentesco();
										rs = dtpar.cargarDatos();
										rs.beforeFirst();

										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

									<%
										}
									%>
								</select>
							</div>
							<label class="col-sm-2 control-label">¿Este pariente es
								tutor?</label>
							<div class="col-sm-4">
								<select id="tutor">
                                    <option>Seleccione</option>
									<option value=1>Sí</option>
									<option value=0>No</option>
								</select>
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

<!-- inicio de formulario para editar un pariente -->

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<!-- Inicio de formulario -->
		<div id="frm-edita" class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-file-text-o"></i> <span>Formulario de
						Actualización Pariente</span>
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
 				<form id="editar" class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="actualizar($('#btnEditar').val());">
					<div class="form-group">
						<label class="col-sm-2 control-label">Primer nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre"  id="primerNombreEditar"
										name="primerNombre">
						</div>
						<label class="col-sm-2 control-label">Segundo nombre</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombreEditar"
										name="segundoNombre">
						</div>
						<label class="col-sm-2 control-label">Primer apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellidoEditar"
										name="primerApellido">
						</div>
						<label class="col-sm-2 control-label">Segundo apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellidoEditar"
										name="segundoApellido">
						</div>
					</div>

                    <div class="form-group has-success has-feedback">
					<label class="col-sm-2 control-label">Ocupacion</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Ocupacion" id="ocupacionEditar" name="ocupacion">
						</div>
						<label class="col-sm-2 control-label">Lugar de trabajo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajoEditar"
									name="lugarTrabajo">
						</div>
						<label class="col-sm-2 control-label">Cargo</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Cargo" id="cargoEditar" name="cargo">
<!-- 							<span class="fa fa-check-square-o txt-success form-control-feedback"></span> -->
						</div>
						<label class="col-sm-2 control-label">Salario</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" placeholder="Salario" id="salarioEditar" name="salario">
						</div>
					</div>

                    <div class="form-group has-warning has-feedback">
						<label class="col-sm-2 control-label">Edad</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Edad"
									id="edadEditar" name="edad">
							<span class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
					<label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select id="escolaridadIdEditar" required>
                                <option value="">Escolaridad</option>
                                <%

                                    res1.beforeFirst();

                                    while (res1.next()) {
                                %>

                                <option value="<%=res1.getInt("EscolaridadID")%>"><%=res1.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select id="escolaridaddetalleedit">
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option> 
                                         <option value="12">Concluida</option> 
                                        <option value="13">Otro</option>
                                    </select>
                                </div>
					</div>

                    <div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Estado de vida</label>
						<div class="col-sm-4">
							<select id="estadoVidaEditar">
									
									<option value=1>Vivo(a)</option>
									<option value=0>Fallecido(a)</option>
								</select>
						</div>
						<label class="col-sm-2 control-label">Causa de muerte</label>
						<div class="col-sm-4">
							<input type="text" class="form-control"
									placeholder="Causa de muerte" data-toggle="tooltip"
									data-placement="bottom" title="Causa de muerte"
									id="causaMuerteEditar" name="causaMuerte">
						
					    </div>
                    </div>

                    <div class="form-group">
							<label class="col-sm-2 control-label">Parentesco</label>
							<div class="col-sm-4">
								<select name="parentesco" id="parentescoidEditar"
										>
										
										<%
											rs.beforeFirst();

											while (rs.next()) {
										%>
										<option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

										<%
											}
										%>
									</select>
							</div>
							<label class="col-sm-2 control-label">¿Este pariente es
								tutor?</label>
							<div class="col-sm-4">
								<select id="tutorEditar" >
									
									<option value=1>Si</option>
									<option value=0>No</option>
								</select>
							</div>
					</div>

                    <div class="clearfix"></div>
					<div class="form-group">
						<div id="cancelar_nuevo_editar" class="col-sm-offset-2 col-sm-2">
							<button class="ajax-link action btn btn-default btn-label-left"
								type="reset" title="Cancelar">
								<span><i class="fa fa-minus-circle txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button id="btnEditar"
								class="ajax-link btn btn-primary btn-label-left"
								onClick="" title="Editar">
								<span><i class="fa fa-check-circle txt-success"></i></span> Editar
							</button>
						</div>
					</div>
 				</form> 
            </div>
		</div>
	</div>
</div>

<!-- Formulario visualizar -->
<div class="row">
    <div class="col-xs-12 col-sm-12">
        <!-- Inicio de formulario -->
        <div id="frm-visualizar" class="box">
            <div class="box-header">
                <div class="box-name">
                    <i class="fa fa-eye"></i> <span>Ver Pariente</span>
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
                <h4 class="page-header">Ver registro</h4>
                <form class="form-horizontal" role ="form" action="javascript:void(0);" onsubmit="guardar();">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Primer nombre</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Primer nombre"data-toggle="tooltip" data-placement="bottom" title="Primer nombre" id="primerNombreVi" name="primerNombre" required>
                        </div>
                        <label class="col-sm-2 control-label">Segundo nombre</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Segundo nombre"data-toggle="tooltip" data-placement="bottom" title="Segundo nombre" id="segundoNombreVi" name="segundoNombre">
                        </div>
                        <label class="col-sm-2 control-label">Primer apellido</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Primer apellido"data-toggle="tooltip" data-placement="bottom" title="Primer apellido" id="primerApellidoVi"
                                   name="primerApellido" required>
                        </div>
                        <label class="col-sm-2 control-label">Segundo apellido</label>
                        <div class="col-sm-4">
                            <input readonly type="text" class="form-control" placeholder="Segundo apellido"data-toggle="tooltip" data-placement="bottom" title="Segundo apellido" id="segundoApellidoVi"
                                   name="segundoApellido">
                        </div>
                    </div>

                    <div class="form-group has-success has-feedback">
                        <label class="col-sm-2 control-label">Ocupacion</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Ocupacion" id="ocupacionVi" name="ocupacion">
                        </div>
                        <label class="col-sm-2 control-label">Lugar de trabajo</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Lugar de trabajo" id="lugarTrabajoVi"
                                   name="lugarTrabajo">
                        </div>
                        <label class="col-sm-2 control-label">Cargo</label>
                        <div class="col-sm-4">
                            <input disabled type="text" class="form-control" placeholder="Cargo" id="cargoVi" name="cargo">
                            <span class="fa fa-check-square-o txt-success form-control-feedback"></span>
                        </div>
                        <label class="col-sm-2 control-label">Salario</label>
                        <div class="col-sm-4">
                            <input disabled type="number" class="form-control" placeholder="Salario" id="salarioVi" name="salario">
                        </div>
                    </div>

                    <div class="form-group has-warning has-feedback">
                        <label class="col-sm-2 control-label">Edad</label>
                        <div class="col-sm-4">
                        <input disabled type="text" class="form-control" placeholder="Edad"
                               id="edadVi" name="edad" required>
                        <span class="fa fa-calendar txt-danger form-control-feedback"></span>
                        </div>


                        <label class="col-sm-2 control-label">Escolaridad</label>
                        <div class="col-sm-2">
                            <select disabled id="escolaridadIdVi" required>
                                <option value="">Escolaridad</option>
                                <%

                                    res1.beforeFirst();

                                    while (res1.next()) {
                                %>

                                <option value="<%=res1.getInt("EscolaridadID")%>"><%=res1.getString("Nombre")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-sm-2">
                                    <select disabled id="escolaridaddetalleView">
                                        <option>Seleccione</option>
                                        <option value="1">1er</option>
					   					<option value="2">2do</option>
                                        <option value="3">3er</option>
                                        <option value="4">4to</option>
                                        <option value="5">5to</option>
                                        <option value="6">6to</option>
                                        <option value="7">7mo</option>
                                        <option value="8">8vo</option>
                                        <option value="9">9no</option>
                                        <option value="10">10mo</option>
                                        <option value="11">11vo</option>
                                        <option value="12">Concluida</option> 
                                        <option value="13">Otro</option>
                                    </select>
                                </div>
                    </div>

                    <div class="form-group has-error has-feedback">
                        <label class="col-sm-2 control-label">Estado de vida</label>
                        <div class="col-sm-4">
                            <select disabled id="estadoVidaVi">
                                <option value=2>Seleccione</option>
                                <option value=1>Vivo(a)</option>
                                <option value=0>Fallecido(a)</option>
                            </select>
                        </div>
                        <div id="causaMuerteDivVi">
                            <label class="col-sm-2 control-label">Causa de muerte</label>
                            <div class="col-sm-4" >
                                <input disabled type="text" class="form-control"
                                       placeholder="Causa de muerte" data-toggle="tooltip"
                                       data-placement="bottom" title="Causa de muerte"
                                       id="causaMuerteVi" name="causaMuerte">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Parentesco</label>
                        <div class="col-sm-4">
                            <select disabled name="parentesco" id="parentescoidVi">
                                <option>Seleccione</option>

                                <%
                                   // rs = dtpar.cargarDatos();
                                    rs.beforeFirst();

                                    while (rs.next()) {
                                %>
                                <option value="<%=rs.getInt("ParentescoID")%>"><%=rs.getString("Parentesco")%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <label class="col-sm-2 control-label">¿Este pariente es
                            tutor?</label>
                        <div class="col-sm-4">
                            <select disabled id="tutorVi">
                                <option>Seleccione</option>
                                <option value=1>Si</option>
                                <option value=0>No</option>
                            </select>
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
                    </div>
                </form>
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
						parientes</span>
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

				<table class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							<th>Nombre completo</th>
							<th>Estado de vida</th>
							<th>Edad</th>
							<th>Tutor</th>
							<th>Parentesco</th>
							<th>Acciones</th>
						</tr>
					</thead>

					<tbody>
						<%
							rs.close();
							rs = null;
							DtVParienteParentesco dtparen = new DtVParienteParentesco();
							ResultSet rp = dtparen.cargarVista();
                          //  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                            //SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");
							rp.beforeFirst();
							while (rp.next()) {
						%>
						<tr>

							<td><%=rp.getString("Nombre1") + " " + rp.getString("Nombre2") + " " + rp.getString("Apellido1")
						+ " " + rp.getString("Apellido2")%></td>
							<%
								if (rp.getInt("Estadovida") == 1) {
							%>
							<td>Vivo</td>
							<%
								}
							%>
							<%
								if (rp.getInt("Estadovida") == 0) {
							%>
							<td>Fallecido</td>
							<%
								}
							%>
							<td><%=rp.getString("Edad")%></td>
							<%
								if (rp.getInt("Tutor") == 1) {
							%>
							<td>Si</td>
							<%
								}
							%>
							<%
								if (rp.getInt("Tutor") == 0) {
							%>
							<td>No</td>
							<%
								}
							%>
							<td><%=rp.getString("Parentesco")%></td>
                           
                            <td> 
<%--                                 <% Date fecha = formatter.parse(rp.getString("Fechanac")); %> --%>

								<button id="btnIdVisualizar"
								onClick="visualizarDatos(this.value, '<%=rp.getString("Nombre1")%>',
								'<%=rp.getString("Nombre2")%>',
								'<%=rp.getString("Apellido1")%>',
								'<%=rp.getString("Apellido2")%>',
								'<%=rp.getString("Ocupacion")%>',
								'<%=rp.getString("Lugartrabajo")%>',
								'<%=rp.getString("Cargo")%>',
								'<%=rp.getString("Salariomensual")%>',
								'<%=rp.getString("Edad")%>',
<%-- 								'<%=fechaM.format(fecha)%>', --%>
								'<%=rp.getInt("EscolaridadID")%>',
								'<%=rp.getString("Escolaridad")%>',
								'<%=rp.getInt("Estadovida")%>',
								'<%=rp.getString("Causamuerte")%>',
								'<%=rp.getInt("ParentescoID")%>',
								'<%=rp.getInt("Tutor")%>');"
								value=<%=rp.getInt("ParienteID")%> class="btn btn-info">
								<span><i class="fa fa-eye"></i></span>
								Ver Pariente
								</button>

								<button id='btnIdActualizar'
									class="btn btn-primary btn-label-left"
									OnClick="cargarDatos(this.value, '<%=rp.getString("Nombre1")%>',
										'<%=rp.getString("Nombre2")%>',
										'<%=rp.getString("Apellido1")%>',
										'<%=rp.getString("Apellido2")%>',
                                            '<%=rp.getString("Ocupacion")%>',
                                            '<%=rp.getString("Lugartrabajo")%>',
                                            '<%=rp.getString("Cargo")%>',
                                            '<%=rp.getString("Salariomensual")%>',
                                            '<%=rp.getString("Edad")%>',
<%--                                             '<%=fechaM.format(fecha)%>', --%>
                                            '<%=rp.getInt("EscolaridadID")%>',
                                            '<%=rp.getString("Escolaridad")%>',
										'<%=rp.getInt("Estadovida")%>',
										'<%=rp.getString("Causamuerte")%>',
                                            '<%=rp.getInt("ParentescoID")%>',
										'<%=rp.getInt("Tutor")%>');"
									value=<%=rp.getInt("ParienteID")%> class="btn btn-info">
									<span><i class="fa fa-edit"></i></span> Actualizar
								</button>

								<button id="btnIdEliminar" value=<%=rp.getInt("ParienteID")%>
										class='ajax-link action btn btn-default btn-label-left'
								onClick='eliminar(this.value);'>
								<span><i class="fa fa-trash-o txt-danger"></i></span> Eliminar
								</button>


							</td>
							
						</tr>
						<%
							}
						%>

					</tbody>
					<tfoot>
						<tr>
                            <th>Nombre completo</th>
                            <th>Estado de vida</th>
                            <th>Edad</th>
                            <th>Tutor</th>
                            <th>Parentesco</th>
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
		guardarPariente();
		//refrescar();
		//websocket.send("Guardar");

	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ACTUALIZAR
	function actualizar(idClicked) {
		//refrescar();
		actualizarPariente(idClicked);
		//websocket.send("Modificar");
	}

	//MÉTODO PARA EJECUTAR EL WEBSOCKET.ONMESSAGE Y ELIMINAR
	function eliminar(idClicked) {
		confirm(function(){
			eliminarPariente(idClicked);
		
		  }, function(){
			  infoAlert('Aviso', 'Eliminación cancelada');
		  });
		
	}

	//MÉTODO PARA REFRESCAR EL DATATABLE A TRAVÉS DEL SERVLET
	function refrescar() {
		var opcion = "";
		opcion = "refrescar";

		$.ajax({
			url : "SlPariente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion
			},
			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').DataTable().fnDestroy();
				AllTables();
				$('#datatable-1').addClass("dataTables_wrapper form-inline");
				
			}

		});

	}
	
	function refrescarApsicologo() {
		var fusuarioID = "";
		fusuarioID = $('#usuarioID').val();
		
		var opcion = "";
		opcion = "refrescarApsicologo";

		$.ajax({
			url : "SlPariente",
			type : "post",
			datatype : 'html',
			data : {
				'fusuarioID' : fusuarioID,
				'opcion' : opcion
			},
			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').DataTable().fnDestroy();
				AllTables();
				$('#datatable-1').addClass("dataTables_wrapper form-inline");
				
			}

		});

	}

	//MÉTODO PARA GUARDAR EL REGISTRO A TRAVÉS DEL SERVLET
	function guardarPariente() {
		var fprimerNombre = "";
		var fsegundoNombre = "";
		var fprimerApellido = "";
		var fsegundoApellido = "";
		var festadoVida = 0;
		var fedad = "";
       // var ffechaNac = "";
		var fcausaMuerte = "";
		var fescolaridadId=0;
		var fescolaridad = "";
		var focupacion = "";
		var flugarTrabajo = "";
		var fcargo = "";
		var fsalarioMensual = 0.0;
		var ftutor = 0;
		var fparentescoid = 0;

		
        var fusuarioID = 0;
		
		fusuarioID = $('#usuarioID').val();
		var opcion = "";

		opcion = "guardar";
		fprimerNombre = $("#primerNombre").val();
		fsegundoNombre = $("#segundoNombre").val();
		fprimerApellido = $("#primerApellido").val();
		fsegundoApellido = $("#segundoApellido").val();
		festadoVida = $("#estadoVida").val();
		fcausaMuerte = $("#causaMuerte").val();
		fescolaridadId = $("#escolaridadId").val();
		fescolaridad = $('#escolaridaddetalle').val();
        fedad = $('#edad').val();
		focupacion = $("#ocupacion").val();
		flugarTrabajo = $("#lugarTrabajo").val();
		fcargo = $("#cargo").val();
		fsalarioMensual = $("#salario").val();
		ftutor = $("#tutor").val();
		fparentescoid = $("#parentesco").val();
		var tiporol =  0;
		tiporol = $('#TipoRol').val();
		console.log('tipo rol'+tiporol);


		$.ajax({
			url : "SlPariente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fprimerNombre' : fprimerNombre,
				'fsegundoNombre' : fsegundoNombre,
				'fprimerApellido' : fprimerApellido,
				'fsegundoApellido' : fsegundoApellido,
				'festadoVida' : festadoVida,
				'fedad' : fedad,
				'fcausaMuerte' : fcausaMuerte,
                'fescolaridadId' : fescolaridadId,
				'fescolaridad' : fescolaridad,
				'focupacion' : focupacion,
				'flugarTrabajo' : flugarTrabajo,
				'fcargo' : fcargo,
				'fsalarioMensual' : fsalarioMensual,
				'ftutor' : ftutor,
				'fparentescoid' : fparentescoid,
				'fusuarioID' : fusuarioID

			},
			success : function(data) {
				if(tiporol == 3 || tiporol == 5){
					
					successAlert('Listo', 'Guardado exitosamente');
	                $("#agregar")[0].reset();
	                $('#frm-agrega').fadeOut();	
	                refrescarApsicologo();
					
				}else{
					
					successAlert('Listo', 'Guardado exitosamente');
	                $("#agregar")[0].reset();
	                $('#frm-agrega').fadeOut();	
	                refrescar();
			
				}
			}
			

		});

	}

	//MÉTODO PARA ELIMINAR EL REGISTRO A TRAVÉS DEL SERVLET
	function eliminarPariente(idClicked) {
		var opcion = "";
		var fparienteID = idClicked;
		var tiporol =  0;
		tiporol = $('#TipoRol').val();
		opcion = "eliminar";

		$.ajax({
			url : "SlPariente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fparienteID' : fparienteID
			},
			success : function(data) {
				//websocket.send("Eliminar");
				
			
				if(tiporol == 3 || tiporol == 5){
					
					successAlert('Listo', 'Eliminado exitosamente');
					refrescarApsicologo();
					
				}else{
					
					successAlert('Listo', 'Eliminado exitosamente');
					refrescar();
			
				}
				
			}

		});

	}

	//MÉTODO PARA ACTUALIZAR EL REGISTRO A TRAVÉS DEL SERVLET
	function actualizarPariente(idClicked) {
		var opcion = "";
		var fParienteId = idClicked;
		var fprimerNombreEditar = "";
		var fsegundoNombreEditar = "";
		var fprimerApellidoEditar = "";
		var fsegundoApellidoEditar = "";
		var festadoVidaEditar;
		var fedadEditar = "";
     //   var ffechaNac;
		var fcausaMuerteEditar = "";
		var fescolaridadIdEditar=0;
		var fescolaridadEditar = "";
		var focupacionEditar = "";
		var flugarTrabajoEditar = "";
		var fcargoEditar = "";
		var fsalarioMensualEditar;
		var ftutorEditar;
		var fparentescoidEditar;

		var tiporol =  0;
		tiporol = $('#TipoRol').val();

		opcion = "actualizar";
		fprimerNombreEditar = $("#primerNombreEditar").val();
		fsegundoNombreEditar = $("#segundoNombreEditar").val();
		fprimerApellidoEditar = $("#primerApellidoEditar").val();
		fsegundoApellidoEditar = $("#segundoApellidoEditar").val();
		festadoVidaEditar = $("#estadoVidaEditar").val();
		fcausaMuerteEditar = $("#causaMuerteEditar").val();
        fedadEditar = $('#edadEditar').val();
        fescolaridadIdEditar=$("#escolaridadIdEditar").val();
		fescolaridadEditar = $('#escolaridaddetalleedit').val();
		focupacionEditar = $("#ocupacionEditar").val();
		flugarTrabajoEditar = $("#lugarTrabajoEditar").val();
		fcargoEditar = $("#cargoEditar").val();
		fsalarioMensualEditar = $("#salarioEditar").val();
		ftutorEditar = $("#tutorEditar").val();
		fparentescoidEditar = $("#parentescoidEditar").val();

        //Calcular edad
//         var fecha = new Date();
//         var year = fecha.getFullYear();
//         var age = parseInt(ffechaNac.substring(6, 10));
//         var realAge = year - age;
//         console.log("realAgeEdit is: "+realAge);
//         $('#edadEditar').val(realAge);
//         fedadEditar = $('#edadEditar').val();

		$.ajax({
			url : "SlPariente",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion,
				'fParienteId' : fParienteId,
				'fprimerNombreEditar' : fprimerNombreEditar,
				'fsegundoNombreEditar' : fsegundoNombreEditar,
				'fprimerApellidoEditar' : fprimerApellidoEditar,
				'fsegundoApellidoEditar' : fsegundoApellidoEditar,
				'festadoVidaEditar' : festadoVidaEditar,
				'fedadEditar' : fedadEditar,
             //   'ffechaNac' : ffechaNac,
				'fcausaMuerteEditar' : fcausaMuerteEditar,
                'fescolaridadIdEditar' : fescolaridadIdEditar,
				'fescolaridadEditar' : fescolaridadEditar,
				'focupacionEditar' : focupacionEditar,
				'flugarTrabajoEditar' : flugarTrabajoEditar,
				'fcargoEditar' : fcargoEditar,
				'fsalarioMensualEditar' : fsalarioMensualEditar,
				'ftutorEditar' : ftutorEditar,
				'fparentescoidEditar' : fparentescoidEditar

			},
			success : function(data) {
				//websocket.send("Modificar");
				
				
				if(tiporol == 3 || tiporol == 5){
					
					successAlert('Listo', 'Actualizado exitosamente');
	                $("#editar")[0].reset();
					$('#frm-edita').fadeOut();
					refrescarApsicologo();
					
				}else{
					
					successAlert('Listo', 'Actualizado exitosamente');
	                $("#editar")[0].reset();
					$('#frm-edita').fadeOut();
					refrescar();
			
				}
			}

		});
	}

	//MÉTODO PARA CARGAR DATOS EN EL FORMULARIO
	function cargarDatos(parienteId, primerNombre, segundoNombre,
			primerApellido, segundoApellido, ocupacion, lugarTrabajo, cargo, salarioMensual, edad, escolaridadId,escolaridad, estadoVida, causaMuerte, parentescoId,
                         tutor ) {

		var fParienteId = parienteId;
		var fprimerNombre = primerNombre;
		var fsegundoNombre = segundoNombre;
		var fprimerApellido = primerApellido;
		var fsegundoApellido = segundoApellido;
        var focupacion = ocupacion;
        var flugarTrabajo = lugarTrabajo;
        var fcargo = cargo;
        var fsalarioMensual = salarioMensual;
        var fedad = edad;
       // var ffechaNac= fechaNac;
        var fescolaridadId=escolaridadId;
        var fescolaridad = escolaridad;
		var festadoVida = estadoVida;
		var fcausaMuerte = causaMuerte;
        var fparentescoid = parentescoId;
		var ftutor = tutor;


		$('#btnEditar').val(fParienteId);
		$("#primerNombreEditar").val(fprimerNombre);
		$("#segundoNombreEditar").val(fsegundoNombre);
		$("#primerApellidoEditar").val(fprimerApellido);
		$("#segundoApellidoEditar").val(fsegundoApellido);
        $("#ocupacionEditar").val(focupacion);
        $("#lugarTrabajoEditar").val(flugarTrabajo);
        $("#cargoEditar").val(fcargo);
        $("#salarioEditar").val(fsalarioMensual);
        $("#edadEditar").val(fedad);
     //   $('#fechaNacEdit').val(ffechaNac);
        $('#escolaridadIdEditar').val(fescolaridadId).change();
        $('#escolaridaddetalleedit').val(fescolaridad).change();
		$("#estadoVidaEditar").val(festadoVida).change();
		$("#causaMuerteEditar").val(fcausaMuerte);
        $("#parentescoidEditar").val(fparentescoid).change();
        $("#tutorEditar").val(ftutor).change();

		$('#frm-edita').fadeIn();
		$('#frm-agrega').fadeOut();
	}

    //Metodo para visualizar pariente
    function visualizarDatos(parienteId, primerNombre, segundoNombre,
                             primerApellido, segundoApellido, ocupacion, lugarTrabajo, cargo, salarioMensual, edad, escolaridadId,escolaridad, estadoVida, causaMuerte, parentescoId,
                             tutor ) {
        var fParienteId = parienteId;
        var fprimerNombre = primerNombre;
        var fsegundoNombre = segundoNombre;
        var fprimerApellido = primerApellido;
        var fsegundoApellido = segundoApellido;
        var focupacion = ocupacion;
        var flugarTrabajo = lugarTrabajo;
        var fcargo = cargo;
        var fsalarioMensual = salarioMensual;
        var fedad = edad;
      //  var ffechaNac= fechaNac;
        var fescolaridadId= escolaridadId;
        var fescolaridad = escolaridad;
        var festadoVida = estadoVida;
        var fcausaMuerte = causaMuerte;
        var fparentescoid = parentescoId;
        var ftutor = tutor;

        $('#btnEditar').val(fParienteId);
        $("#primerNombreVi").val(fprimerNombre);
        $("#segundoNombreVi").val(fsegundoNombre);
        $("#primerApellidoVi").val(fprimerApellido);
        $("#segundoApellidoVi").val(fsegundoApellido);
        $("#ocupacionVi").val(focupacion);
        $("#lugarTrabajoVi").val(flugarTrabajo);
        $("#cargoVi").val(fcargo);
        $("#salarioVi").val(fsalarioMensual);
        $("#edadVi").val(fedad);
      //  $('#fechaNacVi').val(ffechaNac);
        $("#escolaridadIdVi").val(fescolaridadId).change();
        $('#escolaridaddetalleView').val(fescolaridad).change();
        $("#estadoVidaVi").val(festadoVida).change();
        $("#causaMuerteVi").val(fcausaMuerte);
        $("#parentescoidVi").val(fparentescoid).change();
        $("#tutorVi").val(ftutor).change();

        $('#frm-visualizar').fadeIn();

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

	function Selects() {
		$('#pacienteId').select({
			placeholder : "Seleccione un paciente"
		});
		$('#pacienteIdEditar').select({
			placeholder : "Seleccione un paciente"
		});
	}
	// Run timepicker
	function TimePicker() {
		$('#hora').timepicker({
			setDate : new Date()
		});

		$('#horaEditar').timepicker({
			setDate : new Date()
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

		$('#estadoVida').change(function () {
            if( $(this).val() == 0) {
                $('#causaMuerte').prop( "disabled", false );
            } else {
                $('#causaMuerte').prop( "disabled", true );
            }
		});



		$('#frm-agrega').hide();
		$('#frm-edita').hide();
		$('#frm-visualizar').hide();
		// Initialize datepicker
		//$('#fecha').datepicker({
			//setDate : new Date()
		//});
		//$('#fechaEditar').datepicker({
			//setDate : new Date()
		//});

      // $("#fechaNac").mask("99/99/9999",{placeholder:"dd/mm/aaaa"});
        //$("#fechaNacEdit").mask("99/99/9999",{placeholder:"dd/mm/aaaa"});
		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);
		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		
		$('.form-control').tooltip();

		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			
			$('#frm-agrega').fadeIn();
			$('#frm-edita').fadeOut();
            $('#frm-visualizar').fadeOut();
			
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