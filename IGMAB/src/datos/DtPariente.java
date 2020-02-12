package datos;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
//ADSD
import entidades.Pariente;

public class DtPariente {
	private static DtPariente dtpar = new DtPariente();
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("Select *  from igmab.Pariente WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPariente: " + e.getMessage());
		}
		return rs;
	}

	
////////M�todo para guardar/////
	public boolean guardarPariente(Pariente par) {
		boolean guardado = false;
		try {
			//DateFormat fechaNac = new SimpleDateFormat("yyyy/MM/dd");
	//		Date fechaC = new Date();
			dtpar.cargarDatos();
			Date date = new Date();
			DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			rs.moveToInsertRow();
			rs.updateString("Nombre1", par.getNombre1());
			rs.updateString("Nombre2", par.getNombre2());
			rs.updateString("Apellido1", par.getApellido1());
			rs.updateString("Apellido2", par.getApellido2());
			rs.updateInt("Estadovida", par.getEstadoVida());
			rs.updateString("Edad", par.getEdad());
		//	rs.updateString("Fechanac", fechaNac.format(par.getFechaNac()));
			rs.updateString("Causamuerte", par.getCausaMuerte());
			rs.updateInt("EscolaridadID", par.getEscolaridadID());
			rs.updateString("Escolaridad", par.getEscolaridad());
			rs.updateString("Ocupacion", par.getOcupacion());
			rs.updateString("Lugartrabajo", par.getLugarTrabajo());
			rs.updateString("Cargo", par.getCargo());
			rs.updateString("Salariomensual", par.getSalarioMensual());
			rs.updateInt("Tutor", par.getTutor());
			rs.updateString("Fechacreacion", fecha.format(date));
			rs.updateInt("Eliminado", 0);
			rs.updateInt("ParentescoID", par.getParentescoId());
			rs.updateInt("Usuariocreacion", 1);

			rs.insertRow();
			rs.moveToCurrentRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el pariente " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
////////M�todo para eliminar l�gicamente/////
	public boolean eliminarPariente(int parienteId) {
		boolean eliminado = false;
		try {
//			Date date = new Date();
	//		DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			dtpar.cargarDatos();
	
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("ParienteID")==parienteId){
					rs.updateInt("Eliminado", 1);
					//rs.updateString("Fechaeliminacion", fecha.format(date));
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
					eliminado= true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar el pariente " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
////////M�todo para actualizar/////
	public boolean actualizarPariente(Pariente par) {
		boolean actualizado = false;
		try {
			//DateFormat fechaNac = new SimpleDateFormat("yyyy/MM/dd");
			dtpar.cargarDatos();
			Date date = new Date();
			DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("ParienteID")==par.getParienteId()){
					rs.updateString("Nombre1", par.getNombre1());
					rs.updateString("Nombre2", par.getNombre2());
					rs.updateString("Apellido1", par.getApellido1());
					rs.updateString("Apellido2", par.getApellido2());
					rs.updateInt("Estadovida", par.getEstadoVida());
					rs.updateString("Edad", par.getEdad());
					//rs.updateString("Fechanac", fechaNac.format(par.getFechaNac()));
					rs.updateString("Causamuerte", par.getCausaMuerte());
					rs.updateString("Escolaridad", par.getEscolaridad());
					rs.updateString("Ocupacion", par.getOcupacion());
					rs.updateString("Lugartrabajo", par.getLugarTrabajo());
					rs.updateString("Cargo", par.getCargo());
					rs.updateString("Salariomensual", par.getSalarioMensual());
					rs.updateInt("Tutor", par.getTutor());
					rs.updateInt("EscolaridadID", par.getEscolaridadID());
					rs.updateInt("ParentescoID", par.getParentescoId());
					rs.updateString("Fechamodificacion",fecha.format(date));
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();
				    actualizado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar el parentesco " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	
	
}