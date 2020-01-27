package entidades;


/**
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:17 AM
 */
public class HistoriaClinica {

	
	private int historiaClinicaId;
	private int pacienteId;
	
	
	/**
	 * Algún detalle que se haya escapado durante la solicitud de la información.
	 */
	private String algoMasAgregar;
	/**
	 * Son las enfermedades padecidas en la familia ya sean fisicas o psicologicas o
	 * si consume algún tipo de droga.
	 */
	private String antecedentesPatologicosF;
	/**
	 * Se habla sobre los padecimientos o enfermedades que el paciente ha sufrido o
	 * sufre, hospitalizaciones, crisis convulsivas u otros.
	 */
	private String antecedentesPatologicosP;
	/**
	 * Es una descripción de la zona de confort del paciente, dónde vive y se
	 * desarrolla en la sociedad, sus pasatiempos o sueños.
	 */
	private String antecedentesPersonalesNP;
	/**
	 * Se especifica o se aborda la vida educativa/escolar del paciente atendido.
	 */
	private String areaEscolar;
	private String aspectoConductaGeneral;
	/**
	 * Todo lo relacionado con su pareja de vida(aborto,cantidad de hijos, etc).
	 */
	private String desarrolloConyugal;
	/**
	 * Todo lo que esté relacionado con la vida espiritual del paciente. 
	 */
	private String desarrolloEspiritual;
	/**
	 * Todo lo relacionado con su mundo laboral(trabajos, cuánto ganaba, cargos, etc)
	 */
	private String desarrolloLaboral;
	/**
	 * Descripción la vida sexual del paciente desde que es niño hasta su edad actual.
	 */
	private String desarrolloSexual;
	/**
	 * Se aborda el tema comunitario del paciente, es decir la relación interpersonal
	 * con sus amigos y compañeros de clase, etc.
	 */
	private String desarrolloSocial;
	/**
	 * Es como el paciente espera que el centro le ayude con su padecimiento.
	 */
	private String expectativa;
	private String impresionDiagnostica;
	/**
	 * Describe el motivo de la consulta del día.
	 */
	private String motivoConsulta;
	/**
	 * Describe el padecimiento con el que paciente se presenta.
	 */
	private String padecimientoActual;
	/**
	 * Descripción breve de lo que el paciente ha ingerido, sufrido u otras cosas.
	 */
	private String padecimientoH_F;
	/**
	 * Describe la convivencia que tiene el paciente con su entorno familiar (hermanos,
	 * madre, padre, etc) 
	 */
	private String relacionNucleoF;

	public HistoriaClinica(){

	}
	
	
	

	public int getHistoriaClinicaId() {
		return historiaClinicaId;
	}


	public void setHistoriaClinicaId(int historiaClinicaId) {
		this.historiaClinicaId = historiaClinicaId;
	}


	public int getPacienteId() {
		return pacienteId;
	}


	public void setPacienteId(int pacienteId) {
		this.pacienteId = pacienteId;
	}

	public String getAlgoMasAgregar() {
		return algoMasAgregar;
	}


	public void setAlgoMasAgregar(String algoMasAgregar) {
		this.algoMasAgregar = algoMasAgregar;
	}


	public String getAntecedentesPatologicosF() {
		return antecedentesPatologicosF;
	}


	public void setAntecedentesPatologicosF(String antecedentesPatologicosF) {
		this.antecedentesPatologicosF = antecedentesPatologicosF;
	}


	public String getAntecedentesPatologicosP() {
		return antecedentesPatologicosP;
	}


	public void setAntecedentesPatologicosP(String antecedentesPatologicosP) {
		this.antecedentesPatologicosP = antecedentesPatologicosP;
	}


	public String getAntecedentesPersonalesNP() {
		return antecedentesPersonalesNP;
	}


	public void setAntecedentesPersonalesNP(String antecedentesPersonalesNP) {
		this.antecedentesPersonalesNP = antecedentesPersonalesNP;
	}


	public String getAreaEscolar() {
		return areaEscolar;
	}


	public void setAreaEscolar(String areaEscolar) {
		this.areaEscolar = areaEscolar;
	}


	public String getAspectoConductaGeneral() {
		return aspectoConductaGeneral;
	}


	public void setAspectoConductaGeneral(String aspectoConductaGeneral) {
		this.aspectoConductaGeneral = aspectoConductaGeneral;
	}


	public String getDesarrolloConyugal() {
		return desarrolloConyugal;
	}


	public void setDesarrolloConyugal(String desarrolloConyugal) {
		this.desarrolloConyugal = desarrolloConyugal;
	}


	public String getDesarrolloEspiritual() {
		return desarrolloEspiritual;
	}


	public void setDesarrolloEspiritual(String desarrolloEspiritual) {
		this.desarrolloEspiritual = desarrolloEspiritual;
	}


	public String getDesarrolloLaboral() {
		return desarrolloLaboral;
	}


	public void setDesarrolloLaboral(String desarrolloLaboral) {
		this.desarrolloLaboral = desarrolloLaboral;
	}


	public String getDesarrolloSexual() {
		return desarrolloSexual;
	}


	public void setDesarrolloSexual(String desarrolloSexual) {
		this.desarrolloSexual = desarrolloSexual;
	}


	public String getDesarrolloSocial() {
		return desarrolloSocial;
	}


	public void setDesarrolloSocial(String desarrolloSocial) {
		this.desarrolloSocial = desarrolloSocial;
	}


	public String getExpectativa() {
		return expectativa;
	}


	public void setExpectativa(String expectativa) {
		this.expectativa = expectativa;
	}


	public String getImpresionDiagnostica() {
		return impresionDiagnostica;
	}


	public void setImpresionDiagnostica(String impresionDiagnostica) {
		this.impresionDiagnostica = impresionDiagnostica;
	}


	public String getMotivoConsulta() {
		return motivoConsulta;
	}


	public void setMotivoConsulta(String motivoConsulta) {
		this.motivoConsulta = motivoConsulta;
	}


	public String getPadecimientoActual() {
		return padecimientoActual;
	}


	public void setPadecimientoActual(String padecimientoActual) {
		this.padecimientoActual = padecimientoActual;
	}


	public String getPadecimientoH_F() {
		return padecimientoH_F;
	}


	public void setPadecimientoH_F(String padecimientoH_F) {
		this.padecimientoH_F = padecimientoH_F;
	}


	public String getRelacionNucleoF() {
		return relacionNucleoF;
	}


	public void setRelacionNucleoF(String relacionNucleoF) {
		this.relacionNucleoF = relacionNucleoF;
	}


	public void finalize() throws Throwable {

	}

}