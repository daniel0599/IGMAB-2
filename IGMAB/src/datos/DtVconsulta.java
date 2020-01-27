package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DtVconsulta {
	private static DtVconsulta dtvc = new DtVconsulta();
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarVistaSoloPsicologo(int psicologoId){
		PreparedStatement s;
		try {
			s = con.prepareStatement("SELECT * FROM igmab.vconsulta WHERE PsicologoID = ?;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			s.setInt(1, psicologoId);
			rs = s.executeQuery();
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtVconsulta: " + e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarVista(){
		Statement s;
		String sql = ("SELECT * FROM igmab.vconsulta WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtVconsulta: " + e.getMessage());
		}
		return rs;
	}

}
