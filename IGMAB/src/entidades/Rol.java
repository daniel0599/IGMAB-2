package entidades;


/**
 * Catálogo de roles del sistema.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Rol {
	
	private int rolId;
	private int eliminado;

	/**
	 * Nombre específico del rol
	 */
	private String nombre;
	
	private Opcion m_Opcion;
	private Usuario m_Usuario;

	public Rol(){

	}
	

	public int getRolId() {
		return rolId;
	}


	public void setRolId(int rolId) {
		this.rolId = rolId;
	}


	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public Opcion getM_Opcion() {
		return m_Opcion;
	}


	public void setM_Opcion(Opcion m_Opcion) {
		this.m_Opcion = m_Opcion;
	}


	public Usuario getM_Usuario() {
		return m_Usuario;
	}


	public void setM_Usuario(Usuario m_Usuario) {
		this.m_Usuario = m_Usuario;
	}


	public void finalize() throws Throwable {

	}

}