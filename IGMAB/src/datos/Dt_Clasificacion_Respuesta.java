/**
 * 
 */
package datos;

import java.sql.*;

/**
 * @author isi7
 *
 */
public class Dt_Clasificacion_Respuesta {
	
	private static Dt_Clasificacion_Respuesta dtcr = new Dt_Clasificacion_Respuesta(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Clasificacion;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTClasificaion: " + e.getMessage());
		}
		return rs;
	}
	
	public int calcularClasificaciones(){
		  int contador=0;
		  try{
		  dtcr.cargarDatos();
		  rs.beforeFirst();
		  while(rs.next()){
			 
			  contador++;
		  }
		  rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
		  return contador;
			
		}catch(Exception e){
			System.err.println("Datos: Error al calcular el numero de clasificaciones" + e.getMessage());
			e.printStackTrace();
		}
		return contador;
		  }


}
