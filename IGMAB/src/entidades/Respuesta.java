package entidades;


/**
 * Almacena la selección de la respuesta.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Respuesta {
	
	private int ClasificacionID;
	private int respuestaId;
	private int pacienteId;
	private int respuestaCatalogoID;
	private int eliminado;
   	private int Grado;
   	private int seleccion;
   	private int tituloPreguntaId;
	private String Descripcion;
	
	/**
	 * Atributo que guarda si se selecciona una respuesta o no.
	 */
	
	public Respuesta(){

	}
	

	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}

	public String getDescripcion() {
		return Descripcion;
	}


	public void setDescripcion(String descripcion) {
		Descripcion = descripcion;
	}

	


	public int getSeleccion() {
		return seleccion;
	}


	public void setSeleccion(int seleccion) {
		this.seleccion = seleccion;
	}


	public void finalize() throws Throwable {

	}


	public int getRespuestaId() {
		return respuestaId;
	}


	public void setRespuestaId(int respuestaId) {
		this.respuestaId = respuestaId;
	}


	public int getPacienteId() {
		return pacienteId;
	}


	public void setPacienteId(int pacienteId) {
		this.pacienteId = pacienteId;
	}


	public int getRespuestaCatalogoID() {
		return respuestaCatalogoID;
	}


	public void setRespuestaCatalogoID(int respuestaCatalogoID) {
		this.respuestaCatalogoID = respuestaCatalogoID;
	}
	
	public int getClasificacionID() {
		return ClasificacionID;
	}


	public void setClasificacionID(int clasificacionID) {
		ClasificacionID = clasificacionID;
	}


	public int getGrado() {
		return Grado;
	}


	public void setGrado(int grado) {
		Grado = grado;
	}


	public int getTituloPreguntaId() {
		return tituloPreguntaId;
	}


	public void setTituloPreguntaId(int tituloPreguntaId) {
		this.tituloPreguntaId = tituloPreguntaId;
	}



}