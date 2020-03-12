package entidades;
import java.util.Date;


/**
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class Paciente {
	
	private int pacienteID;
	private int escolaridadID;
	private int estudianteUCA;



	private int eliminado;

	/**
	 * Primer apellido del paciente.
	 */
	private String apellido1;
	/**
	 * Segundo apellido del paciente.
	 */
	private String apellido2;
	/**
	 * Con qui�n vive el paciente. Las opciones son: �Solo/a�, �Padres�, �C�nyuge�,
	 * �Otros� (especificar).
	 */
	private String conQuienVive;
	/**
	 * Celular del individuo.
	 */
	private String celular;
	/**
	 * Direcci�n domiciliar del individuo.
	 */
	private String direccion;
	/**
	 * Edad del paciente.
	 */
	private String edad;
	/**
	 * Empleo/trabajo del paciente.
	 */
	private String empleo;
	/**
	 * Grado acad�mico de la persona. Especificar carrera y universidad.
	 */
	private String escolaridad;
	/**
	 * Estado civil del paciente. 1 para casado, 0 para soltero.
	 */
	private int estadoCivil;
	/**
	 * El c�digo de expediente identificador del paciente, compuesto por sus iniciales
	 * (primero las de sus apellidos y luego las de sus nombres) seguido de la fecha
	 * de ingreso en el formato ddMMYY. Ejemplo: TVMA220898
	 */
	private String expediente;
	/**
	 * Fecha en la que se crea el registro.
	 */
	private Date fechaCreacion;
	/**
	 * Fecha en la que se elimina el registro.
	 */
	private Date fechaEliminacion;
	/**
	 * Fecha en la que se modifica el registro.
	 */
	private Date fechaModificacion;
	/**
	 * Fecha de nacimiento del paciente. En formato dd-MM-YYYY
	 */
	private Date fechaNac;
	/**
	 * Si el paciente ha estado internado alguna vez por problemas 
	 */
	private int internado;
	/**
	 * En caso de haber estado internado, este campo almacena cu�ndo, d�nde y por qu�
	 * fue internado.
	 */
	private String internadoAfirmativo;
	/**
	 * Lugar donde trabaja el paciente.
	 */
	private String lugarTrabajo;
	/**
	 * Primer nombre del paciente. M�ximo 30 caracteres.
	 */
	private String nombre1;
	/**
	 * Segundo nombre del paciente. M�ximo 30 caracteres.
	 */
	private String nombre2;
	/**
	 * Sexo del paciente. 1 para hombre, 0 para mujer.
	 */
	private String salario;
	/**
	 * Sexo del paciente. 1 para hombre, 0 para mujer.
	 */
	private int sexo;
	/**
	 * Si el paciente ha estado en terapia alguna otra vez o ha recibido alg�n tipo de
	 * asistencia profesional para sus problemas. 1 para s�, 0 para no.
	 */
	private int terapia;
	/**
	 * El tipo de empleo que desarrolla en el momento.
	 */
	private String tipoEmpleo;
	
	private String religion;
	private String motivoconsulta;
	private String crianzaAnios;
	private String relacionProgenitores;
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
	public HistoriaClinica m_HistoriaClinica;
	private Cita m_Cita;
	private Consulta m_Consulta;
	private Pariente m_Pariente;
	public Respuesta m_Respuesta;


	public Paciente(){

	}
	

	public int getEliminado() {
		return eliminado;
	}


	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}


	public int getPacienteID() {
		return pacienteID;
	}


    public int getEstudianteUCA() {
        return estudianteUCA;
    }

    public void setEstudianteUCA(int estudianteUCA) {
        this.estudianteUCA = estudianteUCA;
    }

	public void setPacienteID(int pacienteID) {
		this.pacienteID = pacienteID;
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



	public String getConQuienVive() {
		return conQuienVive;
	}



	public void setConQuienVive(String conQuienVive) {
		this.conQuienVive = conQuienVive;
	}


	public String getCelular() {
		return celular;
	}


	public void setCelular(String celular) {
		this.celular = celular;
	}


	public String getDireccion() {
		return direccion;
	}



	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}



	public String getEdad() {
		return edad;
	}



	public void setEdad(String edad) {
		this.edad = edad;
	}



	public String getEmpleo() {
		return empleo;
	}



	public void setEmpleo(String empleo) {
		this.empleo = empleo;
	}



	public String getEscolaridad() {
		return escolaridad;
	}



	public void setEscolaridad(String escolaridad) {
		this.escolaridad = escolaridad;
	}



	public int getEstadoCivil() {
		return estadoCivil;
	}



	public void setEstadoCivil(int estadoCivil) {
		this.estadoCivil = estadoCivil;
	}



	public String getExpediente() {
		return expediente;
	}



	public void setExpediente(String expediente) {
		this.expediente = expediente;
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



	public String getSalario() {
		return salario;
	}


	public void setSalario(String salario) {
		this.salario = salario;
	}


	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}



	public Date getFechaNac() {
		return fechaNac;
	}



	public void setFechaNac(Date fechaNac) {
		this.fechaNac = fechaNac;
	}



	public int getInternado() {
		return internado;
	}



	public void setInternado(int internado) {
		this.internado = internado;
	}



	public String getInternadoAfirmativo() {
		return internadoAfirmativo;
	}



	public void setInternadoAfirmativo(String internadoAfirmativo) {
		this.internadoAfirmativo = internadoAfirmativo;
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



	public int getSexo() {
		return sexo;
	}



	public void setSexo(int sexo) {
		this.sexo = sexo;
	}



	public int getTerapia() {
		return terapia;
	}



	public void setTerapia(int terapia) {
		this.terapia = terapia;
	}



	public String getTipoEmpleo() {
		return tipoEmpleo;
	}



	public void setTipoEmpleo(String tipoEmpleo) {
		this.tipoEmpleo = tipoEmpleo;
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



	public HistoriaClinica getM_HistoriaClinica() {
		return m_HistoriaClinica;
	}



	public void setM_HistoriaClinica(HistoriaClinica m_HistoriaClinica) {
		this.m_HistoriaClinica = m_HistoriaClinica;
	}



	public Cita getM_Cita() {
		return m_Cita;
	}



	public void setM_Cita(Cita m_Cita) {
		this.m_Cita = m_Cita;
	}



	public Consulta getM_Consulta() {
		return m_Consulta;
	}



	public void setM_Consulta(Consulta m_Consulta) {
		this.m_Consulta = m_Consulta;
	}



	public Pariente getM_Pariente() {
		return m_Pariente;
	}



	public void setM_Pariente(Pariente m_Pariente) {
		this.m_Pariente = m_Pariente;
	}



	public Respuesta getM_Respuesta() {
		return m_Respuesta;
	}



	public void setM_Respuesta(Respuesta m_Respuesta) {
		this.m_Respuesta = m_Respuesta;
	}



	
	
	public int getEscolaridadID() {
		return escolaridadID;
	}


	public void setEscolaridadID(int escolaridadID) {
		this.escolaridadID = escolaridadID;
	}


	public void finalize() throws Throwable {

	}


	public String getRelacionProgenitores() {
		return relacionProgenitores;
	}


	public void setRelacionProgenitores(String relacionProgenitores) {
		this.relacionProgenitores = relacionProgenitores;
	}


	public String getCrianzaAnios() {
		return crianzaAnios;
	}


	public void setCrianzaAnios(String crianzaAnios) {
		this.crianzaAnios = crianzaAnios;
	}


	public String getMotivoconsulta() {
		return motivoconsulta;
	}


	public void setMotivoconsulta(String motivoconsulta) {
		this.motivoconsulta = motivoconsulta;
	}


	public String getReligion() {
		return religion;
	}


	public void setReligion(String religion) {
		this.religion = religion;
	}

}