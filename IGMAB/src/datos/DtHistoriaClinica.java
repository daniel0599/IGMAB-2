package datos;
import java.sql.*;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;

import entidades.HistoriaClinica;

public class DtHistoriaClinica {
	private static DtHistoriaClinica dtHistoriaClinica = new DtHistoriaClinica();
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("Select * from igmab.historiaclinica");
		try {
			s= con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPariente: " + e.getMessage());
		}
		return rs;
	}
	

	
	//Metodo para guardar//
	public boolean guardarHistoriaClinica(HistoriaClinica hc) {
		boolean guardado = false;
		try {
			dtHistoriaClinica.cargarDatos();
			
			rs.moveToInsertRow();
			rs.updateString("Motivoconsulta", hc.getMotivoConsulta());
			rs.updateString("Padecimientoactual", hc.getPadecimientoActual());
			rs.updateString("Expectativa", hc.getExpectativa());
			rs.updateString("Antecedentespatologicosf", hc.getAntecedentesPatologicosF());
			rs.updateString("Antecedentespersonalesnp", hc.getAntecedentesPersonalesNP());
			rs.updateString("Antecedentespatologicosp", hc.getAntecedentesPatologicosP());
			rs.updateString("Antecedentespatologicosf", hc.getAntecedentesPatologicosF());
			rs.updateString("Relacionnucleof", hc.getRelacionNucleoF());
			rs.updateString("Areaescolar", hc.getAreaEscolar());
			rs.updateString("Desarrollosocial", hc.getDesarrolloSocial());
			rs.updateString("Desarrollolaboral", hc.getDesarrolloLaboral());
			rs.updateString("Desarrollosexual", hc.getDesarrolloSexual());
			rs.updateString("Desarrolloconyugal", hc.getDesarrolloConyugal());
			rs.updateString("Desarrolloespiritual", hc.getDesarrolloEspiritual());
			rs.updateString("Aspectoconductageneral", hc.getAspectoConductaGeneral());
			rs.updateString("Algomasagregar", hc.getAlgoMasAgregar());
			rs.updateString("Impresiondiagnostica", hc.getImpresionDiagnostica());
			rs.updateString("Padecimientoh_f", hc.getPadecimientoH_F());
			rs.updateInt("PacienteID", hc.getPacienteId());
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
			
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar la Historia clinica " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
		
	//Metodo para actualizar
	public boolean actualizarHistoriaClinica(HistoriaClinica hc){
		boolean actualizado = false;
		try {
			dtHistoriaClinica.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("HistoriaclinicaID")==hc.getHistoriaClinicaId()){
					rs.updateString("Motivoconsulta", hc.getMotivoConsulta());
					rs.updateString("Padecimientoactual", hc.getPadecimientoActual());
					rs.updateString("Expectativa", hc.getExpectativa());
					rs.updateString("Antecedentespatologicosf", hc.getAntecedentesPatologicosF());
					rs.updateString("Antecedentespersonalesnp", hc.getAntecedentesPersonalesNP());
					rs.updateString("Antecedentespatologicosp", hc.getAntecedentesPatologicosP());
					rs.updateString("Antecedentespatologicosf", hc.getAntecedentesPatologicosF());
					rs.updateString("Relacionnucleof", hc.getRelacionNucleoF());
					rs.updateString("Areaescolar", hc.getAreaEscolar());
					rs.updateString("Desarrollosocial", hc.getDesarrolloSocial());
					rs.updateString("Desarrollolaboral", hc.getDesarrolloLaboral());
					rs.updateString("Desarrollosexual", hc.getDesarrolloSexual());
					rs.updateString("Desarrolloconyugal", hc.getDesarrolloConyugal());
					rs.updateString("Desarrolloespiritual", hc.getDesarrolloEspiritual());
					rs.updateString("Aspectoconductageneral", hc.getAspectoConductaGeneral());
					rs.updateString("Algomasagregar", hc.getAlgoMasAgregar());
					rs.updateString("Impresiondiagnostica", hc.getImpresionDiagnostica());
					rs.updateString("Padecimientoh_f", hc.getPadecimientoH_F());
					rs.updateInt("PacienteID", hc.getPacienteId());
					rs.updateRow();
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar la historia clinica " + e.getMessage());
			e.printStackTrace();
		}
		
		return actualizado;
	}
	
	
}
