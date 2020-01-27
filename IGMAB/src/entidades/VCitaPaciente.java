package entidades;

import java.sql.Time;
import java.util.Date;

/**
 * Vista que carga los datos relacionados entre Cita y Paciente
 * 
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 03:33:00 PM
 */

public class VCitaPaciente {
	private int citaID;
	private int pacienteID;
	private int numSesion;
	private String nombre1;
	private String nombre2;
	private String apellido1;
	private String apellido2;
	private Date fecha;
	private Time hora;
	
	public VCitaPaciente(){
		
	}
	
	public int getCitaID() {
		return citaID;
	}
	public void setCitaID(int citaID) {
		this.citaID = citaID;
	}
	public int getPacienteID() {
		return pacienteID;
	}
	public void setPacienteID(int pacienteID) {
		this.pacienteID = pacienteID;
	}
	public int getNumSesion() {
		return numSesion;
	}
	public void setNumSesion(int numSesion) {
		this.numSesion = numSesion;
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
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public Time getHora() {
		return hora;
	}
	public void setHora(Time hora) {
		this.hora = hora;
	}
	
	

}
