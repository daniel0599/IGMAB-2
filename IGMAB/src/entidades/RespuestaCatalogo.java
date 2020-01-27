package entidades;


/**
 * Catálogo que contiene las respuestas que se muestran al paciente.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class RespuestaCatalogo {
	
	private int respuestaCatalogoID;
	private int tituloPreguntaId;
	private int respClasificacion;
	private int eliminado;

	/**
	 * Una respuesta del catálogo en la ficha de admisión del paciente.
	 */
	private String descripcion;
	
	private Respuesta m_Respuesta;


	public RespuestaCatalogo(){

	}
	

	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}


	public Respuesta getM_Respuesta() {
		return m_Respuesta;
	}


	public void setM_Respuesta(Respuesta m_Respuesta) {
		this.m_Respuesta = m_Respuesta;
	}


	

	public void finalize() throws Throwable {

	}


	public int getRespuestaCtalogoID() {
		return respuestaCatalogoID;
	}


	public void setRespuestaCtalogoID(int respuestaCtalogoID) {
		this.respuestaCatalogoID = respuestaCtalogoID;
	}


	public int getTituloPreguntaId() {
		return tituloPreguntaId;
	}


	public void setTituloPreguntaId(int tituloPreguntaId) {
		this.tituloPreguntaId = tituloPreguntaId;
	}


	public int getRespClasificacion() {
		return respClasificacion;
	}


	public void setRespClasificacion(int respClasificacion) {
		this.respClasificacion = respClasificacion;
	}

}