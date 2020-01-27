package entidades;

import java.util.Date;

/**
 * Vista que carga los datos relacionados entre Pariente y Parentesco
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 06:46:53 PM
 */

public class VParienteParentesco {
	
	private int parienteId;
	private int parentescoId;
	private String parentesco;
	
	/**
	 * Primer apellido del tutor. (Longitud máxima de 30 caracteres)
	 */
	private String apellido1;
	/**
	 * Segundo apellido del tutor. (Longitud máxima de 30 caracteres)
	 */
	private String apellido2;
	/**
	 * Cargo que desempeña el tutor en su trabajo. (Longitud máxima de 50 caracteres)
	 */
	private String cargo;
	/**
	 * Causa de muerte del tutor (depende del estado de vida). (Longitud máxima de 300
	 * caracteres)
	 */
	private String causaMuerte;
	/**
	 * Edad correspondiente al tutor. 
	 */
	private String edad;
	/**
	 * Nivel académico del tutor. (Longitud máxima de 40 caracteres)
	 */
	private String escolaridad;
	/**
	 * Estado actual (1 para vivo o 0 para muerto) del tutor.
	 */
	private int estadoVida;
	/**
	 * Lugar de trabajo del tutor. (Longitud máxima de 100 caracteres)
	 */
	private String lugarTrabajo;
	/**
	 * Primer nombre del tutor. (Longitud máxima de 30 caracteres)
	 */
	private String nombre1;
	/**
	 * Segundo nombre del tutor. (Longitud máxima de 30 caracteres)
	 */
	private String nombre2;
	/**
	 * Ocupación del tutor. (Longitud máxima de 30 caracteres)
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
	
	
	public VParienteParentesco(){
		
	}


	public int getParienteId() {
		return parienteId;
	}


	public void setParienteId(int parienteId) {
		this.parienteId = parienteId;
	}


	public int getParentescoId() {
		return parentescoId;
	}


	public void setParentescoId(int parentescoId) {
		this.parentescoId = parentescoId;
	}


	public String getParentesco() {
		return parentesco;
	}


	public void setParentesco(String parentesco) {
		this.parentesco = parentesco;
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


	public String getEdad() {
		return edad;
	}


	public void setEdad(String edad) {
		this.edad = edad;
	}


	public String getEscolaridad() {
		return escolaridad;
	}


	public void setEscolaridad(String escolaridad) {
		this.escolaridad = escolaridad;
	}


	public int getEstadoVida() {
		return estadoVida;
	}


	public void setEstadoVida(int estadoVida) {
		this.estadoVida = estadoVida;
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
	
	
	
}
