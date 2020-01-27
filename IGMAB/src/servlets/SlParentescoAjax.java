package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtParentesco;
import entidades.Parentesco;

/**
 * Servlet implementation class SlParentescoAjax
 */
@WebServlet("/SlParentescoAjax")
public class SlParentescoAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SlParentescoAjax() {
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
		String parentesco = "";
//		int fIdParentesco = 0;
		DtParentesco dtp = new DtParentesco();
		Parentesco par = new Parentesco();

		switch (opcion) {

		/////////////////////////// EN CASO DE
		/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try {
				parentesco = request.getParameter("fparentesco");
				par.setParentesco(parentesco);

				if(dtp.validarParentescoRepetido(par.getParentesco())){
					if (dtp.guardarParentesco(par)) {
						System.out.println("MENSAJE DEL SERVLET: Guardado exitosamente");
					}
				}
				else {
					System.out.println("Pasa por el else validar parentesco");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
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
				int fParentescoId = Integer.parseInt(request.getParameter("fParentescoId"));
				parentesco = request.getParameter("fParentescoEditar");
				
				par.setParentescoID(fParentescoId);
				par.setParentesco(parentesco);

				if(dtp.validarParentescoRepetido(par.getParentesco())) {
					if (dtp.actualizarParentesco(par)) {
						System.out.println("MENSAJE DEL SERVLET: Actualizado exitosamente");
					}
				}
				else {
					System.out.println("Pasa por el else validar parentesco");
					String out="1";
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error: "+error);
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
				int fIdParentesco = Integer.parseInt(request.getParameter("fIdParentesco"));
				System.out.println(fIdParentesco);
				
				if(dtp.eliminarParentesco(fIdParentesco)){
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
			DtParentesco dtp = new DtParentesco();
			ResultSet rs = dtp.cargarDatos();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Tipo de parentesco</th>";
			out += "<th>Acciones</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("Parentesco") + "</td>";
				out +="<td>";
				out +="<button id='btnIdEliminar' value="+rs.getInt("ParentescoID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out += "<button id='btnIdActualizar' value="+rs.getInt("ParentescoID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getString("Parentesco") + "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";	
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Tipo de parentesco</th>";
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
