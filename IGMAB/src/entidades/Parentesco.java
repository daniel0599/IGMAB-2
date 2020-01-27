package entidades;


/**
 * Parentesco de la persona asociada al paciente.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Parentesco {
	
	private int parentescoID;
	private int eliminado;

	/**
	 * Atributo que almacena el título del parentesco. Ejemplo: padre, madre, hermano,
	 * entre otros.
	 */
	private String parentesco;
	private Pariente m_Pariente;

	public Parentesco(){

	}
	
	
	
	public int getEliminado() {
		return eliminado;
	}



	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}



	public int getParentescoID() {
		return parentescoID;
	}




	public void setParentescoID(int parentescoID) {
		this.parentescoID = parentescoID;
	}




	public String getParentesco() {
		return parentesco;
	}


	public void setParentesco(String parentesco) {
		this.parentesco = parentesco;
	}


	public Pariente getM_Pariente() {
		return m_Pariente;
	}


	public void setM_Pariente(Pariente m_Pariente) {
		this.m_Pariente = m_Pariente;
	}


	public void finalize() throws Throwable {

	}

}