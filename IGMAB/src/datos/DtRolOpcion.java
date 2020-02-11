package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entidades.*;



public class DtRolOpcion {
	
	private static DtRolOpcion dtro = new DtRolOpcion(); // se instancia la clase
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarVista()
	{
		Statement s;
		String sql =  ("select * from igmab.vw_rol_opciones;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} 
		catch (Exception e) 
		{
			System.out.println("Error en DTRolUsuario " +e.getMessage());
			e.printStackTrace();
		}
		return rs;
	}
	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("select * from igmab.rol_opcion;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
		}
			catch(Exception e)
			{
				e.printStackTrace();
				System.out.println("Error en Dt_Rol: "+e.getMessage());
			}
		return rs;
	}
	
	public boolean guardarRolOpcion(RolOpcion tro){
		boolean guardado = false;
		try {
			dtro.cargarDatos();
			rs.moveToInsertRow();
			rs.updateInt("OpcionID", tro.getOpcionID());
			rs.updateInt("RolID", tro.getRolID());
			rs.insertRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado=true;
		}catch (Exception e) 
		{
			System.err.println("Error al guardar "+e.getMessage());
			e.printStackTrace();
		}
		
		return guardado;
	}
	
	public boolean eliminarRolOpcion(int rolopcionID) {
		boolean eliminado = false;
		try {
			dtro.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("rol_opcion") == rolopcionID) {
					rs.deleteRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					eliminado = true;
				}
			}
		}
		catch (Exception e) {
			System.err.println("Error al eliminar: " + e.getMessage());
			e.printStackTrace();
		}

		return eliminado;
	}

	
		
}



