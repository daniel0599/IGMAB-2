package datos;

//import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;



public class DtVHistoriaClinicaPaciente {
//	private static DtVHistoriaClinicaPaciente dtv = new DtVHistoriaClinicaPaciente();
	private static ResultSet rs; // Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();
	
	public ResultSet cargarVista() {
		Statement s;
		String sql = ("SELECT * FROM igmab.historiaclinica_paciente");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs= s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtVHistoriaClinicaPaciente: " + e.getMessage());
		}
		return rs;
	}
	
	

	
	public ResultSet cargarVistaApsicologo(int psicologoID) {
		ResultSet rsn = null;
		PreparedStatement s;
		
		try {
			s = con.prepareStatement("SELECT * FROM igmab.historiaclinica_paciente pac INNER JOIN Consulta con ON con.PacienteID=pac.PacienteID INNER JOIN Psicologo psi ON psi.PsicologoID=con.PsicologoID where psi.PsicologoID=?");
			s.setInt(1, psicologoID);
			rsn= s.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtVHistoriaClinicaPaciente: " + e.getMessage());
		}
		return rsn;
	}
}
