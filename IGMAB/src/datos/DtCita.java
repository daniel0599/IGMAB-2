package datos;

import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
//import java.util.ArrayList;
import java.util.Date;

import entidades.Cita;
//import entidades.Parentesco;

public class DtCita {

	private static DtCita dtC = new DtCita(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();

		
	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Cita WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtCita: " + e.getMessage());
		}
		return rs;
	}


	public boolean guardarCita(Cita c) {
		boolean guardado = false;
		try {
			DateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
			DateFormat shf = new SimpleDateFormat("HH:mm");
			
			Date date = new Date();
			
			
			dtC.cargarDatos();
			
			 rs.moveToInsertRow();
			 rs.updateString("Fechacreacion", fecha.format(date));
			 rs.updateString("Fecha", fecha.format(c.getFecha()));
			 rs.updateString("Hora", shf.format(c.getHora()));
			 rs.updateInt("PacienteID", c.getPacienteId());
			 rs.updateInt("Numsesion", c.getNumSesion());
			 rs.updateInt("Usuariocreacion", 1);
			 rs.insertRow();
			 rs.moveToCurrentRow();
			 
			 guardado=true;

		} catch (Exception e) {
			System.err.println("Error al guardar la cita " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	//////// Metodo para eliminar lógicamente/////
	public boolean eliminarCita(int citaId) {
		boolean eliminado = false;
		try {
			dtC.cargarDatos();
			
			DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd");
			Date date=new Date();
			
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("CitaId") == citaId) {
					rs.updateInt("Eliminado", 1);
					rs.updateString("Fechaeliminacion", fechaCompleta.format(date.getTime()));
					rs.updateRow();
					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar la cita " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	//////// M�todo para actualizar/////
	public boolean actualizarCita(Cita c) {
		boolean actualizado = false;
		try {
			dtC.cargarDatos();
			
			DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd");
			DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			DateFormat shf = new SimpleDateFormat("HH:mm");
			Date date=new Date();
			
			
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("CitaId") == c.getCitaId()) {
					 rs.updateString("Fecha", fecha.format(c.getFecha()));
					 rs.updateString("Fechamodificacion", fechaCompleta.format(date));
					 rs.updateString("Hora", shf.format(c.getHora()));
					 rs.updateInt("Numsesion", c.getNumSesion());
					rs.updateRow();
					actualizado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar la cita " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
////////M�todo para actualizar/////
public boolean actualizarAsistencia (int citaId) {
	boolean actualizado = false;
	try {
		dtC.cargarDatos();
		
		DateFormat fechaCompleta = new SimpleDateFormat("yyyy/MM/dd");
//		DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
//		DateFormat shf = new SimpleDateFormat("HH:mm");
		Date date=new Date();
		
		
		rs.beforeFirst();
		while (rs.next()) {
			if (rs.getInt("CitaId") == citaId) {
				 rs.updateString("Fechamodificacion", fechaCompleta.format(date));
				 rs.updateInt("Asistencia", citaId);
			
				rs.updateRow();
				actualizado = true;
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al actualizar la cita " + e.getMessage());
		e.printStackTrace();
	}
	return actualizado;
}

}
