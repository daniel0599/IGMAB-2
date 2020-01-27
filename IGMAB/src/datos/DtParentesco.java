package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import entidades.Parentesco;

public class DtParentesco {

	private static DtParentesco dtpar = new DtParentesco(); // Instanciando la
															// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Parentesco WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtParentesco: " + e.getMessage());
		}
		return rs;
	}

	//////// M�todo para guardar/////
	public boolean guardarParentesco(Parentesco p) {
		boolean guardado = false;
		try {
			dtpar.cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Parentesco", p.getParentesco());
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el parentesco " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	//////// Método para eliminar lógicamente/////
	public boolean eliminarParentesco(int parentescoId) {
		boolean eliminado = false;
		try {
			dtpar.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("ParentescoID")==parentescoId){
					rs.updateInt("Eliminado", 1);
					rs.updateRow();
					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar el parentesco " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	//////// Método para actualizar/////
	public boolean actualizarParentesco(Parentesco p) {
		boolean actualizado = false;
		try {
			dtpar.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("ParentescoID")==p.getParentescoID()){
					rs.updateString("Parentesco", p.getParentesco());
					rs.updateRow();
					actualizado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar el parentesco " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	public boolean validarParentescoRepetido(String parentesco){
		try {
			dtpar.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getString("Parentesco").equalsIgnoreCase(parentesco)){
					return false;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al validar el parentesco " + e.getMessage());
			e.printStackTrace();
		}
		return true;
	}

}
