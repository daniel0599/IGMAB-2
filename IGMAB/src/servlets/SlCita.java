package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtCita;
import datos.DtVCitaPaciente;
import entidades.Cita;

/**
 * Servlet implementation class SL_GuardarCita
 */
@WebServlet("/SlCita")
public class SlCita extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlCita() {
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

		String fechaStr = "";
		String horaStr = "";
		int pacienteId = 0, sesion = 0;

		DtCita dtc = new DtCita();
		Cita cita = new Cita();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {

				pacienteId = Integer.parseInt(request.getParameter("fpacienteId"));

				sesion = Integer.parseInt(request.getParameter("fnumSesion"));

				fechaStr = request.getParameter("ffecha");
				System.out.println("1: " + fechaStr);

				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				Date fecha = sdf.parse(fechaStr);
				System.out.println("2: " + fechaStr);

				horaStr = request.getParameter("fhora");
				DateFormat shf = new SimpleDateFormat("HH:mm");

				Date hora = shf.parse(horaStr);

				Time tiempo = new Time(hora.getTime());

				cita.setFecha(fecha);
				cita.setHora(tiempo);
				cita.setPacienteId(pacienteId);
				cita.setNumSesion(sesion);

				if (dtc.guardarCita(cita)) {
					System.out.println("Guardado exitosamente");
				}

			} catch (Exception e) {
				System.out.println("SL error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}

			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// ACTUALIZAR////////////////////////////////
		case "actualizar":
			try {
				int fCitaId = Integer.parseInt(request.getParameter("fCitaId"));
				pacienteId = Integer.parseInt(request.getParameter("fpacienteIdEditar"));

				sesion = Integer.parseInt(request.getParameter("fnumSesionEditar"));

				fechaStr = request.getParameter("ffechaEditar");
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date fecha = sdf.parse(fechaStr);

				horaStr = request.getParameter("fhoraEditar");
				DateFormat shf = new SimpleDateFormat("HH:mm");
				Date hora = shf.parse(horaStr);

				Time tiempo = new Time(hora.getTime());

				cita.setCitaId(fCitaId);
				cita.setFecha(fecha);
				cita.setHora(tiempo);
				cita.setPacienteId(pacienteId);
				cita.setNumSesion(sesion);

				if (dtc.actualizarCita(cita)) {
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
				int fCitaId = Integer.parseInt(request.getParameter("fCitaId"));
				System.out.println(fCitaId);

				if (dtc.eliminarCita(fCitaId)) {
					System.out.println("Cita eliminada exitosamente");
				}
			} catch (Exception e) {
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

		case "refrescarConTodas":
				refrescarConTodas(request, response);
				break;
		}

	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			DtVCitaPaciente dtc = new DtVCitaPaciente();
			ResultSet rs = dtc.cargarVistaHoy();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Paciente</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora</th>";
			out += "<th>Sesión</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " "
						+ rs.getString("Apellido1") + " " + rs.getString("Apellido2") + "</td>";
				out += "<td>" + rs.getDate("Fecha") + "</td>";
				out += "<td>" + rs.getTime("Hora") + "</td>";
				out += "<td>" + rs.getInt("Numsesion") + "</td>";
				out += "<td>";
				// out += "<button id='btnIdEliminar' value=" +
				// rs.getInt("CitaID")+"class='ajax-link action btn btn-default
				// btn-label-left' onClick='eliminar(this.value);'><span><i
				// class='fa fa-clock-o
				// txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value=" + rs.getInt("CitaID")
						+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \""
						+ rs.getInt("PacienteID") + "\", \"" + rs.getDate("Fecha") + "\", \"" + rs.getTime("Hora")
						+ "\", \"" + rs.getInt("Numsesion")
						+ "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				out += "</td>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Paciente</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora</th>";
			out += "<th>Sesión</th>";
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

	protected void refrescarConTodas(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			DtVCitaPaciente dtc = new DtVCitaPaciente();
			ResultSet rs = dtc.cargarVista();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Paciente</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora</th>";
			out += "<th>Sesión</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " "
						+ rs.getString("Apellido1") + " " + rs.getString("Apellido2") + "</td>";
				out += "<td>" + rs.getDate("Fecha") + "</td>";
				out += "<td>" + rs.getTime("Hora") + "</td>";
				out += "<td>" + rs.getInt("Numsesion") + "</td>";
				out += "<td>";
				// out += "<button id='btnIdEliminar' value=" +
				// rs.getInt("CitaID")+"class='ajax-link action btn btn-default
				// btn-label-left' onClick='eliminar(this.value);'><span><i
				// class='fa fa-clock-o
				// txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value=" + rs.getInt("CitaID")
						+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \""
						+ rs.getInt("PacienteID") + "\", \"" + rs.getDate("Fecha") + "\", \"" + rs.getTime("Hora")
						+ "\", \"" + rs.getInt("Numsesion")
						+ "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				out += "</td>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Paciente</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora</th>";
			out += "<th>Sesión</th>";
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
