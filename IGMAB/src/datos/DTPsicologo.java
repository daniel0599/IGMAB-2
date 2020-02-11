package datos;

import entidades.Psicologo;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class DTPsicologo {

	private static DTPsicologo dtpsi = new DTPsicologo(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Psicologo WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTPsicologo: " + e.getMessage());
		}
		return rs;
	}

	//////// M�todo para guardar/////
	public boolean guardarPsicologo(Psicologo p) {
		boolean guardado = false;
		try {
			dtpsi.cargarDatos();
			System.out.println("entro al guardar");
			rs.moveToInsertRow();
			System.out.println("se posiciono en el result set");
			System.out.println("LOS DATOS: "+p.getNombre1()+" "+p.getNombre2()+" "+p.getApellido1()+" "+p.getApellido2()+".."+"LA FECHA"+p.getFechaCreacion()+"...CARNET: "+p.getCarnet());
			System.out.println("los datos estan llegando a su destino");
			rs.updateString("Apellido1", p.getApellido1());
			rs.updateString("Apellido2", p.getApellido2());
			rs.updateString("Carnet", p.getCarnet());
			rs.updateString("Fechacreacion", fecha.format(p.getFechaCreacion()));
			rs.updateString("Nombre1", p.getNombre1());
			rs.updateString("Nombre2", p.getNombre2());
			rs.updateString("Tutor", p.getTutor());
			rs.updateInt("Usuariocreacion", p.getUsuarioCreacion());
			rs.updateInt("UsuarioID", p.getUsuarioID());
		//	System.out.println("LOS DATOS: "+p.getNombre1()+" "+p.getNombre2()+" "+p.getApellido1()+" "+p.getApellido2()+".."+"LA FECHA"+p.getFechaCreacion()+"...CARNET: "+p.getCarnet());
			rs.insertRow();
			rs.moveToCurrentRow();
		
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el psicologo " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	// METODO PARA ELiminar Psicologo
	public boolean eliminarPsicologo(int psicologoID) {
		boolean eliminado = false;
		try {
			dtpsi.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PsicologoID") == psicologoID) {
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
			System.out.println("Datos : Error al elimnar el psicologo" + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	// Metodo para modificar un psicologo

	public boolean actualizarPsicologo(Psicologo p) {
		boolean actualizado = false;
		try {
			dtpsi.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PsicologoID") == p.getPsicologoID()) {
					rs.updateString("Carnet", p.getCarnet());
					rs.updateString("Nombre1", p.getNombre1());
					rs.updateString("Nombre2", p.getNombre2());
					rs.updateString("Apellido1", p.getApellido1());
					rs.updateString("Apellido2", p.getApellido2());
					rs.updateString("Tutor", p.getTutor());
					rs.updateString("Fechamodificacion", fecha.format(p.getFechaModificacion()));
					rs.updateInt("Usuariomodificacion", p.getUsuarioModificacion());
					rs.updateInt("UsuarioID", p.getUsuarioID());
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
				    actualizado = true;
				}
			}

		} catch (Exception e) {

			System.err.println("Datos: Error al actualizar el psiologo" + e.getMessage());
			e.printStackTrace();
		}

		return actualizado;
	}
	
	public boolean validarCarnetRepetido(String carnet){
		try {
			dtpsi.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getString("Carnet").equalsIgnoreCase(carnet)){
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					return false;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al validar el psicólogo: " + e.getMessage());
			e.printStackTrace();
		}
		return true;
	}
}