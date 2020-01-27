package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtRespuestaCatalogo;
import datos.DtVRespuestaCatTituloPreg;
import entidades.RespuestaCatalogo;

/**
 * Servlet implementation class SlRespuestaCatalogo
 */
@WebServlet("/SlRespuestaCatalogo")
public class SlRespuestaCatalogo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	
	public SlRespuestaCatalogo(){
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

	// Se declaran variables que almacenan los datos de la interfaz de usuario
		String opcion = request.getParameter("opcion").trim();
		String descripcion = "";
	
	
		
		DtRespuestaCatalogo dtrc = new DtRespuestaCatalogo();
		RespuestaCatalogo rc = new RespuestaCatalogo();
		
		switch (opcion){
		
		// En caso de guardar
		case "guardar":
			try {

				int tituloPreguntaId = Integer.parseInt(request.getParameter("ftitulopreguntaid"));
				descripcion = request.getParameter("fdescripcion");
				int clasificacionId = Integer.parseInt(request.getParameter("fclasificacion"));
				

				
			    rc.setDescripcion(descripcion);
			    rc.setTituloPreguntaId(tituloPreguntaId);
				rc.setRespClasificacion(clasificacionId);
				
				if (dtrc.guardarRespuestaCatalogo(rc)){
					System.out.println("Guardado exitosamente");
				}
			}
				catch(Exception e) {
					System.out.println("SL error en el servlet: " + e.getMessage());
					e.printStackTrace();
				}
				break;
				
				// En caso de actualizar
		case "actualizar":
			try {
				int respuestaCtalogoID = Integer.parseInt(request.getParameter("fRespuestaCatalogoID"));
				int tituloPreguntaId = Integer.parseInt(request.getParameter("ftitulopreguntaEditar"));
				int clasificacionId = Integer.parseInt(request.getParameter("fclasificacionEditar"));
				descripcion = request.getParameter("fdescripcionEditar");
				
			    rc.setDescripcion(descripcion);
			    rc.setRespClasificacion(clasificacionId);
			    rc.setTituloPreguntaId(tituloPreguntaId);
			    rc.setRespuestaCtalogoID(respuestaCtalogoID);
				
				if (dtrc.actualizarRespuestaCatalogo(rc)){
					System.out.println("Actualizado exitosamente");
				}
			}
				catch (Exception e){
					System.out.println("SL: error en el servlet:" + e.getMessage());
					e.printStackTrace();
				}
			
				break;
			
			// En caso de eliminar
		case "eliminar":
			try {
				int fRespuestaCtalogoID = Integer.parseInt(request.getParameter("fRespuestaCatalogoID"));
				System.out.println(fRespuestaCtalogoID);
				
				if(dtrc.eliminarRespuestaCatalogo(fRespuestaCtalogoID)){
					System.out.println("Respuesta catalogo eliminada exitosamente");
				}
			}
			catch(Exception e){
				System.out.println("SL: error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			//En caso de refrescar la tabla 
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
				DtVRespuestaCatTituloPreg dtrc = new DtVRespuestaCatTituloPreg();
				ResultSet rs = dtrc.cargarVista();
				
				response.setContentType("text/html; charset=UTF-8");
				String out = "";
				
				out += "<thead>";
				out += "<tr>";
				out += "<th>T�tulo de pregunta</th>";
				out +="<th>Tipo de Respuesta</th>";
				out += "<th>Respuesta</th>";
				out += "<th>Acciones</th>";
				out += "</tr>";
				out += "</thead>";
				
				out += "<tbody>";
				while (rs.next()) {
					out += "<tr>";
					out += "<td>" + rs.getString("preguntaDesc") + "</td>";
					out += "<td>" + rs.getString("respuestaDesc") + "</td>";
					out += "<td>"+ rs.getString("Descripcion")+ "</td>";
					out +="<td>";
					out +="<button id='btnIdEliminar' value="+rs.getInt("RespuestaCatalogoID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
					out += "<button id='btnIdActualizar' value="+rs.getInt("RespuestaCatalogoID")+ " class='btn btn-primary btn-label-left' onclick = 'cargarDatos(this.value, \"" + rs.getInt("TitulopreguntaID") + "\", \""+rs.getString("respuestaDesc")+"\", \"" + rs.getInt("TitulopreguntaID") + "\")' '><span><i class='fa fa-edit'></i></span>Actualizar</button>";
					out +="</td>";
					out += "</tr>";
				}
				out += "</tbody>";

				out += "<tfoot>";
				out += "<tr>";
				out += "<th>T�tulo de pregunta</th>";
				out +="<th>Tipo de Respuesta</th>";
				out += "<th>Respuesta</th>";
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

