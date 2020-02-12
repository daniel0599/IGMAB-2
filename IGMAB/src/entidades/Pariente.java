package entidades;
import java.util.Date;


/**
 * El padre, madre o tutor legal del paciente a ingresar en el centro.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Pariente {
	
	private int parienteId;
	private int parentescoId;
	private int eliminado;
	private int escolaridadID;

	//private Date fechaNac;

	/**
	 * Primer apellido del tutor. (Longitud m�xima de 30 caracteres)
	 */
	private String apellido1;
	/**
	 * Segundo apellido del tutor. (Longitud m�xima de 30 caracteres)
	 */
	private String apellido2;
	/**
	 * Cargo que desempe�a el tutor en su trabajo. (Longitud m�xima de 50 caracteres)
	 */
	private String cargo;
	/**
	 * Causa de muerte del tutor (depende del estado de vida). (Longitud m�xima de 300
	 * caracteres)
	 */
	private String causaMuerte;
	/**
	 * Edad correspondiente al tutor. 
	 */
	private String edad;
	public String getEdad() {
		return edad;
	}


	public void setEdad(String edad) {
		this.edad = edad;
	}


	/**
	 * Nivel acad�mico del tutor. (Longitud m�xima de 40 caracteres)
	 */
	private String escolaridad;
	/**
	 * Estado actual (1 para vivo o 0 para muerto) del tutor.
	 */
	private int estadoVida;

	/**
	 * Fecha en la que se crea el registro.
	 */
	private Date fechaCreacion;
	/**
	 * Fecha en la que se elimina el registro l�gicamente.
	 */
	private Date fechaEliminacion;
	/**
	 * Fecha en la que se modifica el registro.
	 */
	private Date fechaModificacion;
	/**
	 * Lugar de trabajo del tutor. (Longitud m�xima de 100 caracteres)
	 */
	private String lugarTrabajo;
	/**
	 * Primer nombre del tutor. (Longitud m�xima de 30 caracteres)
	 */
	private String nombre1;
	/**
	 * Segundo nombre del tutor. (Longitud m�xima de 30 caracteres)
	 */
	private String nombre2;
	/**
	 * Ocupaci�n del tutor. (Longitud m�xima de 30 caracteres)
	 */
	private String ocupacion;
	/**
	 * Salario mensual del tutor.
	 */
	private String salarioMensual;
	/**
	 * Para confirmar si es tutor (1) o no (0)
	 */
	private int tutor;
	/**
	 * Id del usuario que crea el registro.
	 */
	private int usuarioCreacion;
	/**
	 * Id del usuario que elimina el registro.
	 */
	private int usuarioEliminacion;
	/**
	 * Id del usuario que crea el registro.
	 */
	private int usuarioModificacion;

	public Pariente(){

	}
	
	
	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public int getEstadoVida() {
		return estadoVida;
	}


	public void setEstadoVida(int estadoVida) {
		this.estadoVida = estadoVida;
	}
	
	public int getParentescoId() {
		return parentescoId;
	}


	public void setParentescoId(int parentescoId) {
		this.parentescoId = parentescoId;
	}


	public int getParienteId() {
		return parienteId;
	}


	public void setParienteId(int parienteId) {
		this.parienteId = parienteId;
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


	public String getCargo() {
		return cargo;
	}


	public void setCargo(String cargo) {
		this.cargo = cargo;
	}


	public String getCausaMuerte() {
		return causaMuerte;
	}


	public void setCausaMuerte(String causaMuerte) {
		this.causaMuerte = causaMuerte;
	}


	


	public String getEscolaridad() {
		return escolaridad;
	}


	public void setEscolaridad(String escolaridad) {
		this.escolaridad = escolaridad;
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


	public String getLugarTrabajo() {
		return lugarTrabajo;
	}


	public void setLugarTrabajo(String lugarTrabajo) {
		this.lugarTrabajo = lugarTrabajo;
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


	public String getOcupacion() {
		return ocupacion;
	}


	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}


	public String getSalarioMensual() {
		return salarioMensual;
	}


	public void setSalarioMensual(String salarioMensual) {
		this.salarioMensual = salarioMensual;
	}


	public int getTutor() {
		return tutor;
	}


	public void setTutor(int tutor) {
		this.tutor = tutor;
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


	public void finalize() throws Throwable {
		//asd
	}

//	public Date getFechaNac() {
//		return fechaNac;
//	}
//
//	public void setFechaNac(Date fechaNac) {
//		this.fechaNac = fechaNac;
//	}

	public int getEscolaridadID() {
		return escolaridadID;
	}

	public void setEscolaridadID(int escolaridadID) {
		this.escolaridadID = escolaridadID;
	}
}