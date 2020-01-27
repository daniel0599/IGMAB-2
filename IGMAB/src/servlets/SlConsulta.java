package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DTPsicologo;
import datos.DtConsulta;
import datos.DtVconsulta;
import entidades.Consulta;
import entidades.Rol;
import entidades.Usuario;


/**
 * Servlet implementation class SlConsulta
 */
@WebServlet("/SlConsulta")

public class SlConsulta extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DtConsulta dta = new DtConsulta();
//	DtCita dc = DtCita.getInstance();
	DTPsicologo dtpsi = new DTPsicologo();
    
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	public SlConsulta(){
		super();
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String opcion = request.getParameter("opcion").trim();
		
		int psicologoId;
		int pacienteId;
	//	int citaId;
		String fechaStr = "";
		String objetivo = "";
		String actividad = "";
		String descripcion = "";
		
		DtConsulta dtc = new DtConsulta();
		Consulta c = new Consulta();
		 
		switch(opcion){
		
		// En caso de guardar
		case "guardar":
			try {
				
				psicologoId = Integer.parseInt(request.getParameter("fpsicologoId"));
				pacienteId = Integer.parseInt(request.getParameter("fpacienteId"));
				//citaId = Integer.parseInt(request.getParameter("fcitaId"));
				objetivo = request.getParameter("fobjetivo");
				actividad = request.getParameter("factividad");
				descripcion = request.getParameter("fdescripcion");
				fechaStr = request.getParameter("ffecha");
				System.out.println("1: " + fechaStr);
				
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date fecha = sdf.parse(fechaStr);
				System.out.println("2: " + fechaStr);
				
				
				c.setpsicologoId(psicologoId);
				c.setpacienteId(pacienteId);
				//c.setcitaId(citaId);
				c.setObjetivo(objetivo);
				c.setActividad(actividad);
				c.setDescripcion(descripcion);
				c.setFecha(fecha);
				
				if (dtc.guardarConsulta(c)){
					System.out.println("Guardado exitosamente en el servlet");
				}
				
			}
			catch (Exception e){
				System.err.println("SL error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			// En caso de actualizar
		case "actualizar":
			try {
				
				int consultaId = Integer.parseInt(request.getParameter("fConsultaId"));
				//psicologoId = Integer.parseInt(request.getParameter("fpsicologoIdEditar"));
				pacienteId = Integer.parseInt(request.getParameter("fpacienteIdEditar"));
				//citaId = Integer.parseInt(request.getParameter("fcitaIdEditar"));
				objetivo = request.getParameter("fobjetivoEditar");
				actividad = request.getParameter("factividadEditar");
				descripcion = request.getParameter("fdescripcionEditar");
				
				fechaStr = request.getParameter("ffechaEditar");
				DateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

				Date fecha = sdf.parse(fechaStr);
				
				
				
				c.setConsultaId(consultaId);
				//c.setpsicologoId(psicologoId);
				c.setpacienteId(pacienteId);
				//c.setcitaId(citaId);
				c.setObjetivo(objetivo);
				c.setActividad(actividad);
				c.setDescripcion(descripcion);
				c.setFecha(fecha);
				
				if(dtc.actualizarConsulta(c)){
					System.out.println("Actualizado exitosamente");
				}
				
			}
			catch (Exception e){
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			// En caso de eliminar
		case "eliminar":
			try {
				int fconsultaId = Integer.parseInt(request.getParameter("fconsultaId"));
				System.out.println(fconsultaId);
				
				if(dtc.eliminarConsulta(fconsultaId)){
					System.out.println("Eliminado exitosamente");
				}
			}
			catch(Exception e) 
			{
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			// En caso de refrescar la tabla 
		case "refrescar":
			refrescar(request, response);
			break;
		
		}
		
	}
	
	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			Usuario us = new Usuario();
			us = (Usuario)request.getSession().getAttribute("usuarioVerificado");
			Rol r = new Rol();
			r = (Rol)request.getSession().getAttribute("Rol");
			
			DtVconsulta dtvc = new DtVconsulta();
			DtConsulta dtcon = new DtConsulta();
			ResultSet rs = null;
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat fechaM = new SimpleDateFormat("dd-MM-yyyy");
			
			if(r.getRolId()==1 || r.getRolId()==4){ //Carga TODOS los registros para Administrador y Directora
				rs = dtvc.cargarVista();
			}
			else if(r.getRolId()==3){ //Carga únicamente los registros relacionados un psicólogo
				rs = dtvc.cargarVistaSoloPsicologo(dtcon.obtenerPsicologoID(us.getUsuarioID()));
			}
			
			
			response.setContentType("text/html; charset=UTF-8"); 
			String out = "";
			
			out+="<thead>";
			out+="<tr>";
			out+="<th>Paciente</th>";
			out+="<th>Psicólogo</th>";
			out+="<th>Fecha</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
			out+="</thead>";
			
			out += "<tbody>";
			while(rs.next()){
				out += "<tr>";
				out +="<td>" +rs.getString("Nombre1pa") +" "+rs.getString("Nombre2pa")+" "+rs.getString("Apellido1pa")+" "+rs.getString("Apellido2pa")+"</td>";
				out +="<td>" +rs.getString("Nombre1psi") +" "+rs.getString("Nombre2psi")+" "+rs.getString("Apellido1psi")+" "+rs.getString("Apellido2psi")+"</td>";
				
				Date fecha = formatter.parse(rs.getString("Fecha"));
				
				//out +="<td>" +rs.getInt("CitaId") +"</td>";
				out +="<td>" +rs.getDate("Fecha") +"</td>";
				//out += "<button id='btnIdEliminar' value=" + rs.getInt("ConsultaId")+"class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-clock-o txt-danger'></i></span>Eliminar</button>";
				out += "<td>";
				
				out += "<button id='btnIdVisualizar' value=" + rs.getInt("ConsultaID") + " class='ajax-link action btn btn-default btn-label-left' "
				+ "onclick = 'visualizarDatos(this.value, \""+ rs.getInt("psicologoId") + "\", "
						+ "\""+rs.getInt("pacienteId")+"\","
						    + "\""+rs.getInt("psicologoId")+"\","
//						    + "\""+rs.getInt("CitaId")+"\","
							+ "\""+rs.getString("Objetivo")+"\","
							+ "\""+rs.getString("Actividad")+"\","
						    + "\""+rs.getString("Descripcion")+"\","
						    + "\""+fechaM.format(fecha)+"\")'><span><i class='fa fa-eye'></i></span>Ver Consulta</button>";
				
				out += "<button id='btnIdActualizar' value=" + rs.getInt("ConsultaID") + " class='btn btn-primary btn-label-left' "+ "onclick = 'cargarDatos(this.value, \""+ rs.getInt("psicologoId") + "\", "
					+ "\""+rs.getInt("pacienteId")+"\","
//					    + "\""+rs.getInt("psicologoId")+"\","
//					    + "\""+rs.getInt("CitaId")+"\","
						+ "\""+rs.getString("Objetivo")+"\","
						+ "\""+rs.getString("Actividad")+"\","
					    + "\""+rs.getString("Descripcion")+"\","
					    + "\""+fechaM.format(fecha)+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				
				out += "</td>";
				out += "</tr>";
			}
			out += "</tbody>";
			
			out += "<tfoot>";
			out+="<tr>";
			out+="<th>Paciente</th>";
			out+="<th>Psicólogo</th>";
			out+="<th>Fecha</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
			out += "</tfoot>";
			
			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);
		}
		catch (Exception e) {
			System.out.println("SL: error en el servlet de Consulta: " + e.getMessage());
			e.printStackTrace();
		}
	}

}