package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DtVParienteParentesco {
	private static DtVParienteParentesco dtpp = new DtVParienteParentesco();
	private static ResultSet rs; // Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarVista(){
		Statement s;
		String sql = ("SELECT * FROM igmab.pariente_parentesco WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtVRespuestaCatTituloPreg: " + e.getMessage());
		}
		return rs;
		
	}
}
