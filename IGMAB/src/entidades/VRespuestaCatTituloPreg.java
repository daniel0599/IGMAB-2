package entidades;

/**
 * Vista que carga los datos relacionados entre RespuestaCatalogo y TituloPregunta
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 03:33:00 PM
 */

public class VRespuestaCatTituloPreg {
	
	private int respuestaCatalogoId;
	private int tituloPreguntaId;
	private String respuestaDesc;
	private String preguntaDesc;
	
	public VRespuestaCatTituloPreg(){
		
	}
	
	public int getRespuestaCatalogoId() {
		return respuestaCatalogoId;
	}
	public void setRespuestaCatalogoId(int respuestaCatalogoId) {
		this.respuestaCatalogoId = respuestaCatalogoId;
	}
	public int getTituloPreguntaId() {
		return tituloPreguntaId;
	}
	public void setTituloPreguntaId(int tituloPreguntaId) {
		this.tituloPreguntaId = tituloPreguntaId;
	}
	public String getRespuestaDesc() {
		return respuestaDesc;
	}
	public void setRespuestaDesc(String respuestaDesc) {
		this.respuestaDesc = respuestaDesc;
	}
	public String getPreguntaDesc() {
		return preguntaDesc;
	}
	public void setPreguntaDesc(String preguntaDesc) {
		this.preguntaDesc = preguntaDesc;
	}
	
	
}
