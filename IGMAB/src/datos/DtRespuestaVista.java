package datos;

import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;





public class DtRespuestaVista {
	private static DtRespuestaVista dtrespvi = new DtRespuestaVista(); // Instancia unica del DT
	
	private static ResultSet rs; //Resultset Globak
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();
	
	
	public ResultSet cargarDatos(int id){

		int idpaciente = id;
		Statement s;
		String sql = ("SELECT * FROM igmab.Respuestavista_vista where PacienteID = "+idpaciente+";");
		
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);

		}
		catch(Exception e){
			System.err.println("Datos: Error en DT Respuesta "+e.getMessage());
		}
		return rs;
	}
	
	public int numeroderespuestas(int pacienteID) {
		int numero=0;
		try {
			dtrespvi.cargarDatos(pacienteID);
			rs.beforeFirst();
			while(rs.next()){
				numero ++;
				System.out.println("respuesta numero"+numero);
				    
				
			}
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
		    return numero;
		} catch (Exception e) {
			System.err.println("Datos: Error al validar el numero de respuesta que estan en la DB " + e.getMessage());
			e.printStackTrace();
		}
		return numero;
	}
	
	
}
