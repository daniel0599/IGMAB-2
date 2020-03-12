package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidades.Respuesta;
import datos.DtRespuesta;
import datos.DtRespuestaCatalogo;
import datos.DtTituloPregunta;
import datos.Dt_Clasificacion_Respuesta;

/**
 * Servlet implementation class SlRespuesta
 */
@WebServlet("/SlRespuesta")
public class SlRespuesta extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private int pacienteID;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlRespuesta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
		  
			//invocando los DT de titulopregunta, clasificacion de respuesta catalogo y respuesta para contarlos
			DtTituloPregunta dta = new DtTituloPregunta();
			Dt_Clasificacion_Respuesta dtcrc = new Dt_Clasificacion_Respuesta();
			DtRespuestaCatalogo dtrescat = new DtRespuestaCatalogo();
			
			//Invocando al DT de respuesta y creando las variables a alamacenar 
			DtRespuesta dtres = new DtRespuesta();
			Respuesta re = new Respuesta();
			String descripcion;
			int clasificacionID;
			int respuestaCatalogoID;
			int pacienteID;
			int grado;
			int seleccion;
			int titulopreguntaid;
			
			//Capturamos el ID del paciente que viene desde el jsp 
			this.pacienteID = Integer.valueOf(request.getParameter("pacienteId"));
			
			//System.out.println("Hay "+dta.calcularTitulos()+"Titulos");
			//System.out.println("Hay "+dtcrc.calcularClasificaciones()+"Clasificaciones");
			//System.out.println("Hay"+dtrescat.calcularRespuestasCatalogo()+"Respuestas");
			
			for(int i= 1;i<=dta.calcularTitulos();i++){
				for(int j= 1;j<=dtcrc.calcularClasificaciones();j++){
					for(int k= 1;k<=dtrescat.calcularRespuestasCatalogo();k++){
						String a = "respcat"+String.valueOf(i)+String.valueOf(j)+String.valueOf(k);
						//System.out.println("LA RESPCAT es :"+a);
						
						//Obtengo el valor de cada input 
						String opcion = request.getParameter(a);
						System.out.println("LA opcion a insertar es :"+opcion);
						
						//Variable que obtiene el ID de la respuesta y sirve para comprobar su clasificacion
						int auxcla = Integer.parseInt(a.substring(9, a.length()));
						//System.out.println("El ID de la respuesta es:"+auxcla);
						//System.out.println("El ID de la respuesta: "+auxcla+" tine la clasificacion "+dtrescat.returnIdClasificacion(auxcla));
						
						if(j==1 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							//System.out.println("Esta es una respuesta de seleccion multiple ");
							if(opcion!=null &&  opcion.equals("on")){
							
							seleccion = 1;
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
							
						
							
							//System.out.println("Seleccion es : "+seleccion);
							//System.out.println("PAcienteID es : "+this.pacienteID);
							//System.out.println("ClasificacionID es : "+j);
							//System.out.println("respuestaCatalogoID: "+k);
							//System.out.println("TitulopreguntaID: "+i);
							
							re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							
							}else{
						       
								//System.out.println("CHECKBOX NO MARCADO NO SE GUARDO");

						    }
							
						}else if(j==2 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							//System.out.println("Esta es una respuesta cerrada ");
							if(opcion!=null &&  opcion.equals("1")){
								
							seleccion = 1;
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
						
							
							
//							System.out.println("Seleccion es : "+seleccion);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("TitulopreguntaID: "+i);
							
							re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							
							}else{
								seleccion = 0;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
							
								
								
//								System.out.println("Seleccion es : "+seleccion);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setSeleccion(seleccion);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
								//System.out.println("RADIO BUTTON CON SI NO MARCADO aun asi SE GUARDO");

						    }							
						}else if(j==3 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							//System.out.println("Esta es una respuesta cerrada pero con descripcion");
							if(opcion!=null &&  opcion.equals("1")){
							//	System.out.println("RADIO BUTTON CON SI MARCADO");
							seleccion = 1;
							descripcion = request.getParameter("respcatdesc"+i+""+j+""+k);
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
							
//							System.out.println("Seleccion es : "+seleccion);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("La descripcion o por que es: "+descripcion);
//							System.out.println("TitulopreguntaID: "+i);
//							
							
							re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							if(descripcion.equals(null)){
								re.setDescripcion(" ");
							}else{
								re.setDescripcion(descripcion);
									
							}
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							
						    }else if(opcion!=null &&  opcion.equals("0")){
						    	System.out.println("RADIO BUTTON CON NO MARCADO");
						    	seleccion = 0;
								descripcion = request.getParameter("respcatdesc"+i+""+j+""+k);
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Seleccion es : "+seleccion);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("La descripcion o por que es: "+descripcion);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setSeleccion(seleccion);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								if(descripcion.equals(null)){
									re.setDescripcion(" ");
								}else{
									re.setDescripcion(descripcion);
										
								}
								re.setTituloPreguntaId(titulopreguntaid);
								dtres.guardarRespuesta(re);
								
								
								
						    }
						}else if(j==4 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							System.out.println("Esta es una respuesta con grado ");
							if(opcion!=null &&  opcion.equals("1")){
							
							grado = 1;
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
							
//							System.out.println("Grado es : "+grado);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("TitulopreguntaID: "+i);
							
							re.setGrado(grado);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
						
							}else if(opcion!=null &&  opcion.equals("2")){
						    	grado = 2;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);	
														    
							}else if(opcion!=null &&  opcion.equals("3")){
						    	grado = 3;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
							}else if(opcion!=null &&  opcion.equals("4")){
						    	grado = 4;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
						    }else if(opcion!=null &&  opcion.equals("5")){
						    	grado = 5;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
						    }else if(opcion!=null &&  opcion.equals("6")){
						    	grado = 6;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
						    }else if(opcion!=null &&  opcion.equals("7")){
						    	grado = 7;
								pacienteID = this.pacienteID;
								clasificacionID = j;
								respuestaCatalogoID = k;
								titulopreguntaid = i;
								
//								System.out.println("Grado es : "+grado);
//								System.out.println("PAcienteID es : "+this.pacienteID);
//								System.out.println("ClasificacionID es : "+j);
//								System.out.println("respuestaCatalogoID: "+k);
//								System.out.println("TitulopreguntaID: "+i);
								
								re.setGrado(grado);
								re.setPacienteId(pacienteID);
								re.setClasificacionID(clasificacionID);
								re.setRespuestaCatalogoID(respuestaCatalogoID);
								re.setTituloPreguntaId(titulopreguntaid);
								
								dtres.guardarRespuesta(re);
								
						    }else{
						    	System.out.println("ES imposible que no haya un radio button marcado");
						    }
						}else if(j==5 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
						
							System.out.println("Esta es una respuesta de seleccion multiple con descripcion");
							if(opcion!=null &&  opcion.equals("on")){
							
							seleccion = 1;
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							descripcion = request.getParameter("respcatdesc"+i+""+j+""+k);
							titulopreguntaid = i;
							
//							System.out.println("Seleccion es : "+seleccion);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("Descripcion: "+descripcion);
//							System.out.println("TitulopreguntaID: "+i);
							
							re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							if(descripcion.equals(null)){
								re.setDescripcion(" ");
							}else{
								re.setDescripcion(descripcion);
									
							}
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							re.setDescripcion(null);
							}else{
						    	System.out.println("CHECKBOX NO MARCADO NO SE GUARDARA NADA");

						    }

                       							
							
						}else if(j==6 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							//System.out.println("Esta es una respuesta cerrada pero con descripcion");
							//if(opcion!=null ){
							//	System.out.println("RADIO BUTTON CON SI MARCADO");
							//seleccion = 1;
							descripcion = request.getParameter("respcatdesc"+i+""+j+""+k);
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
							
//							System.out.println("Seleccion es : "+seleccion);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("La descripcion o por que es: "+descripcion);
//							System.out.println("TitulopreguntaID: "+i);
							
							
							//re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							if(descripcion.equals(null)){
								re.setDescripcion(" ");
							}else{
								re.setDescripcion(descripcion);
									
							}
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							
						  //  }
						}else if(j==7 && dtrescat.returnIdClasificacion(auxcla)==j && dtrescat.returnIdTitulo(auxcla)==i){
							//System.out.println("Esta es una respuesta cerrada pero con descripcion");
							//if(opcion!=null ){
							//	System.out.println("RADIO BUTTON CON SI MARCADO");
							//seleccion = 1;
							descripcion = request.getParameter("respcatdesc"+i+""+j+""+k);
							pacienteID = this.pacienteID;
							clasificacionID = j;
							respuestaCatalogoID = k;
							titulopreguntaid = i;
							
//							System.out.println("Seleccion es : "+seleccion);
//							System.out.println("PAcienteID es : "+this.pacienteID);
//							System.out.println("ClasificacionID es : "+j);
//							System.out.println("respuestaCatalogoID: "+k);
//							System.out.println("La descripcion o por que es: "+descripcion);
//							System.out.println("TitulopreguntaID: "+i);
							
							
							//re.setSeleccion(seleccion);
							re.setPacienteId(pacienteID);
							re.setClasificacionID(clasificacionID);
							re.setRespuestaCatalogoID(respuestaCatalogoID);
							if(descripcion.equals(null)){
								re.setDescripcion(" ");
							}else{
								re.setDescripcion(descripcion);
									
							}
							re.setTituloPreguntaId(titulopreguntaid);
							
							dtres.guardarRespuesta(re);
							
						  //  }
						}
						
					}
				}
			}
			response.sendRedirect("./ajax/paciente.jsp");
		}
		catch(Exception e)
		   {
			 e.printStackTrace();
			 System.out.println("SERVLET de la plantilla respuesta "+e.getMessage());
			 response.sendRedirect("./index.jsp");
		   }
	}

}
