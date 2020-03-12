package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
//import java.text.SimpleDateFormat;
//import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import datos.DtPariente;
import datos.DtVParienteParentesco;
import entidades.Pariente;

//asd

/**
 * Servlet implementation class SlPariente
 */
@WebServlet("/SlPariente")
public class SlPariente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlPariente() {
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
		//se declaran las variables
		String opcion = request.getParameter("opcion").trim();
		String primerNombre ="";
		String segundoNombre="";
		String primerApellido="";
		String segundoApellido="";
		int estadoVida;
		String edad;
	//	String fechaNac;
		String causaMuerte="";
		int escolaridadId=0;
		String escolaridad="";
		String ocupacion="";
		String lugarTrabajo="";
		String cargo="";
		String salarioMensual="";
		int tutor;
		
		DtPariente dtp= new DtPariente();
		Pariente par = new Pariente();
		
		switch(opcion){
		case "guardar":
			try {
				int parentescoId = Integer.parseInt(request.getParameter("fparentescoid"));
				primerNombre = request.getParameter("fprimerNombre");
				segundoNombre = request.getParameter("fsegundoNombre");
				primerApellido = request.getParameter("fprimerApellido");
				segundoApellido = request.getParameter("fsegundoApellido");
				if(request.getParameter("festadoVida") == null)
					estadoVida = Integer.parseInt(request.getParameter("festadoVida"));
				else
					estadoVida = 1;
				
				edad = request.getParameter("fedad");
            //    fechaNac = request.getParameter("ffechaNac");
				causaMuerte = request.getParameter("fcausaMuerte");
				escolaridadId = Integer.parseInt(request.getParameter("fescolaridadId"));
				if(request.getParameter("fescolaridad") == "Seleccione")
					escolaridad = request.getParameter("fescolaridad");
				else
					escolaridad = null;
				
				ocupacion = request.getParameter("focupacion");
				lugarTrabajo = request.getParameter("flugarTrabajo");
				cargo = request.getParameter("fcargo");
				salarioMensual =request.getParameter("fsalarioMensual");
				if(request.getParameter("ftutor") == null)
					tutor = Integer.parseInt(request.getParameter("ftutor"));
				else
					tutor = 0;
				
				int usuarioID =0;
        		
        		//tiporol = Integer.parseInt(request.getParameter("fTipoRol"));
        		usuarioID = Integer.parseInt(request.getParameter("fusuarioID"));

             //   SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            //    Date fecha = formatter.parse(fechaNac);

				par.setNombre1(primerNombre);
				par.setNombre2(segundoNombre);
				par.setApellido1(primerApellido);
				par.setApellido2(segundoApellido);
				par.setEstadoVida(estadoVida);
				par.setEdad(edad);
			//	par.setFechaNac(fecha);
				par.setCausaMuerte(causaMuerte);
				par.setEscolaridadID(escolaridadId);
				par.setEscolaridad(escolaridad);
				par.setOcupacion(ocupacion);
				par.setLugarTrabajo(lugarTrabajo);
				par.setCargo(cargo);
				par.setSalarioMensual(salarioMensual);
      			par.setTutor(tutor);
				par.setParentescoId(parentescoId);
				par.setUsuarioCreacion(usuarioID);
				
				if (dtp.guardarPariente(par)){
					System.out.println("Guardado exitosamente");
				}

				

			} catch (Exception e) {
				System.out.println("SL error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
		case "actualizar":
			try {
				int parienteID = Integer.parseInt(request.getParameter("fParienteId"));
				int parentescoId = Integer.parseInt(request.getParameter("fparentescoidEditar"));
				escolaridadId = Integer.parseInt(request.getParameter("fescolaridadIdEditar"));
				primerNombre = request.getParameter("fprimerNombreEditar");
				segundoNombre = request.getParameter("fsegundoNombreEditar");
				primerApellido = request.getParameter("fprimerApellidoEditar");
				segundoApellido = request.getParameter("fsegundoApellidoEditar");
				estadoVida = Integer.parseInt(request.getParameter("festadoVidaEditar"));
				edad = request.getParameter("fedadEditar");
            //    fechaNac = request.getParameter("ffechaNac");
				causaMuerte = request.getParameter("fcausaMuerteEditar");
				escolaridad = request.getParameter("fescolaridadEditar");
				ocupacion = request.getParameter("focupacionEditar");
				lugarTrabajo = request.getParameter("flugarTrabajoEditar");
				cargo = request.getParameter("fcargoEditar");
				salarioMensual =request.getParameter("fsalarioMensualEditar");
				tutor = Integer.parseInt(request.getParameter("ftutorEditar"));

               // SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            //    Date fecha = formatter.parse(fechaNac);

				par.setParienteId(parienteID);
				par.setNombre1(primerNombre);
				par.setNombre2(segundoNombre);
				par.setApellido1(primerApellido);
				par.setApellido2(segundoApellido);
				par.setEstadoVida(estadoVida);
				par.setEdad(edad);
				//par.setFechaNac(fecha);
				par.setCausaMuerte(causaMuerte);
				par.setEscolaridadID(escolaridadId);
				par.setEscolaridad(escolaridad);
				par.setOcupacion(ocupacion);
				par.setLugarTrabajo(lugarTrabajo);
				par.setCargo(cargo);
				par.setSalarioMensual(salarioMensual);
      			par.setTutor(tutor);
				par.setParentescoId(parentescoId);
				
				
				if(dtp.actualizarPariente(par)){
					System.out.println("Actualizado exitosamente");
				}
				
			} catch (Exception e) {
				System.out.println("SL: error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
			case "eliminar":
				try {
					int fparienteID = Integer.parseInt(request.getParameter("fparienteID"));
					System.out.println(fparienteID);
					
					if(dtp.eliminarPariente(fparienteID)){
						System.out.println("Pariente eliminado exitosamente");
					}
					
				} catch (Exception e) {
					System.out.println("SL: error en el servlet: " + e.getMessage());
					e.printStackTrace();
				}
				
			case "refrescar" :
				refrescar(request,response);
				break;
		}

		
		
	}
	
	protected void refrescar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
           // SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
           // SimpleDateFormat fechaM = new SimpleDateFormat("dd/MM/yyyy");
			DtVParienteParentesco dtpar = new DtVParienteParentesco();
			ResultSet rs = dtpar.cargarVista();
			response.setContentType("text/html; charset=UTF-8");
			String out = "";
			
			out+="<thead>";
			out+="<tr>";
			out+="<th>Nombre completo</th>";
			out+="<th>Estado de vida</th>";
			out+="<th>Edad</th>";
			out+="<th>Tutor</th>";
			out+="<th>Parentesco</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
			out+="</thead>";
			
			out += "<tbody>";
			while(rs.next()){
				
				out += "<td>" + rs.getString("Nombre1")+" "+rs.getString("Nombre2")+" "+rs.getString("Apellido1")+" "+rs.getString("Apellido2") + "</td>";
				
				if(rs.getInt("Estadovida")==1){
					out +="<td>"+"Vivo"+"</td>";
				}
				if(rs.getInt("Estadovida")==0){
					out +="<td>"+"Fallecido"+"</td>";
				}
				out += "<td>" + rs.getString("Edad") + "</td>";
				if(rs.getInt("Tutor")==1){
					out +="<td>"+"Si"+"</td>";
				}
				if(rs.getInt("Tutor")==0){
					out +="<td>"+"No"+"</td>";
				}
				out += "<td>" + rs.getString("Parentesco") + "</td>";
				out += "<td>";
            //    Date fecha = formatter.parse(rs.getString("Fechanac"));

                out += "<button id='btnIdVisualizar' value="+rs.getInt("ParienteID")+" class='btn btn-info' "
                        + "onclick ='visualizarDatos(this.value, \""+ rs.getString("Nombre1") + "\", "
                        + "\""+rs.getString("Nombre2")+"\","
                        + "\""+rs.getString("Apellido1")+"\","
                        + "\""+rs.getString("Apellido2")+"\","
                        + "\""+rs.getString("Ocupacion")+"\","
                        + "\""+rs.getString("Lugartrabajo")+"\","
                        + "\""+rs.getString("Cargo")+"\","
                        + "\""+rs.getString("Salariomensual")+"\","
                        + "\""+rs.getString("Edad")+"\","
                      //  + "\""+fechaM.format(fecha)+"\","
                        + "\""+rs.getInt("EscolaridadID")+"\","
                        + "\""+rs.getString("Escolaridad")+"\","
                        + "\""+rs.getInt("Estadovida")+"\","
                        + "\""+rs.getString("Causamuerte")+"\","
                        +"\""+rs.getInt("ParentescoID")+"\","
                        + "\""+rs.getInt("Tutor")+"\")'><span><i class='fa fa-eye'></i></span>Ver Pariente</button>";

				out += "<button id='btnIdActualizar' value="+rs.getInt("ParienteID")+" class='btn btn-primary btn-label-left' "
						+ "onclick = 'cargarDatos(this.value, \""+ rs.getString("Nombre1") + "\", "
						+ "\""+rs.getString("Nombre2")+"\","
						+ "\""+rs.getString("Apellido1")+"\","
						+ "\""+rs.getString("Apellido2")+"\","
                        + "\""+rs.getString("Ocupacion")+"\","
                        + "\""+rs.getString("Lugartrabajo")+"\","
                        + "\""+rs.getString("Cargo")+"\","
                        + "\""+rs.getString("Salariomensual")+"\","
                        + "\""+rs.getString("Edad")+"\","
                      //  + "\""+fechaM.format(fecha)+"\","
                        + "\""+rs.getInt("EscolaridadID")+"\","
                        + "\""+rs.getString("Escolaridad")+"\","
                        + "\""+rs.getInt("Estadovida")+"\","
						+ "\""+rs.getString("Causamuerte")+"\","
						+"\""+rs.getInt("ParentescoID")+"\","
						+ "\""+rs.getInt("Tutor")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
                out +="<button id='btnIdEliminar' value="+rs.getInt("ParienteID")+" class='ajax-link action btn btn-default btn-label-left' onClick='eliminar(this.value);'><span><i class='fa fa-trash-o txt-danger'></i></span>Eliminar</button>";
				out +="</td>";
				out += "</tr>";
			}
			out += "</tbody>";
			
			out += "<tfoot>";
			out+="<th>Nombre completo</th>";
			out+="<th>Estado de vida</th>";
			out+="<th>Edad</th>";
			out+="<th>Tutor</th>";
			out+="<th>Parentesco</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
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