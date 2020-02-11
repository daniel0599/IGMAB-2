package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import entidades.Opcion;

public class DtOpcion {

	private static DtOpcion dtop = new DtOpcion();//Instanciando la clase 
	
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection cn = PoolConexion.getConnection();

	
	public ResultSet cargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM igmab.opcion WHERE Eliminado = 0;");
		try{
			s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} 
		catch(Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtOpcion" + e.getMessage());
		}
		return rs;
		
	}
	////////////// Metodo para guardar ///////
	public boolean guardarOpcion (Opcion op) {
		boolean guardado = false;
		try {
			dtop.cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Opcion", op.getOpcion());
			rs.insertRow();
			rs.moveToCurrentRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		}
		catch (Exception e) {
			System.err.println("Datos: Error al guardar la Opcion" + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	//////////////////// M�todo para eliminar L�gicamente ///////////////////
	public boolean eliminarOpcion (int opcionId) {
		boolean eliminado = false;
		try {
			dtop.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("OpcionId")==opcionId){
					rs.updateInt("Eliminado", 1);
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					eliminado=true;
				}
			}
		}
		catch(Exception e) {
			System.err.println("Datos: Error al eliminar la Opcion" + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	
	
	///////////////////////////// metodo para actualizar ///////////////////////////////////
	public boolean actualizarOpcion(Opcion op){
		boolean actualizado = false;
		try{
			dtop.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("opcionId")==op.getOpcionId()){
					rs.updateString("opcion", op.getOpcion());
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					actualizado=true;
				}
			}
		}
		catch(Exception e){
			System.err.println("Datos: Error al actualizar la Opcion " + e.getMessage());;
			e.printStackTrace();
		}
		return actualizado;
	}
	
	
}
