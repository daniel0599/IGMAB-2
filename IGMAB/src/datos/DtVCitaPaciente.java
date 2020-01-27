package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DtVCitaPaciente {
	private static DtVCitaPaciente dtv = new DtVCitaPaciente();
	private static ResultSet rs; // Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarVista(){
		Statement s;
		String sql = ("SELECT * FROM igmab.cita_paciente WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtVCitaPaciente: " + e.getMessage());
		}
		return rs;
		
	}

	public ResultSet cargarVistaHoy(){
		Statement s;
		String sql = ("SELECT * FROM igmab.cita_paciente WHERE Fecha = CURDATE();");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtVCitaPaciente: " + e.getMessage());
		}
		return rs;

	}


}
