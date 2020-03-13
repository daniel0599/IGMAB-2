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
				
				pacienteID = Integer.parseInt(request.getParameter("fPacienteID"));
				parienteID = Integer.parseInt(request.getParameter("fParienteID"));
				
				int usuarioID =0;
        		
        		//tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
        		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));
				
				vpp.setPacienteID(pacienteID);
				vpp.setParienteID(parienteID);
				vpp.setUsuariocreacion(usuarioID);
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
		case "actualizar": 
			try {
				int fParientePacienteID = Integer.parseInt(request.getParameter("fParientePacienteID"));
				parienteID = Integer.parseInt(request.getParameter("fparienteEditar"));
				pacienteID = Integer.parseInt(request.getParameter("fpacienteEditar"));
				
                vpp.setPaciente_parienteID(fParientePacienteID);
            	vpp.setParienteID(parienteID);
        		vpp.setPacienteID(pacienteID);
			
		
				
				if (dtvpp.actualizarParientePaciente(vpp)) {
					System.out.println("Actualizado exitosamente");
					//refrescar(request, response);
				}

			} catch (Exception e) {
				System.out.println("SL: error en el servlet" + e.getMessage());
				e.printStackTrace();
			}
			break;
		
		case "refrescar": {
			refrescar(request, response);
			break;
		}
		 case "refrescarApsicologo":{
         	//  int tiporol = 0;
     		int usuarioID =0;
     		
     		//tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
     		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));
     		
         	refrescarApsicologo(request, response, usuarioID);
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
			out += "<th>Nombre Pariente</th>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1par") +" "+rs.getString("Apellido1par")+" "+rs.getString("Apellido2par")+"</td>";
				out += "<td>" + rs.getString("Nombre1") +" "+ rs.getString("Apellido1") +" "+ rs.getString("Apellido2")+"</td>";
 				out +="<td>";                                                                                                
				out += "<button id='btnIdActualizar' value="+rs.getInt("ParPacID")+ " class='btn btn-info' "
				+ "onclick = 'cargarDatos(\""+ rs.getInt("ParPacID") +"\", \""+ rs.getInt("PacienteID")+"\", \""+rs.getInt("ParienteID")+"\");'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Nombre Pariente</th>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			//JOptionPane.showMessageDialog(null, "ya paso por el servlet al refrescar");
			pw.flush();
			boolean error = pw.checkError();
			 System.out.println("Error en el servlet : "+error);

		} catch (Exception e) {
			System.out.println("SL error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	protected void refrescarApsicologo(HttpServletRequest request, HttpServletResponse response, int usuarioID)
			throws ServletException, IOException {
		int UsuarioID = usuarioID; 
		try {

			
			DTVParientePaciente dtvpp = new DTVParientePaciente();
			ResultSet rs = dtvpp.cargarVistaApsicologo(UsuarioID);

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Nombre Pariente</th>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1par") +" "+rs.getString("Apellido1par")+" "+rs.getString("Apellido2par")+"</td>";
				out += "<td>" + rs.getString("Nombre1pac") +" "+ rs.getString("Apellido1pac") +" "+ rs.getString("Apellido2pac")+"</td>";
 				out +="<td>";                                                                                                
				out += "<button id='btnIdActualizar' value="+rs.getInt("ParPacID")+ " class='btn btn-info' "
				+ "onclick = 'cargarDatos(\""+ rs.getInt("ParPacID") +"\", \""+ rs.getInt("PacienteIDpac")+"\", \""+rs.getInt("ParienteIDpar")+"\");'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Nombre Pariente</th>";
			out += "<th>Nombre Paciente</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			//JOptionPane.showMessageDialog(null, "ya paso por el servlet al refrescar");
			pw.flush();
			boolean error = pw.checkError();
			 System.out.println("Error en el servlet : "+error);

		} catch (Exception e) {
			System.out.println("SL error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
		
		
	}

}