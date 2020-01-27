package entidades;
import java.util.Date;


/**
 * La clase psicologo se refiere al estudiante de psicología de último año que
 * trabaja en el centro.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Psicologo {
	
//	private int psicologoId;
	private int usuarioID;
	
	public int getUsuarioID() {
		return usuarioID;
	}


	public void setUsuarioID(int usuarioID) {
		this.usuarioID = usuarioID;
	}


	private int eliminado;

	/**
	 * Primer apellido del psicólogo.
	 */
	private String apellido1;
	/**
	 * Segundo apellido del psicólogo.
	 */
	private String apellido2;
	/**
	 * Carnet estudiantil UCA del psicólogo. Longitud de 10 caracteres.
	 */
	private String carnet;
	/**
	 * Fecha en que se crea el registro.
	 */
	private Date fechaCreacion;
	/**
	 * Fecha en que se elimina el registro.
	 */
	private Date fechaEliminacion;
	/**
	 * Fecha en que se modifica el registro.
	 */
	private Date fechaModificacion;
	/**
	 * Primer nombre del psicólogo.
	 */
	private String nombre1;
	/**
	 * Segundo nombre del psicólogo.
	 */
	private String nombre2;
	
	private String Tutor;
	/**
	 * Id del usuario que crea el registro.
	 */
	private int usuarioCreacion;
	/**
	 * Id del usuario que elimina el registro.
	 */
	private int usuarioEliminacion;
	/**
	 * Id del usuario que modifica el registro.
	 */
	private int usuarioModificacion;
	private int PsicologoID;
	
	public int getPsicologoID() {
		return PsicologoID;
	}


	public void setPsicologoID(int psicologoID) {
		PsicologoID = psicologoID;
	}


	public Asistencia m_Asistencia;
	public Consulta m_Consulta;

	public Psicologo(){

	}
	
//
//	public int getPsicologoId() {
//		return psicologoId;
//	}
//
//
//	public void setPsicologoId(int psicologoId) {
//		this.psicologoId = psicologoId;
//	}


	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public String getApellido1() {
		return apellido1;
	}


	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}


	public String getApellido2() {
		return apellido2;
	}


	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}


	public String getCarnet() {
		return carnet;
	}


	public void setCarnet(String carnet) {
		this.carnet = carnet;
	}


	public Date getFechaCreacion() {
		return fechaCreacion;
	}


	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}


	public Date getFechaEliminacion() {
		return fechaEliminacion;
	}


	public void setFechaEliminacion(Date fechaEliminacion) {
		this.fechaEliminacion = fechaEliminacion;
	}


	public Date getFechaModificacion() {
		return fechaModificacion;
	}


	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}


	public String getNombre1() {
		return nombre1;
	}


	public void setNombre1(String nombre1) {
		this.nombre1 = nombre1;
	}


	public String getNombre2() {
		return nombre2;
	}


	public void setNombre2(String nombre2) {
		this.nombre2 = nombre2;
	}


	public int getUsuarioCreacion() {
		return usuarioCreacion;
	}


	public void setUsuarioCreacion(int usuarioCreacion) {
		this.usuarioCreacion = usuarioCreacion;
	}


	public int getUsuarioEliminacion() {
		return usuarioEliminacion;
	}


	public void setUsuarioEliminacion(int usuarioEliminacion) {
		this.usuarioEliminacion = usuarioEliminacion;
	}


	public int getUsuarioModificacion() {
		return usuarioModificacion;
	}


	public void setUsuarioModificacion(int usuarioModificacion) {
		this.usuarioModificacion = usuarioModificacion;
	}


	public Asistencia getM_Asistencia() {
		return m_Asistencia;
	}


	public void setM_Asistencia(Asistencia m_Asistencia) {
		this.m_Asistencia = m_Asistencia;
	}


	public Consulta getM_Consulta() {
		return m_Consulta;
	}


	public void setM_Consulta(Consulta m_Consulta) {
		this.m_Consulta = m_Consulta;
	}


	public void finalize() throws Throwable {

	}


	public String getTutor() {
		return Tutor;
	}


	public void setTutor(String tutor) {
		Tutor = tutor;
	}

}