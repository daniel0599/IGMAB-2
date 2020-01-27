package entidades;


/**
 * Clase que le corresponden las respuestas a las preguntas abiertas en la ficha
 * de admisión
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class RespuestaAbierta {
	
	private int repuestaAbiertaId;
	private int eliminado;

	/**
	 * Atributo que almacena la respuesta abierta como tal.
	 */
	private String respuestaAbierta;

	public RespuestaAbierta(){

	}
	

	public int getRepuestaAbiertaId() {
		return repuestaAbiertaId;
	}


	public void setRepuestaAbiertaId(int repuestaAbiertaId) {
		this.repuestaAbiertaId = repuestaAbiertaId;
	}


	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public String getRespuestaAbierta() {
		return respuestaAbierta;
	}


	public void setRespuestaAbierta(String respuestaAbierta) {
		this.respuestaAbierta = respuestaAbierta;
	}


	public void finalize() throws Throwable {

	}

}