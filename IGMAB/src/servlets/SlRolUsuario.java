package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import datos.DtRol;
import datos.DtRolUsuario;
//import entidades.Rol;
import entidades.RolUsuario;

/**
 * Servlet implementation class SlRolUsuario
 */
@WebServlet("/SlRolUsuario")
public class SlRolUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlRolUsuario() {
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
		// TODO Auto-generated method stub

		///////////////////////////// SE DECLARAN LAS VARIABLES QUE ALMACENAN
		///////////////////////////// LOS DATOS DE LA INTERFAZ DE
		///////////////////////////// USUARIO////////////////////////////////
		String opcion = request.getParameter("opcion").trim();

		DtRolUsuario dtur = new  DtRolUsuario();
		RolUsuario tur = new RolUsuario();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {

				String idrol, idusuario = "";

				idrol = request.getParameter("fIdRol");
				idusuario = request.getParameter("fIdUsuario");

				tur.setRolID(Integer.parseInt(idrol));
				tur.setUsuarioID(Integer.parseInt(idusuario));
				System.out.println("fidRol " + idrol);
				System.out.println("fidUsuario " + idusuario);

				if (dtur.guardarUsuarioRol(tur)) {

				} else {
					System.err.println("ERROR");
				}
			} catch (Exception e) {
				System.out.println("SL: error en el servlet RolUsuario:" + e.getMessage());
				e.printStackTrace();
			}
			break;

		case "eliminar":
			try {
				int fIdRolUsuario = Integer.parseInt(request.getParameter("fIdRolUsuario"));
				System.out.println(fIdRolUsuario);

				if (dtur.eliminarUsuarioRol(fIdRolUsuario)) {
					System.out.println("Eliminado exitosamente");
				}
			} catch (Exception e) {
				System.out.println("SL: error en el servlet RolUsuario:" + e.getMessage());
				e.printStackTrace();
			}
			break;
		
		case "refrescar":
			refrescar(request, response);
			break;
		}

	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			DtRolUsuario dtur = new DtRolUsuario();
			ResultSet rs = dtur.cargarVista();
			
			ResultSet rt=dtur.cargarDatos();
			rt.beforeFirst();
			
			rs.beforeFirst();		
			
			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Usuario</th>";
			out += "<th>Rol</th>";
			out += "<th>Acción</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next() && rt.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Usuario") + "</td>";
				out += "<td>" + rs.getString("Nombre") + "</td>";
				out += "<td>";
				out +="<button id='btnIdEliminar' value="+rt.getInt("Rol_Usuario")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Usuario</th>";
			out += "<th>Rol</th>";
			out += "<th>Acción</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error? " + error);
	
		}catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
	}

}
