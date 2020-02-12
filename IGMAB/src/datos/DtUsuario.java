package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
//import java.util.ArrayList;
import java.util.Date;


import entidades.Usuario;

public class DtUsuario {
	//private static DtUsuario dtu = new DtUsuario(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();



	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Usuario WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtUsuario: " + e.getMessage());
		}
		return rs;
	}
	
	////////////////////////// METODO PARA GUARDAR EL
	////////////////////////// Usuario/////////////////////////////
	public boolean guardarUsuario(Usuario u) {
		boolean guardado = false;

		try {

			DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date date = new Date();
			
			cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Usuario", u.getUsuario());
			rs.updateString("Contrasena", u.getContrasena());
			rs.updateInt("Usuariocreacion", u.getUsuarioCreacion());
			rs.updateString("Fechacreacion", fechaCompleta.format(date));
			rs.insertRow();
			rs.moveToCurrentRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
			

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error al guardar el usuario " + e.getMessage());
		}

		return guardado;
	}
	
////////M�todo para eliminar l�gicamente/////
public boolean eliminarUsuario(int usuarioID) {
	boolean eliminado = false;
	try {
		DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		
		cargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("UsuarioID")==usuarioID){
				rs.updateInt("Eliminado", 1);
				//rs.updateInt("Usuarioeliminacion", u.getUsuarioEliminacion());
				rs.updateString("Fechaeliminacion", fechaCompleta.format(date));
				rs.updateRow();
				rs.close();
				rs = null;
				Runtime garbage = Runtime.getRuntime();
			    garbage.gc();
				eliminado = true;
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al eliminar el usuario " + e.getMessage());
		e.printStackTrace();
	}
	return eliminado;
}

//////// M�todo para actualizar/////
public boolean actualizarUsuario(Usuario u) {
	boolean actualizado = false;
	try {
	//	DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	//	Date date = new Date();
		
		cargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("UsuarioID")==u.getUsuarioID()){
				rs.updateString("Contrasena", u.getContrasena());
				//rs.updateInt("Usuariomodificacion", u.getUsuarioModificacion());
				//rs.updateString("Fechamodificacion", fechaCompleta.format(date));
				rs.updateRow();
				rs.close();
				rs = null;
				Runtime garbage = Runtime.getRuntime();
			    garbage.gc();
				actualizado = true;
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al actualizar el usuario " + e.getMessage());
		e.printStackTrace();
	}
	return actualizado;
}

	public Usuario verificarUsuario(Usuario us){
		PreparedStatement s;         
		try
		{
			s = con.prepareStatement("select * from igmab.usuario where Usuario=? and Contrasena=?;",
					ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			s.setString(1, us.getUsuario());
			s.setString(2, us.getContrasena());
			rs = s.executeQuery();
			if(rs.next())
			{
				us.setUsuarioID(rs.getInt("UsuarioID"));
				us.setUsuario(rs.getString("Usuario"));
				us.setContrasena(rs.getString("Contrasena"));
			}
	}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Dt_Usuario: "+e.getMessage());
		}
		
		return us;
	}
	
	public boolean validarUsuarioRepetido(String usuario){
		boolean repetido = true;
		try {
			cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getString("Usuario").equalsIgnoreCase(usuario)){
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					repetido = false;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al validar el usuario " + e.getMessage());
			e.printStackTrace();
		}
		return repetido;
	}


}
