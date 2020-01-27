package entidades;
import java.util.Date;


/**
 * La consulta es una nota/descripción de los psicólogos acerca de cada sesión con
 * el paciente.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:16 AM
 */
public class Consulta {
	
	private int consultaId;
	private int citaId;
	private int psicologoId;
	private int pacienteId;
	private int eliminado;

	/**
	 * Si el paciente asiste a la cita o no.
	 */
	
	private String descripcion;
	/**
	 * Fecha en que se realiza la consulta.
	 */
	
	private String objetivo;
	private String actividad;
	private Date fecha;
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

	public Consulta(){

	}
	
	public int getpacienteId() {
		return pacienteId;
	}


	public void setpacienteId(int pacienteId) {
		this.pacienteId = pacienteId;
	}
	
	public int getpsicologoId() {
		return psicologoId;
	}


	public void setpsicologoId(int psicologoId) {
		this.psicologoId = psicologoId;
	}

	
	
	public int getcitaId() {
		return citaId;
	}


	public void setcitaId(int citaId) {
		this.citaId = citaId;
	}

	
	public int getConsultaId() {
		return consultaId;
	}


	public void setConsultaId(int consultaId) {
		this.consultaId = consultaId;
	}


	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}



	public String getObjetivo() {
		return objetivo;
	}

	public void setObjetivo(String objetivo) {
		this.objetivo = objetivo;
	}

	public String getActividad() {
		return actividad;
	}

	public void setActividad(String actividad) {
		this.actividad = actividad;
	}

	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}


	public Date getFecha() {
		return fecha;
	}


	public void setFecha(Date fecha) {
		this.fecha = fecha;
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

	}

}