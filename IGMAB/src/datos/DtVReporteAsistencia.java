package datos;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
public class DtVReporteAsistencia {
	//private static DtVReporteAsistencia dtrasist = new DtVReporteAsistencia();
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc =PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos(String psicologoId, String fechaOrigen, String fechaCierre) {
		try {
			CallableStatement asistencia = con.prepareCall("{CALL GenerarReporteAsistencia(?,?,?)}");
			asistencia.setString(1, psicologoId);
			asistencia.setString(2, fechaOrigen);
			asistencia.setString(3, fechaCierre);
			rs = asistencia.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtVReporteAsistencia: " + e.getMessage());
		}
		return rs;
	}
}
