package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtRolOpcion;
//import datos.DtRolUsuario;
import entidades.RolOpcion;
//import entidades.RolUsuario;

	/**
	 * Servlet implementation class SlRolOpcion
	 */
	@WebServlet("/SlRolOpcion")
	public class SlRolOpcion extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
		 public SlRolOpcion() {
		        super();
		        // TODO Auto-generated constructor stub
		    }


		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// TODO Auto-generated method stub
			response.getWriter().append("Served at: ").append(request.getContextPath());
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// TODO Auto-generated method stub
			
				DtRolOpcion dtro = new DtRolOpcion();
				RolOpcion tor = new RolOpcion();
				//DtRolUsuario dtur = DtRolUsuario.getInstance();
				//RolUsuario tur = new RolUsuario();
				
				String opcion = request.getParameter("opcion").trim();
				
				switch(opcion) {
				case "guardar":{
					try{
						String idrol, idopcion = "";
						
						idrol = request.getParameter("fIdRol");
						idopcion = request.getParameter("fIdOpcion");
						
						tor.setRolID(Integer.parseInt(idrol));
						tor.setOpcionID(Integer.parseInt(idopcion));
						System.out.println("fidRol " + idrol );
						System.out.println("fidOpcion " + idopcion);
						
						if(dtro.guardarRolOpcion(tor))
						{
						} else{
							System.err.println("ERROR");
						}
					}
					catch(Exception e){
						System.out.println("SL: error en el servlet RolOpcion:" + e.getMessage());
						e.printStackTrace();
					}
					break;
				}
					
				case "eliminar": {
					try {
						int fIdRolOpcion = Integer.parseInt(request.getParameter("fIdRolOpcion"));
						System.out.println(fIdRolOpcion);
						
						if (dtro.eliminarRolOpcion(fIdRolOpcion)) {
							System.out.println("Eliminado exitosamente");
						}
					}catch(Exception e){
						System.out.println("SL: error en el servlet RolUsuario:" + e.getMessage());
						e.printStackTrace();
					}
					break;
				}
					
				case "refrescar":{
					refrescar(request, response);
					break;
				}
				
			 }
		}			
				protected void refrescar(HttpServletRequest request, HttpServletResponse response)
						throws ServletException, IOException {
					try{
					DtRolOpcion dtro = new DtRolOpcion();
					ResultSet rs = dtro.cargarVista();
					ResultSet rt=dtro.cargarDatos();
					rt.beforeFirst();
					rs.beforeFirst();
					response.setContentType("text/html; charset=UTF-8");
					String out = "";

					out+="<thead>";
					out+="<tr>";
					out+="<th>Rol</th>";
					out+="<th>Opcion</th>";
					out+="<th>Url</th>";
					out+="<th>Acciones</th>";
					out+="</tr>";
					out+="</thead>";
					
					out+="<tbody>";
					while(rs.next()&& rt.next())
					{
						out+="<tr>";
						out+="<td>"+rs.getString("rol")+"</td>";									
						out+="<td>"+rs.getString("opciones")+"</td>";	
						out+="<td>"+rs.getString("opcion")+"</td>";	
						out+="<td>";
						out +="<button id='btnIdEliminar' value="+rt.getInt("rol_opcion")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
						out += "</td>";
						out += "</tr>";
					}
					
					out+="</tbody>";
					
					out+="<tfoot>";
					out+="<tr>";
					out+="<th>Rol</th>";
					out+="<th>Opcion</th>";
					out+="<th>Url</th>";
					out+="<th>Acciones</th>";
					out+="</tr>";
					out+="</tfoot>";
					
					PrintWriter pw = response.getWriter();
					pw.write(out);
					pw.flush();
					boolean error = pw.checkError();
					System.out.println("Error? "+error);
				
			} 
			catch (Exception e) 
			{
				System.out.println("SL: error en el servlet RolOpcion:" +e.getMessage());
				e.printStackTrace();
			}
		}

   }
