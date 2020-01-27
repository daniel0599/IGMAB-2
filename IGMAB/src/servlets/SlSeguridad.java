package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Usuario;
import entidades.Rol;
import datos.DtUsuario;
import datos.DTAsistencia;
import datos.DtRolUsuario;
/**
 * Servlet implementation class SlSeguridad
 */
@WebServlet("/SlSeguridad")

public class SlSeguridad extends HttpServlet{
	private static final long serialVersionUID =1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     */
	 public SlSeguridad() {
	        super();
	        // TODO Auto-generated constructor stub
	    }
	 
	 	/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
	 
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			// TODO Auto-generated method stub
			response.getWriter().append("Served at: ").append(request.getContextPath());
		}
	 
	 	/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			// TODO Auto-generated method stub

			
			try
			{
				Usuario us = new Usuario();
				Usuario usuarioVerificado = new Usuario();
				Rol r = new Rol();
				DtUsuario dtu = new DtUsuario();
				DtRolUsuario dtru = new DtRolUsuario();
				
				
				us.setUsuario(request.getParameter("username"));
				us.setContrasena(request.getParameter("password"));
				r.setRolId(Integer.parseInt(request.getParameter("rol")));

				String out;
				PrintWriter pw = response.getWriter();
				boolean error;
				
				usuarioVerificado = dtu.verificarUsuario(us);
				if(dtru.verificarRol(usuarioVerificado, r))
				{
					HttpSession hts = request.getSession(true);
					hts.setAttribute("usuarioVerificado", usuarioVerificado);
					HttpSession htsRol = request.getSession(true);
					htsRol.setAttribute("Rol", r);
					System.out.println("El Usuario y rol son correcto!!!");
					
					if(r.getRolId()==3){
						DTAsistencia dta = new DTAsistencia();
						dta.comprobarAsistencia(usuarioVerificado.getUsuarioID());
					}
					out="1";
					pw.write(out);
					pw.flush();
					error = pw.checkError();
					System.out.println("Error: "+error);
					//response.sendRedirect("index.jsp?msj=1");
					
				}
				else
				{
					System.out.println("ERROR AL AUTENTICAR, El Usuario y rol no son correcto!!!");

					System.out.println("Pasa por el else validar usuario y rol");
					out="2";
					pw.write(out);
					pw.flush();
					error = pw.checkError();
					System.out.println("Error: "+error);

					//response.sendRedirect("Home.jsp?msj=2");
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				System.out.println("ERROR EN SL_seguridad: "+e.getMessage());
			}
			
		}
	 

}
