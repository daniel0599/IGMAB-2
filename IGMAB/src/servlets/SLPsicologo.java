package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DTPsicologo;
import entidades.Psicologo;

/**
 * Servlet implementation class SLPsicologo
 */
@WebServlet("/SLPsicologo")
public class SLPsicologo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SLPsicologo() {
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

		String opcion = request.getParameter("opcion").trim();
		String nombre1 = "";
		String nombre2 = "";
		String apellido1 = "";
		String apellido2 = "";
		String carnet = "";
		String tutor = "";
		Date fechaCreacion = new Date();
		Date fechaModificacion = new Date();

		DTPsicologo dtps = new DTPsicologo();
		Psicologo psi = new Psicologo();

		switch (opcion) {

		case "guardar":
			try {
				
				nombre1 = request.getParameter("fNombre1");
				nombre2 = request.getParameter("fNombre2");
				apellido1 = request.getParameter("fApellido1");
				apellido2 = request.getParameter("fApellido2");
				carnet = request.getParameter("fCarnet");
				tutor = request.getParameter("fTutor");
				int UsuarioId = Integer.parseInt(request.getParameter("fUsuarioId"));
				fechaCreacion.getTime();

				psi.setNombre1(nombre1);
				psi.setNombre2(nombre2);
				psi.setApellido1(apellido1);
				psi.setApellido2(apellido2);
				psi.setCarnet(carnet);
				psi.setTutor(tutor);
				psi.setUsuarioID(UsuarioId);
				psi.setFechaCreacion(fechaCreacion);
				psi.setUsuarioCreacion(1);
				System.out.println("LOS DATOS: " + psi.getNombre1() + " " + psi.getNombre2() + " "
						+ psi.getApellido1() + " " + psi.getApellido2() + ".." + "LA FECHA" + psi.getFechaCreacion()
						+ "...CARNET: " + psi.getCarnet()+"TUTOR: "+psi.getTutor());
				System.out.println("Antes de ejcutar el metodo guardar");
				
				if(dtps.validarCarnetRepetido(psi.getCarnet())) {
					if (dtps.guardarPsicologo(psi)) {
						System.out.println("Guardado exitosamente");
					}					
				}
				else
				{
					System.out.println("Pasa por el else validar carnet de psicólogo");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
				}
			} catch (Exception e) {
				System.out.println("SL: error en en el servlet" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/// ACTUALIZAR
		case "actualizar": {
			try {
				int fPsicologoID = Integer.parseInt(request.getParameter("fPsicologoID"));
				nombre1 = request.getParameter("fNombre1Editar");
				nombre2 = request.getParameter("fNombre2Editar");
				apellido1 = request.getParameter("fApellido1Editar");
				apellido2 = request.getParameter("fApellido2Editar");
				carnet = request.getParameter("fCarnetEditar");
				tutor = request.getParameter("fTutorEditar");
				int usuarioId = Integer.parseInt(request.getParameter("fUsuarioIdEditar"));

				psi.setPsicologoID(fPsicologoID);
				psi.setNombre1(nombre1);
				psi.setNombre2(nombre2);
				psi.setApellido1(apellido1);
				psi.setApellido2(apellido2);
				psi.setCarnet(carnet);
				psi.setTutor(tutor);
				psi.setUsuarioID(usuarioId);
				psi.setFechaModificacion(fechaModificacion);
				psi.setUsuarioModificacion(1);
				
				if(dtps.validarCarnetRepetido(psi.getCarnet())) {
					if (dtps.actualizarPsicologo(psi)) {
						System.out.println("Actualizado exitosamente");
					}					
				}
				else 
				{
					System.out.println("Pasa por el else validar carnet de psicólogo");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
				}

			} catch (Exception e) {
				System.out.println("SL: error en el servlet" + e.getMessage());
				e.printStackTrace();
			}
			break;
		}

		/// EN CASO DE ELIMINAR
		case "eliminar": {
			try {
				int fIdPsicologo = Integer.parseInt(request.getParameter("fPsicologoID"));
				System.out.println(fIdPsicologo);

				if (dtps.eliminarPsicologo(fIdPsicologo)) {
					System.out.println("Eliminado exitosamente");
				}

			} catch (Exception e) {
				System.out.println("SL:  error en el srevlet: " + e.getMessage());
				e.printStackTrace();

			}
			break;
		}
		///////////////////////////////////// En caso de rrescar

		case "refrescar": {
			refrescar(request, response);
			break;
		}

		default: {
			System.out.println("NOthing to show. BABY");
			break;
		}

		}

	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			DTPsicologo dtps = new DTPsicologo();
			ResultSet rs = dtps.cargarDatos();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Carnet</th>";
			out += "<th>Nombre completo</th>";
			out += "<th>Tutor</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Carnet") + "</td>";
				out += "<td>" + rs.getString("Nombre1") + " "+rs.getString("Nombre2")+" "+rs.getString("Apellido1")+" "+rs.getString("Apellido2")+"</td>";
				out += "<td> "+ rs.getString("Tutor") + "</td>";
 				out +="<td>";
				out +="<button id='btnIdEliminar' value="+rs.getInt("PsicologoID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value="+rs.getInt("PsicologoID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \""+rs.getString("Carnet")+"\", \""+rs.getString("Nombre1")+"\", \""+rs.getString("Nombre2")+"\", \""+rs.getString("Apellido1")+"\", \""+rs.getString("Apellido2")+"\", \""+rs.getString("Tutor")+"\"," +"\""+rs.getInt("UsuarioID")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Carnet</th>";
			out += "<th>Nombre completo</th>";
			out += "<th>Tutor</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			 System.out.println("Error en el servlet de psicologo: "+error);

		} catch (Exception e) {
			System.out.println("SL error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
	}

}
