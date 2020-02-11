package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entidades.Rol;
import entidades.RolUsuario;
import entidades.Usuario;

public class DtRolUsuario {

	//private static DtRolUsuario dtru = new DtRolUsuario();
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();



	public ResultSet cargarVista() {
		Statement s;
		String sql = ("SELECT * FROM igmab.vusuarios_roles;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			System.out.println("Error en DTRolUsuario " + e.getMessage());
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("select * from igmab.rol_usuario WHERE Eliminado=0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en Dt_Rol: " + e.getMessage());
		}
		return rs;
	}

	public boolean guardarUsuarioRol(RolUsuario tru) {
		boolean guardado = false;
		try {
			cargarDatos();
			rs.moveToInsertRow();
			rs.updateInt("RolID", tru.getRolID());
			rs.updateInt("UsuarioID", tru.getUsuarioID());
			rs.insertRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Error al guardar " + e.getMessage());
			e.printStackTrace();
		}

		return guardado;
	}

	public boolean eliminarUsuarioRol(int rolUsuarioID) {
		boolean eliminado = false;
		try {
			cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("Rol_Usuario") == rolUsuarioID) {
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

	public boolean verificarRol(Usuario us, Rol r) {
		boolean verificado = false;
		Statement s;
		String sql = ("select * from igmab.rol_usuario where UsuarioID=" + us.getUsuarioID() + " and RolID="
				+ r.getRolId() + ";");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			if (rs.next()) {
				verificado = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en Dt_Rol_Usuario: " + e.getMessage());
		}

		return verificado;

	}

}
