package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import datos.DtRol;
import entidades.Rol;

/**
 * Servlet implementation class SlRol
 */
@WebServlet("/SlRol")
public class SlRol extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlRol() {
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
		String nombre = "";
		// int fIdParentesco = 0;
		DtRol dtr = new DtRol();
		Rol rol = new Rol();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {
				nombre = request.getParameter("fRol");
				rol.setNombre(nombre);
				
				if(dtr.validarRolRepetido(rol.getNombre())) {
					if (dtr.guardarRol(rol)) {
						System.out.println("Guardado exitosamente");
					}					
				}
				else {
					System.out.println("Pasa por el else validar rol");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
				}

			} catch (Exception e) {
				System.out.println("SL: error al guardar en el servlet rol:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// ACTUALIZAR////////////////////////////////
		case "actualizar":
			try {
				int fRolId = Integer.parseInt(request.getParameter("fRolId"));
				nombre = request.getParameter("fNombreEditar");

				rol.setRolId(fRolId);
				rol.setNombre(nombre);
				
				if(dtr.validarRolRepetido(rol.getNombre())) {
					if (dtr.actualizarRol(rol)) {
						System.out.println("Actualizado exitosamente");
					}					
				}
				else 
				{
					System.out.println("Pasa por el else validar rol");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
				}
			} catch (Exception e) {
				System.out.println("SL: error al actualizar en el servlet rol:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// ELIMINAR////////////////////////////////
		case "eliminar":
			try {
				int fIdRol = Integer.parseInt(request.getParameter("fIdRol"));
				System.out.println(fIdRol);

				if (dtr.eliminarRol(fIdRol)) {
					System.out.println("Eliminado exitosamente");
				}
			} catch (Exception e) {
				System.out.println("SL: error al eliminar en el servlet rol:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		/////////////////////////// EN CASO DE
		/////////////////////////// REFRESCAR LA
		/////////////////////////// TABLA////////////////////////////////
		case "refrescar":
			refrescar(request, response);
			break;

		default:
			System.out.println("Nothing to show");
			break;
		}

	}
	
	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			DtRol dtr = new DtRol();
			ResultSet rs = dtr.cargarDatos();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Rol</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre") + "</td>";
				out +="<td>";
				out +="<button id='btnIdEliminar' value="+rs.getInt("RolID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value="+rs.getInt("RolID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getString("Nombre") + "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";	
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Rol</th>";
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
