package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtOpcion;
import entidades.Opcion;

/**
 * Servlet implementation class SlParentescoAjax
 */
@WebServlet("/SlOpcion")

public class SLOpcion extends HttpServlet{
	private static final long serialVersionUID = 1l;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SLOpcion(){
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
		String resp = request.getParameter("opcion").trim();
		String opcion = "";
		DtOpcion dtop = new DtOpcion();
		Opcion op = new Opcion();
		
		switch(resp) {
/////////////////////////// EN CASO DE
/////////////////////////// GUARDAR////////////////////////////////
		case "guardar":
			try{
				opcion = request.getParameter("fopcion");//esta variable es la que se utiliza en el servlet para guardar
				op.setOpcion(opcion);
				
				if (dtop.guardarOpcion(op)) {
					System.out.println("Guardado exitosamente");
					
				}
				
			}
			catch(Exception e){
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;
/////////////////////////// EN CASO DE
/////////////////////////// ACTUALIZAR////////////////////////////////
		case "actualizar":
			try{
				int fopcionId = Integer.parseInt(request.getParameter("fopcionId"));//esta variable se crea en el jsp, para editar en los metodos del servlet
				opcion = request.getParameter("fOpcionEditar");//Variable que se crea en el servlet en el editar. en el jsp
				
				op.setOpcionId(fopcionId);
				op.setOpcion(opcion);
				
				if(dtop.actualizarOpcion(op)){
					System.out.println("Actualizado Exitosamente");
				}
			} catch (Exception e) {
				System.out.println("SL: Error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
/////////////////////////// EN CASO DE
/////////////////////////// ELIMINAR////////////////////////////////
		case "eliminar":
			try {
				int fIdOpcion = Integer.parseInt(request.getParameter("fIdOpcion"));
				System.out.println(fIdOpcion);
				
				if(dtop.eliminarOpcion(fIdOpcion)){
					System.out.println("Eliminado exitosamente");
				}
			} catch(Exception e) {
				System.out.println("SL: error en el servlet:" + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			
/////////////////////////// EN CASO DE
/////////////////////////// REFRESCAR LA
/////////////////////////// TABLA////////////////////////////////
		case "refrescar":
			refrescar(request,response);
			break;
		}
		
	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 try {
			 DtOpcion dtop = new DtOpcion();
			 ResultSet rs = dtop.cargarDatos();
			 
			 response.setContentType("text/html; charset=UTF-8");
			 String out = "";
			 
			 	out += "<thead>";
				out += "<tr>";
				out += "<th>Opci�n</th>";
				out += "<th>Acciones</th>";
				out += "</tr>";
				out += "</thead>";
				
				out += "<tbody>";
				while (rs.next()) {
					out += "<tr>";
					out += "<td>" + rs.getString("opcion") + "</td>";
					//out += "<td>" + rs.getString("Parentesco") + "</td>";
					out +="<td>";
					out +="<button id='btnIdEliminar' value="+rs.getInt("opcionId")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";// este es el boton que se usa en el jsp (Eliminar).
					out += "<button id='btnIdActualizar' value="+rs.getInt("opcionId")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getString("opcion") + "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";	// este es el boton que se usa en el jsp(Actualizar).
					out +="</td>";
					out += "</tr>";
				}
				out += "</tbody>";

				out += "<tfoot>";
				out += "<tr>";
				out += "<th>Opci�n</th>";
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
