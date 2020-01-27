package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DtInteroperabilidad {
	private static DtInteroperabilidad dtpar = new DtInteroperabilidad(); // Instanciando
																			// la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexionSql pc = PoolConexionSql.getInstance(); //
	Connection con = PoolConexionSql.getConnection();

	/* Static 'instance' method */
	public static DtInteroperabilidad getInstance() {
		return dtpar;
	}

	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM Empleado;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtInteroperabilidad: " + e.getMessage());
		}
		return rs;
	}

}
