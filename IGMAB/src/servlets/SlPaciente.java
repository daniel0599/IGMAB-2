package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.Date;

import datos.DtConsulta;
import datos.DtPaciente;
import datos.DtRespuesta;
import entidades.Paciente;

/**
 * Servlet implementation class SlParentescoAjax
 */
@WebServlet("/SlPaciente")
public class SlPaciente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlPaciente() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		///////////////////////////// SE DECLARAN LAS VARIABLES QUE ALMACENAN
		///////////////////////////// LOS DATOS DE LA INTERFAZ DE
		///////////////////////////// USUARIO////////////////////////////////
		String opcion = request.getParameter("opcion").trim();
		String expediente, nombre1, nombre2, apellido1, apellido2, celular, edad, fechaNac, escolaridad, direccion, conQuienVive, empleo, lugarTrabajo, salario, internadoAfirmativo;
		int sexo, estadoCivil, internado, terapia, escolaridadId, estudianteUCA;
		DtPaciente dtp = new DtPaciente();
		Paciente pac = new Paciente();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {
				expediente = request.getParameter("fexpediente");
				System.out.println(expediente);
				nombre1 = request.getParameter("fnombre1");
				nombre2 = request.getParameter("fnombre2");
				apellido1 = request.getParameter("fapellido1");
				apellido2 = request.getParameter("fapellido2");
				celular = request.getParameter("fcelular");
				edad = request.getParameter("fedad");
				fechaNac = request.getParameter("ffechaNac");
				escolaridad = request.getParameter("fescolaridad");
				direccion = request.getParameter("fdireccion");
				conQuienVive = request.getParameter("fconquienvive");
				empleo = request.getParameter("fempleo");
				lugarTrabajo = request.getParameter("flugarTrabajo");
				salario = request.getParameter("fsalario");
				internadoAfirmativo = request.getParameter("finternadoAfirmativo");
				sexo = Integer.parseInt(request.getParameter("fsexo"));
				estadoCivil = Integer.parseInt(request.getParameter("festadoCivil"));
				internado = Integer.parseInt(request.getParameter("finternado"));
				terapia = Integer.parseInt(request.getParameter("fterapia"));
				escolaridadId = Integer.parseInt(request.getParameter("fescolaridadId"));
				estudianteUCA = Integer.parseInt(request.getParameter("festudianteUCA"));
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				Date fecha = formatter.parse(fechaNac);
				
				pac.setExpediente(expediente);
				pac.setNombre1(nombre1);
				pac.setNombre2(nombre2);
				pac.setApellido1(apellido1);
				pac.setApellido2(apellido2);
				pac.setCelular(celular);
				pac.setConQuienVive(conQuienVive);
				pac.setDireccion(direccion);
				pac.setEdad(edad);
				pac.setEmpleo(empleo);
				pac.setEscolaridad(escolaridad);
				pac.setEstadoCivil(estadoCivil);
				pac.setFechaNac(fecha);
				pac.setInternado(internado);
				pac.setInternadoAfirmativo(internadoAfirmativo);
				pac.setLugarTrabajo(lugarTrabajo);
				pac.setSalario(salario);
				pac.setSexo(sexo);
				pac.setTerapia(terapia);
				pac.setEscolaridadID(escolaridadId);
				pac.setEstudianteUCA(estudianteUCA);

				if (dtp.guardarPaciente(pac)) {
					System.out.println("Guardado exitosamente");
				}
			} catch (Exception e) {
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// ACTUALIZAR////////////////////////////////
		case "actualizar":
			try {
				int fpacienteId = Integer.parseInt(request.getParameter("fpacienteId"));
				nombre1 = request.getParameter("fnombre1");
				nombre2 = request.getParameter("fnombre2");
				apellido1 = request.getParameter("fapellido1");
				apellido2 = request.getParameter("fapellido2");
				celular = request.getParameter("fcelular");
				edad = request.getParameter("fedad");
				fechaNac = request.getParameter("ffechaNac");
				escolaridad = request.getParameter("fescolaridad");
				direccion = request.getParameter("fdireccion");
				conQuienVive = request.getParameter("fconquienvive");
				empleo = request.getParameter("fempleo");
				lugarTrabajo = request.getParameter("flugarTrabajo");
				salario = request.getParameter("fsalario");
				internadoAfirmativo = request.getParameter("finternadoAfirmativo");
				sexo = Integer.parseInt(request.getParameter("fsexo"));
				estadoCivil = Integer.parseInt(request.getParameter("festadoCivil"));
				internado = Integer.parseInt(request.getParameter("finternado"));
				terapia = Integer.parseInt(request.getParameter("fterapia"));
				escolaridadId = Integer.parseInt(request.getParameter("fescolaridadId"));
				estudianteUCA = Integer.parseInt(request.getParameter("festudianteUCA"));
				
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				Date fecha = formatter.parse(fechaNac);
				
				pac.setPacienteID(fpacienteId);
				pac.setNombre1(nombre1);
				pac.setNombre2(nombre2);
				pac.setApellido1(apellido1);
				pac.setApellido2(apellido2);
				pac.setCelular(celular);
				pac.setConQuienVive(conQuienVive);
				pac.setDireccion(direccion);
				pac.setEdad(edad);
				pac.setEmpleo(empleo);
				pac.setEscolaridad(escolaridad);
				pac.setEstadoCivil(estadoCivil);
				pac.setFechaNac(fecha);
				pac.setInternado(internado);
				pac.setInternadoAfirmativo(internadoAfirmativo);
				pac.setLugarTrabajo(lugarTrabajo);
				pac.setSalario(salario);
				pac.setSexo(sexo);
				pac.setTerapia(terapia);
				pac.setEscolaridadID(escolaridadId);
				pac.setEstudianteUCA(estudianteUCA);

				if (dtp.actualizarPaciente(pac)) {
					System.out.println("Actualizado exitosamente");
				}
			} catch (Exception e) {
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// ELIMINAR////////////////////////////////
		case "eliminar":
			try {
				int fpacienteId = Integer.parseInt(request.getParameter("fpacienteId"));
				System.out.println(fpacienteId);
				
				if(dtp.eliminarPaciente(fpacienteId)){
					System.out.println("Eliminado exitosamente");
				}
			}
			catch(Exception e) 
			{
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;

			case "eliminarAlta":
			try {
				int fpacienteId2 = Integer.parseInt(request.getParameter("fpacienteId2"));
				System.out.println(fpacienteId2);

				if(dtp.eliminarPacienteAlta(fpacienteId2)){
					System.out.println("Eliminado exitosamente");
				}
			}
			catch(Exception e)
			{
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// REFRESCAR LA
		/////////////////////////// TABLA////////////////////////////////
		case "refrescar":
			refrescar(request, response);
			break;

			case "refrescarInactivos":
				refrescarInactivos(request, response);
				break;

            case "refrescarDatosAlta":
                refrescarDadosAlta(request, response);
                break;
		
		case "transferir":
			int pacienteId = Integer.parseInt(request.getParameter("fpacienteId"));
			int psicologoId = Integer.parseInt(request.getParameter("fpsicologoId"));

			try {
				if(dtp.transferirPaciente(pacienteId, psicologoId)) {
					System.out.println("Transferencia exitosa");
				}
			}
			catch(Exception e)
			{
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			
			break;

			case "reactivar":
				int pacienteId1 = Integer.parseInt(request.getParameter("fpacienteId1"));
				try {
					if(dtp.reactivar(pacienteId1)) {

						System.out.println("Reactivacion exitosa");
					}
				}
				catch (Exception e)
				{
					System.out.println("SL: error en el servlet:" + e.getMessage());
					e.printStackTrace();
				}
				break;

				case "reactivarDadosAlta":
				int pacienteId2 = Integer.parseInt(request.getParameter("fpacienteId2"));
				try {
					if(dtp.reactivarDadoAlta(pacienteId2)) {

						System.out.println("Reactivacion exitosa");
					}
				}
				catch (Exception e)
				{
					System.out.println("SL: error en el servlet:" + e.getMessage());
					e.printStackTrace();
				}
				break;
			
		default: 
			System.out.println("Nothing to show");
			break;
		}

	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		int tiporol = 0;
		int usuarioID =0;
		
		tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));
		
		try {
			ResultSet rspac=null;
		    DtConsulta dtcon = new DtConsulta();
			DtPaciente dtp = new DtPaciente();
			DtRespuesta dtres = new DtRespuesta();
			
			if (tiporol == 1 || tiporol == 4) { //Carga TODOS los registros para Administrador y Directora
				rspac = dtp.cargarDatos();
			
			} else if (tiporol == 3) { //Carga únicamente los registros relacionados un psicólogo
				rspac = dtp.cargarPacientesAPsicologos(dtcon.obtenerPsicologoID(usuarioID));
			}	
			
			
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rspac.next()) {
				out += "<tr>";
				out += "<td>" + rspac.getString("Expediente") +"</td>";
				out += "<td>" + rspac.getString("Nombre1") + " " + rspac.getString("Nombre2") + " " + rspac.getString("Apellido1") + " " + rspac.getString("Apellido2")+ "</td>";
				out += "<td>" + rspac.getString("Edad") +"</td>";
				if(tiporol == 1){
				out +="<td>";
				Date fecha = formatter.parse(rspac.getString("Fechanac"));
				
				
				out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
						+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
						+ "\""+rspac.getString("Nombre2")+"\","
						+ "\""+rspac.getString("Apellido1")+"\","
						+ "\""+rspac.getString("Apellido2")+"\","
						+ "\""+rspac.getInt("Celular")+"\","
						+ "\""+rspac.getString("Edad")+"\","
						+ "\""+fechaM.format(fecha)+"\","
						+ "\""+rspac.getInt("Sexo")+"\","
						+ "\""+rspac.getInt("Estadocivil")+"\","
						+ "\""+rspac.getString("Escolaridad")+"\","
						+ "\""+rspac.getString("Direccion")+"\","
						+ "\""+rspac.getString("Conquienvive")+"\","
						+ "\""+rspac.getString("Lugartrabajo")+"\","
						+ "\""+rspac.getString("Empleo")+"\","
						+ "\""+rspac.getString("Salario")+"\","
						+ "\""+rspac.getInt("Terapia")+"\","
						+ "\""+rspac.getString("Internado")+"\","
						+ "\""+rspac.getString("Internadoafirmativo")+"\","
						+ "\""+rspac.getInt("EscolaridadID")+"\","
						+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";
				out += "<button id='btnIdActualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-primary btn-label-left btn-info' "
						+ "onclick = 'cargarDatos(this.value, \""+ rspac.getString("Nombre1") + "\", "
						+ "\""+rspac.getString("Nombre2")+"\","
						+ "\""+rspac.getString("Apellido1")+"\","
						+ "\""+rspac.getString("Apellido2")+"\","
						+ "\""+rspac.getInt("Celular")+"\","
						+ "\""+rspac.getString("Edad")+"\","
						+ "\""+fechaM.format(fecha)+"\","
						+ "\""+rspac.getInt("Sexo")+"\","
						+ "\""+rspac.getInt("Estadocivil")+"\","
						+ "\""+rspac.getString("Escolaridad")+"\","
						+ "\""+rspac.getString("Direccion")+"\","
						+ "\""+rspac.getString("Conquienvive")+"\","
						+ "\""+rspac.getString("Lugartrabajo")+"\","
						+ "\""+rspac.getString("Empleo")+"\","
						+ "\""+rspac.getString("Salario")+"\","
						+ "\""+rspac.getInt("Terapia")+"\","
						+ "\""+rspac.getString("Internado")+"\","
						+ "\""+rspac.getString("Internadoafirmativo")+"\","
						+ "\""+rspac.getInt("EscolaridadID")+"\", "
						+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				
				out += "<input id='validacionPaciente' name='validacionPaciente' type='hidden' value="+dtres.validarPaciente(rspac.getInt("PacienteID"))+"  checked>";
				
				out +="<button id='btnRespuesta' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='redirect(this.value);'><span><i class='fa fa-edit'></i></span>Ficha</button>";
				
				out += "<button id='btnRespuestaVista' onClick='redirectII(this.value);' class='btn btn-default btn-label-left' value="+rspac.getInt("PacienteID")+" <span> <i class='fa fa-eye'></i></span> Ver ficha</button>";
							
				out +="<button id='btnTransferir' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='transferir(this.value);'><span><i class='fa fa-edit'></i></span>Trasladar</button>";

                out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminarAlta(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de alta</button>";

				out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de baja</button>";
				out +="</td>";
				}else if (tiporol == 2){
					out +="<td>";
					Date fecha = formatter.parse(rspac.getString("Fechanac"));
					
					
					out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
							+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
							+ "\""+rspac.getString("Nombre2")+"\","
							+ "\""+rspac.getString("Apellido1")+"\","
							+ "\""+rspac.getString("Apellido2")+"\","
							+ "\""+rspac.getInt("Celular")+"\","
							+ "\""+rspac.getString("Edad")+"\","
							+ "\""+fechaM.format(fecha)+"\","
							+ "\""+rspac.getInt("Sexo")+"\","
							+ "\""+rspac.getInt("Estadocivil")+"\","
							+ "\""+rspac.getString("Escolaridad")+"\","
							+ "\""+rspac.getString("Direccion")+"\","
							+ "\""+rspac.getString("Conquienvive")+"\","
							+ "\""+rspac.getString("Lugartrabajo")+"\","
							+ "\""+rspac.getString("Empleo")+"\","
							+ "\""+rspac.getString("Salario")+"\","
							+ "\""+rspac.getInt("Terapia")+"\","
							+ "\""+rspac.getString("Internado")+"\","
							+ "\""+rspac.getString("Internadoafirmativo")+"\","
							+ "\""+rspac.getInt("EscolaridadID")+"\","
							+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";
					out += "<button id='btnIdActualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-primary btn-label-left btn-info' "
							+ "onclick = 'cargarDatos(this.value, \""+ rspac.getString("Nombre1") + "\", "
							+ "\""+rspac.getString("Nombre2")+"\","
							+ "\""+rspac.getString("Apellido1")+"\","
							+ "\""+rspac.getString("Apellido2")+"\","
							+ "\""+rspac.getInt("Celular")+"\","
							+ "\""+rspac.getString("Edad")+"\","
							+ "\""+fechaM.format(fecha)+"\","
							+ "\""+rspac.getInt("Sexo")+"\","
							+ "\""+rspac.getInt("Estadocivil")+"\","
							+ "\""+rspac.getString("Escolaridad")+"\","
							+ "\""+rspac.getString("Direccion")+"\","
							+ "\""+rspac.getString("Conquienvive")+"\","
							+ "\""+rspac.getString("Lugartrabajo")+"\","
							+ "\""+rspac.getString("Empleo")+"\","
							+ "\""+rspac.getString("Salario")+"\","
							+ "\""+rspac.getInt("Terapia")+"\","
							+ "\""+rspac.getString("Internado")+"\","
							+ "\""+rspac.getString("Internadoafirmativo")+"\","
							+ "\""+rspac.getInt("EscolaridadID")+"\", "
							+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
					
					out += "<input id='validacionPaciente' name='validacionPaciente' type='hidden' value="+dtres.validarPaciente(rspac.getInt("PacienteID"))+"  checked>";
					
					out +="<button id='btnRespuesta' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='redirect(this.value);'><span><i class='fa fa-edit'></i></span>Ficha</button>";
					
					out += "<button id='btnRespuestaVista' onClick='redirectII(this.value);' class='btn btn-default btn-label-left' value="+rspac.getInt("PacienteID")+" <span> <i class='fa fa-eye'></i></span> Ver ficha</button>";
								
					out +="<button id='btnTransferir' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='transferir(this.value);'><span><i class='fa fa-edit'></i></span>Trasladar</button>";

	                out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminarAlta(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de alta</button>";

					out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de baja</button>";
					out +="</td>";
				}else if (tiporol == 3){
					out +="<td>";
					Date fecha = formatter.parse(rspac.getString("Fechanac"));
					
					
					out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
							+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
							+ "\""+rspac.getString("Nombre2")+"\","
							+ "\""+rspac.getString("Apellido1")+"\","
							+ "\""+rspac.getString("Apellido2")+"\","
							+ "\""+rspac.getInt("Celular")+"\","
							+ "\""+rspac.getString("Edad")+"\","
							+ "\""+fechaM.format(fecha)+"\","
							+ "\""+rspac.getInt("Sexo")+"\","
							+ "\""+rspac.getInt("Estadocivil")+"\","
							+ "\""+rspac.getString("Escolaridad")+"\","
							+ "\""+rspac.getString("Direccion")+"\","
							+ "\""+rspac.getString("Conquienvive")+"\","
							+ "\""+rspac.getString("Lugartrabajo")+"\","
							+ "\""+rspac.getString("Empleo")+"\","
							+ "\""+rspac.getString("Salario")+"\","
							+ "\""+rspac.getInt("Terapia")+"\","
							+ "\""+rspac.getString("Internado")+"\","
							+ "\""+rspac.getString("Internadoafirmativo")+"\","
							+ "\""+rspac.getInt("EscolaridadID")+"\","
							+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";
					
					out += "<input id='validacionPaciente' name='validacionPaciente' type='hidden' value="+dtres.validarPaciente(rspac.getInt("PacienteID"))+"  checked>";
					
					
					out += "<button id='btnRespuestaVista' onClick='redirectII(this.value);' class='btn btn-default btn-label-left' value="+rspac.getInt("PacienteID")+" <span> <i class='fa fa-eye'></i></span> Ver ficha</button>";
								
					out +="<button id='btnTransferir' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='transferir(this.value);'><span><i class='fa fa-edit'></i></span>Trasladar</button>";

	                out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminarAlta(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de alta</button>";

					out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de baja</button>";
					out +="</td>";
				}else if (tiporol == 4){
					out +="<td>";
					Date fecha = formatter.parse(rspac.getString("Fechanac"));
					
					
					out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
							+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
							+ "\""+rspac.getString("Nombre2")+"\","
							+ "\""+rspac.getString("Apellido1")+"\","
							+ "\""+rspac.getString("Apellido2")+"\","
							+ "\""+rspac.getInt("Celular")+"\","
							+ "\""+rspac.getString("Edad")+"\","
							+ "\""+fechaM.format(fecha)+"\","
							+ "\""+rspac.getInt("Sexo")+"\","
							+ "\""+rspac.getInt("Estadocivil")+"\","
							+ "\""+rspac.getString("Escolaridad")+"\","
							+ "\""+rspac.getString("Direccion")+"\","
							+ "\""+rspac.getString("Conquienvive")+"\","
							+ "\""+rspac.getString("Lugartrabajo")+"\","
							+ "\""+rspac.getString("Empleo")+"\","
							+ "\""+rspac.getString("Salario")+"\","
							+ "\""+rspac.getInt("Terapia")+"\","
							+ "\""+rspac.getString("Internado")+"\","
							+ "\""+rspac.getString("Internadoafirmativo")+"\","
							+ "\""+rspac.getInt("EscolaridadID")+"\","
							+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";
					out += "<button id='btnIdActualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-primary btn-label-left btn-info' "
							+ "onclick = 'cargarDatos(this.value, \""+ rspac.getString("Nombre1") + "\", "
							+ "\""+rspac.getString("Nombre2")+"\","
							+ "\""+rspac.getString("Apellido1")+"\","
							+ "\""+rspac.getString("Apellido2")+"\","
							+ "\""+rspac.getInt("Celular")+"\","
							+ "\""+rspac.getString("Edad")+"\","
							+ "\""+fechaM.format(fecha)+"\","
							+ "\""+rspac.getInt("Sexo")+"\","
							+ "\""+rspac.getInt("Estadocivil")+"\","
							+ "\""+rspac.getString("Escolaridad")+"\","
							+ "\""+rspac.getString("Direccion")+"\","
							+ "\""+rspac.getString("Conquienvive")+"\","
							+ "\""+rspac.getString("Lugartrabajo")+"\","
							+ "\""+rspac.getString("Empleo")+"\","
							+ "\""+rspac.getString("Salario")+"\","
							+ "\""+rspac.getInt("Terapia")+"\","
							+ "\""+rspac.getString("Internado")+"\","
							+ "\""+rspac.getString("Internadoafirmativo")+"\","
							+ "\""+rspac.getInt("EscolaridadID")+"\", "
							+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
					
					out += "<input id='validacionPaciente' name='validacionPaciente' type='hidden' value="+dtres.validarPaciente(rspac.getInt("PacienteID"))+"  checked>";
					
					out +="<button id='btnRespuesta' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='redirect(this.value);'><span><i class='fa fa-edit'></i></span>Ficha</button>";
					
					out += "<button id='btnRespuestaVista' onClick='redirectII(this.value);' class='btn btn-default btn-label-left' value="+rspac.getInt("PacienteID")+" <span> <i class='fa fa-eye'></i></span> Ver ficha</button>";
								
					out +="<button id='btnTransferir' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='transferir(this.value);'><span><i class='fa fa-edit'></i></span>Trasladar</button>";

	                out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminarAlta(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de alta</button>";

					out +="<button id='btnIdEliminar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Dar de baja</button>";
					out +="</td>";
				}
				
				out += "</tr>";
			}
			
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);

		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}

	}

	protected void refrescarInactivos(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int tiporol = 0;
		int usuarioID =0;
		
		tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));
		
		
		try {
			
			ResultSet rspac=null;
		    DtConsulta dtcon = new DtConsulta();
			DtPaciente dtp = new DtPaciente();
		     
			
			if (tiporol == 1 || tiporol == 4) { //Carga TODOS los registros para Administrador y Directora
				rspac = dtp.cargarDatosInactivos();
			
			} else if (tiporol == 3) { //Carga únicamente los registros relacionados un psicólogo
				rspac = dtp.cargarDatosInactivosAPsicologos(dtcon.obtenerPsicologoID(usuarioID));
			}	
			

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rspac.next()) {
				out += "<tr>";
				out += "<td>" + rspac.getString("Expediente") +"</td>";
				out += "<td>" + rspac.getString("Nombre1") + " " + rspac.getString("Nombre2") + " " + rspac.getString("Apellido1") + " " + rspac.getString("Apellido2")+ "</td>";
				out += "<td>" + rspac.getString("Edad") +"</td>";
				out +="<td>";
				Date fecha = formatter.parse(rspac.getString("Fechanac"));


				out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
						+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
						+ "\""+rspac.getString("Nombre2")+"\","
						+ "\""+rspac.getString("Apellido1")+"\","
						+ "\""+rspac.getString("Apellido2")+"\","
						+ "\""+rspac.getInt("Celular")+"\","
						+ "\""+rspac.getString("Edad")+"\","
						+ "\""+fechaM.format(fecha)+"\","
						+ "\""+rspac.getInt("Sexo")+"\","
						+ "\""+rspac.getInt("Estadocivil")+"\","
						+ "\""+rspac.getString("Escolaridad")+"\","
						+ "\""+rspac.getString("Direccion")+"\","
						+ "\""+rspac.getString("Conquienvive")+"\","
						+ "\""+rspac.getString("Lugartrabajo")+"\","
						+ "\""+rspac.getString("Empleo")+"\","
						+ "\""+rspac.getString("Salario")+"\","
						+ "\""+rspac.getInt("Terapia")+"\","
						+ "\""+rspac.getString("Internado")+"\","
						+ "\""+rspac.getString("Internadoafirmativo")+"\","
						+ "\""+rspac.getInt("EscolaridadID")+"\","
						+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";

				out +="<button id='btnIdReActivar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='reactivar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Reactivar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);

		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}

	}

	protected void refrescarDadosAlta(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		int tiporol = 0;
		int usuarioID =0;
		
		tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));
		System.out.println("YA entro a refrescar los dato de Alta tipo rol"+tiporol+"  usuario ID "+usuarioID);
		try {

			ResultSet rspac=null;
		    DtConsulta dtcon = new DtConsulta();
			DtPaciente dtp = new DtPaciente();
		     
			
			if (tiporol == 1 || tiporol == 4 || tiporol == 2) { //Carga TODOS los registros para Administrador y Directora
				rspac = dtp.cargarDatosAlta();
			
			} else if (tiporol == 3) { //Carga únicamente los registros relacionados un psicólogo
				rspac = dtp.cargarDatosAltaAPsicologos(dtcon.obtenerPsicologoID(usuarioID));
			}	
			
			

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rspac.next()) {
				out += "<tr>";
				out += "<td>" + rspac.getString("Expediente") +"</td>";
				out += "<td>" + rspac.getString("Nombre1") + " " + rspac.getString("Nombre2") + " " + rspac.getString("Apellido1") + " " + rspac.getString("Apellido2")+ "</td>";
				out += "<td>" + rspac.getString("Edad") +"</td>";
				out +="<td>";
				Date fecha = formatter.parse(rspac.getString("Fechanac"));


				out += "<button id='btnIdVisualizar' value="+rspac.getInt("PacienteID")+" class='btn btn-default btn-label-left' "
						+ "onclick = 'cargarDatosVisualizar(this.value, \""+ rspac.getString("Nombre1") + "\", "
						+ "\""+rspac.getString("Nombre2")+"\","
						+ "\""+rspac.getString("Apellido1")+"\","
						+ "\""+rspac.getString("Apellido2")+"\","
						+ "\""+rspac.getInt("Celular")+"\","
						+ "\""+rspac.getString("Edad")+"\","
						+ "\""+fechaM.format(fecha)+"\","
						+ "\""+rspac.getInt("Sexo")+"\","
						+ "\""+rspac.getInt("Estadocivil")+"\","
						+ "\""+rspac.getString("Escolaridad")+"\","
						+ "\""+rspac.getString("Direccion")+"\","
						+ "\""+rspac.getString("Conquienvive")+"\","
						+ "\""+rspac.getString("Lugartrabajo")+"\","
						+ "\""+rspac.getString("Empleo")+"\","
						+ "\""+rspac.getString("Salario")+"\","
						+ "\""+rspac.getInt("Terapia")+"\","
						+ "\""+rspac.getString("Internado")+"\","
						+ "\""+rspac.getString("Internadoafirmativo")+"\","
						+ "\""+rspac.getInt("EscolaridadID")+"\""
						+ "\""+rspac.getInt("Uca")+"\")'><span><i class='fa fa-eye'></i></span>Ver paciente</button>";

				out +="<button id='btnIdReActivar' value="+rspac.getInt("PacienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='reactivarDadosAlta(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Reactivar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Codigo</th>";
			out += "<th>Nombre</th>";
			out += "<th>Edad</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);

		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}

	}

}
