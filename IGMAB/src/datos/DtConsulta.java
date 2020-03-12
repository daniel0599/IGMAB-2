package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.Date;



import entidades.Consulta;

public class DtConsulta {
	
	private static DtConsulta dtc = new DtConsulta();
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();

	public DtConsulta () {

	}
		
		public int obtenerPsicologoID(int usuarioID) {
			int psicologoId = 0;
			PreparedStatement s;
			try {
				s = con.prepareStatement("SELECT Psicologo.PsicologoID FROM Psicologo INNER JOIN Usuario ON Usuario.UsuarioID=Psicologo.UsuarioID WHERE Psicologo.UsuarioID = ?;");
				s.setInt(1, usuarioID);
				rs = s.executeQuery();
				rs.beforeFirst();
				rs.next();
				psicologoId = rs.getInt("PsicologoID");
			}
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
			}
			return psicologoId;
		}
		
		public int obtenerUsuarioID(int psicologoID) {
			int usuarioId = 0;
			PreparedStatement s;
			try {
				s = con.prepareStatement("SELECT Psicologo.UsuarioID FROM Psicologo  WHERE Psicologo.PsicologoID = ?;");
				s.setInt(1, psicologoID);
				rs = s.executeQuery();
				rs.beforeFirst();
				rs.next();
				usuarioId = rs.getInt("UsuarioID");
			}
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
			}
			return usuarioId;
		}
	
	
		public ResultSet cargarDatos(){
			Statement s;
			String sql = ("SELECT * FROM igmab.Consulta WHERE Eliminado = 0;");
			try {
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("Error en cargarDatos() de DtConsulta: " + e.getMessage());
			}
			return rs;
		}
////////Método para guardar/////
		
		public boolean guardarConsulta(Consulta c){
			boolean guardado = false;
			try {
				Date date = new Date();
				DateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
				dtc.cargarDatos();
				
				rs.moveToInsertRow();
				rs.updateInt("PacienteID", c.getpacienteId());
				rs.updateInt("PsicologoID", c.getpsicologoId());
	//			rs.updateInt("CitaID", 1);
				rs.updateString("Objetivo", c.getObjetivo());
				rs.updateString("Actividad", c.getActividad());
				rs.updateString("Descripcion", c.getDescripcion());
				rs.updateString("Fecha", fecha.format(date));
				rs.updateString("Fechacreacion", fecha.format(date));
				rs.updateInt("Eliminado", 0);
				rs.updateInt("Usuariocreacion", 1);

				
				rs.insertRow();
				rs.moveToCurrentRow();
				rs.close();
				rs = null;
				Runtime garbage = Runtime.getRuntime();
			    garbage.gc();
				guardado = true;
			}
			catch (Exception e){
				System.err.println("Datos: Error al guardar la consulta " + e.getMessage());
				e.printStackTrace();
			}
			return guardado;
		}
		

		// Metodo para eliminar logicamente
		
		public boolean eliminarConsulta(int consultaId){
			boolean eliminado = false;
			try {

				dtc.cargarDatos();
				
				
				rs.beforeFirst();
				while(rs.next()){
					if(rs.getInt("ConsultaID")== consultaId){
						rs.updateInt("Eliminado", 1);
						rs.updateRow();
						rs.close();
						rs = null;
						Runtime garbage = Runtime.getRuntime();
					    garbage.gc();
						eliminado = true;
					}
				}
			}
			catch (Exception e){
				System.err.println("Datos: Error al eliminar la consulta " + e.getMessage());
				e.printStackTrace();
			}
			return eliminado;
		}
		
		


// Metodo para actualizar
public boolean actualizarConsulta(Consulta c){
	boolean actualizado = false;
	try {
		
		dtc.cargarDatos();
		DateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
		Date fechaC = new Date();
		
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("ConsultaID")==c.getConsultaId()){
				rs.updateInt("PacienteID", c.getpacienteId());
				//rs.updateInt("PsicologoID", c.getpsicologoId());
				//rs.updateInt("CitaID", 1);
				rs.updateString("Objetivo", c.getObjetivo());
				rs.updateString("Actividad", c.getActividad());
				rs.updateString("Descripcion", c.getDescripcion());
				rs.updateString("Fecha", fecha.format(c.getFecha()));
				rs.updateString("Fechamodificacion", fecha.format(fechaC));
				rs.updateInt("Usuariomodificacion", 1);
				rs.updateRow();
				rs.close();
				rs = null;
				Runtime garbage = Runtime.getRuntime();
			    garbage.gc();
				actualizado = true;

			}
		}
	}
	catch (Exception e){
		System.err.println("Datos: Error al actualizar la consulta " + e.getMessage());
		e.printStackTrace();
	}
	return actualizado;
}
}