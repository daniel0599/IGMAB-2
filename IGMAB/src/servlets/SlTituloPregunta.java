package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtTituloPregunta;
import entidades.TituloPregunta;

/**
 * Servlet implementation class SlTituloPregunta
 */
@WebServlet("/SlTituloPregunta")
public class SlTituloPregunta extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlTituloPregunta() {
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
		String desc = "";
		DtTituloPregunta dtt = new DtTituloPregunta();
		TituloPregunta tituloPregunta = new TituloPregunta();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {
				desc = request.getParameter("fdescripcion");
				tituloPregunta.setDescripcion(desc);

				if (dtt.guardarTituloPregunta(tituloPregunta)) {
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
				int ftituloPreguntaId = Integer.parseInt(request.getParameter("fTituloPreguntaId"));
				desc = request.getParameter("fDescripcionEditar");
				
				tituloPregunta.setTituloPreguntaId(ftituloPreguntaId);
				tituloPregunta.setDescripcion(desc);

				if (dtt.actualizarTituloPregunta(tituloPregunta)) {
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
				int ftituloPreguntaId = Integer.parseInt(request.getParameter("fTituloPreguntaId"));
				System.out.println(ftituloPreguntaId);
				
				if(dtt.eliminarTituloPregunta(ftituloPreguntaId)){
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
			DtTituloPregunta dtt = new DtTituloPregunta();
			ResultSet rs = dtt.cargarDatos();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Titulo</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Descripcion") + "</td>";
				out +="<td>";
				out +="<button id='btnIdEliminar' value="+rs.getInt("TitulopreguntaID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value="+rs.getInt("TitulopreguntaID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getString("Descripcion") + "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";	
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Titulo</th>";
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
