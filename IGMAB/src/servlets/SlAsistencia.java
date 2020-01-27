package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DTAsistencia;

/**
 * Servlet implementation class SlAsistencia
 */
@WebServlet("/SlAsistencia")
public class SlAsistencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlAsistencia() {
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
		
		try{
			DTAsistencia dta = new DTAsistencia();
			
			int usuarioId=Integer.parseInt(request.getParameter("fusuarioId"));
			
			int psicologoId=dta.obtenerPsicologoID(usuarioId);
			
			
			
			if(dta.actualizarAsistencia(psicologoId)){
				System.out.println("Log out exitosamente");
			}
			else{
				System.out.println("ERROR");
			}
			
		} catch (Exception e) {
			System.out.println("SL error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
		
	}

}
