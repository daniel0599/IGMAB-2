package entidades;
import java.util.Date;




/**
 * La asistencia es el marcado del estudiante para empezar a trabajar y para
 * terminar su trabajo en el centro.
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:16 AM
 */
public class Asistencia {

	/**
	 * La fecha del día de hoy en que se marca la asistencia.
	 */
	private Date fecha;
	/**
	 * Hora en que el psicólogo empieza a atender.
	 */
	private Date horaEntrada;
	/**
	 * Hora en que el psicólogo termina de atender.
	 */
	private Date horaSalida;
	private int eliminado;
	private int AsistenciaId;
    private int PsicologoID;
	public Asistencia(){

	}
	
	
	
    public int getEliminado() {
		return eliminado;
	}



	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}



	public int getAsistenciaId() {
		return AsistenciaId;
	}

	public void setAsistenciaId(int asistenciaId) {
		AsistenciaId = asistenciaId;
	}

	public int getPsicologoID() {
		return PsicologoID;
	}

	public void setPsicologoID(int psicologoID) {
		PsicologoID = psicologoID;
	}

	public Date getFecha() {
		return fecha;
	}



	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}



	public Date getHoraEntrada() {
		return horaEntrada;
	}



	public void setHoraEntrada(Date horaEntrada) {
		this.horaEntrada = horaEntrada;
	}



	public Date getHoraSalida() {
		return horaSalida;
	}



	public void setHoraSalida(Date horaSalida) {
		this.horaSalida = horaSalida;
	}



	public void finalize() throws Throwable {

	}

}