package entidades;


/**
 * Catálogo de opciones del sistema para cada rol
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Opcion {
	
	private int opcionId;
	private int eliminado;

	/**
	 * Opción específica para cada rol
	 */
	private String opcion;

	public Opcion(){

	}
	

	public int getOpcionId() {
		return opcionId;
	}


	public void setOpcionId(int opcionId) {
		this.opcionId = opcionId;
	}


	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public String getOpcion() {
		return opcion;
	}


	public void setOpcion(String opcion) {
		this.opcion = opcion;
	}


	public void finalize() throws Throwable {

	}

}