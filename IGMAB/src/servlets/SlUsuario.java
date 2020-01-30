package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtUsuario;
//import datos.DtCita;
//import entidades.Cita;
import entidades.Usuario;

/**
 * Servlet implementation class SlUsuario
 */
@WebServlet("/SlUsuario")
public class SlUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlUsuario() {
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

		String fusuario = "";
		String fpassword = "";
		DtUsuario dtu = new DtUsuario();
		Usuario user = new Usuario();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":			
			try {

				//usuarioCreacion = Integer.parseInt(request.getParameter("fusuarioCreacion"));
				
				
				fusuario = request.getParameter("fusuario");

				fpassword = request.getParameter("fpassword");
				
				user.setUsuario(fusuario);
				user.setContrasena(fpassword);
				user.setUsuarioCreacion(1);
				
				if(dtu.validarUsuarioRepetido(user.getUsuario())) {
					if (dtu.guardarUsuario(user)) {
						System.out.println("Guardado exitosamente");
					}					
				}
				else
				{
					System.out.println("Pasa por el else validar usuario");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
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
				int fUsuarioId = Integer.parseInt(request.getParameter("fUsuarioId"));
				fpassword = request.getParameter("fpasswordEditar");
				
				user.setUsuarioID(fUsuarioId);
				user.setContrasena(fpassword);

				if (dtu.actualizarUsuario(user)) {
					System.out.println("Actualizado exitosamente");
				}

			} catch (Exception e) {
				System.out.println("SL error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}

			break;


		/////////////////////////// EN CASO DE
		/////////////////////////// ELIMINAR////////////////////////////////
		case "eliminar":
			try {
				int fUsuarioId = Integer.parseInt(request.getParameter("fUsuarioId"));
				System.out.println(fUsuarioId);
				
				if(dtu.eliminarUsuario(fUsuarioId)){
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

		default:
			System.out.println("Nothing to show");
			break;
		}

	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			DtUsuario dtu =new DtUsuario();
			ResultSet rs = dtu.cargarDatos();
			
			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Usuario</th>";
			out += "<th>FechaCreacion</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Usuario") + "</td>";
				out += "<td>" + rs.getString("Fechacreacion") + "</td>";
				out +="<td>";
				out +="<button id='btnIdEliminar' value="+rs.getInt("UsuarioID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value="+rs.getInt("UsuarioID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getString("Usuario") + "\")' '><span><i class='fa fa-eye'></i></span>Actualizar</button>";	
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";	

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Usuario</th>";
			out += "<th>FechaCreacion</th>";
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
