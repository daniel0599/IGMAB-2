package datos;

//import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

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
	
}
