package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entidades.Rol;

public class DtRol {

	//private static DtRol dtrol = new DtRol(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.rol WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtRol: " + e.getMessage());
		}
		return rs;
	}

	//////// M�todo para guardar/////
	public boolean guardarRol(Rol rl) {
		boolean guardado = false;
		try {
			cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Nombre", rl.getNombre());
			rs.insertRow();
			rs.moveToCurrentRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el rol " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	//////// M�todo para eliminar l�gicamente/////
	public boolean eliminarRol(int rolId) {
		boolean eliminado = false;
		try {
			cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("RolID") == rolId) {
					rs.updateInt("Eliminado", 1);
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar el rol " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	//////// M�todo para actualizar/////
	public boolean actualizarRol(Rol r) {
		boolean actualizado = false;
		try {
			cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("RolID") == r.getRolId()) {
					rs.updateString("Nombre", r.getNombre());
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					actualizado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar el rol " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	public boolean validarRolRepetido(String rol){
		boolean repetido = true;
		try {
			cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getString("Nombre").equalsIgnoreCase(rol)){
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					repetido = false;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al validar el rol: " + e.getMessage());
			e.printStackTrace();
		}
		return repetido;
	}

}
