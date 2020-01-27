package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import datos.DTVParientePaciente;

import entidades.VParientePaciente;

@WebServlet("/SLParientePaciente")
public class SLParientePaciente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SLParientePaciente() {
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
		int pacienteID = 0;
		int parienteID = 0;
	

		DTVParientePaciente dtvpp = new DTVParientePaciente();
		VParientePaciente vpp =  new VParientePaciente();

		switch (opcion) {

		case "guardar":
			try {
				
				pacienteID = Integer.parseInt(request.getParameter("fParienteID"));
				parienteID = Integer.parseInt(request.getParameter("fPacienteID"));
				
				vpp.setPacienteID(pacienteID);
				vpp.setParienteID(parienteID);
				//psil.setUsuarioCreacion(1);
	
				System.out.println("Antes de ejcutar el metodo guardar");

				if (dtvpp.guardarParientePaciente(vpp)) {
					System.out.println("Guardado exitosamente");
					 //response.sendRedirect("#ajax/Pariente-Paciente.jsp?guardado");
					// RequestDispatcher requestDispatcher =
					// request.getRequestDispatcher("/ajax/psicologo.jsp");
					// requestDispatcher.forward(request, response);

				}
			} catch (Exception e) {
				System.out.println("SL: error en en el servlet" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/// ACTUALIZAR
		case "actualizar": {
			try {
				int fParientePacienteID = Integer.parseInt(request.getParameter("fParientePacienteID"));
				pacienteID = Integer.parseInt(request.getParameter("fParienteIDEditar"));
				parienteID = Integer.parseInt(request.getParameter("fPacienteIDEditar"));
				
                vpp.setPaciente_parienteID(fParientePacienteID);
                vpp.setPacienteID(pacienteID);
				vpp.setParienteID(parienteID);
		
		
				
				if (dtvpp.actualizarParientePaciente(vpp)) {
					System.out.println("Actualizado exitosamente");
				}

			} catch (Exception e) {
				System.out.println("SL: error en el servlet" + e.getMessage());
				e.printStackTrace();
			}
			break;
		}

		/// EN CASO DE ELIMINAR
//		case "eliminar": {
//			try {
//				int fIdPsicologo = Integer.parseInt(request.getParameter("fPsicologoID"));
//				System.out.println(fIdPsicologo);
//
//				if (dtps.eliminarPsicologo(fIdPsicologo)) {
//					System.out.println("Eliminado exitosamente");
//				}
//
//			} catch (Exception e) {
//				System.out.println("SL:  error en el srevlet: " + e.getMessage());
//				e.printStackTrace();
//
//			}
//			break;
//		}
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

			DTVParientePaciente dtvpp = new DTVParientePaciente();
			ResultSet rs = dtvpp.cargarVista();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Nombre Pariente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1") +" "+ rs.getString("Nombre2") +" "+ rs.getString("Apellido1") +" "+ rs.getString("Apellido2")+"</td>";
				out += "<td>" + rs.getString("Nombre1par") + " "+rs.getString("Nombre2par")+" "+rs.getString("Apellido1par")+" "+rs.getString("Apellido2par")+"</td>";
 				out +="<td>";                                                                                                
				out += "<button id='btnIdActualizar' value="+rs.getInt("ParPacID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \""+rs.getInt("PacienteID")+"\", \""+rs.getInt("ParienteID")+"\");'><span><i class='fa fa-clock-o'></i></span>Actualizar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Nombre Pariente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			 System.out.println("Error en el servlet : "+error);

		} catch (Exception e) {
			System.out.println("SL error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
	}

}
