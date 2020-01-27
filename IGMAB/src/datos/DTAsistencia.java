package datos;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import entidades.Asistencia;
import entidades.Usuario;


public class DTAsistencia {
	private static DTAsistencia dtas = new DTAsistencia(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Asistencia WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTAsistencia: " + e.getMessage());
		}
		return rs;
	}

	public boolean comprobarAsistencia(int u){
		boolean realizado=false;
		int psicologoID=obtenerPsicologoID(u);
		
		SimpleDateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
		Date d= new Date();					
					
		
		Statement s;
		String sql = ("SELECT horaEntrada FROM igmab.Asistencia WHERE PsicologoID = " + psicologoID +" and Fecha='"+fecha.format(d)+"';");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
			if(rs.next()){
				System.out.println("Usuario ya logan");
			}
			else{
				guardarAsistencia(psicologoID);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTAsistencia: " + e.getMessage());
		}
		
		
		
		return realizado;
	}
	
	
	public int obtenerPsicologoID(int u){
		Statement s;
		int id=0;
		String sql = ("SELECT PsicologoID FROM igmab.Psicologo WHERE UsuarioID = " +u+";");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
			if(rs.next()){
				id=rs.getInt("PsicologoID");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTAsistencia: " + e.getMessage());
		}
		
		return id;
	}
	
	//////// M�todo para guardar/////
	public boolean guardarAsistencia(int psicologoId) {
		boolean guardado = false;
		try {
			SimpleDateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			SimpleDateFormat hora = new SimpleDateFormat("HH:mm:ss");
			Date d= new Date();
			Date h=new Date();						
						
			dtas.cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Fecha", fecha.format(d));
			rs.updateString("Horaentrada", hora.format((h.getTime())));
			rs.updateInt("PsicologoID", psicologoId);
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar la asistencia " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	//////// M�todo para actualizar/////
	public boolean actualizarAsistencia(int psicologoId) {
		boolean actualizado = false;
		try {
			dtas.cargarDatos();
			rs.beforeFirst();
			SimpleDateFormat hora = new SimpleDateFormat("HH:mm:ss");
			SimpleDateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
			Date d= new Date();		
			
			while (rs.next()) {
					if (rs.getInt("PsicologoID") == psicologoId && (rs.getString("Fecha").compareTo(fecha.format(d)))==0){					
						rs.updateString("Horasalida", hora.format(d.getTime()));
						rs.updateRow();
						actualizado = true;
					}
				
				
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar la asistencia " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}

}
