package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import entidades.VParientePaciente;

public class DTVParientePaciente {
	private static DTVParientePaciente dtpapa = new DTVParientePaciente();
	private static ResultSet rs; // Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarVista(){
		Statement s;
		String sql = ("SELECT * FROM igmab.pariente_paciente;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTVParientePaciente : " + e.getMessage());
		}
		return rs;
		
	}

	public ResultSet cargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM igmab.paciente_pariente;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTPacientePariente : " + e.getMessage());
		}
		return rs;

	}
	
	public boolean guardarParientePaciente(VParientePaciente vpapa) {
		boolean guardado = false;
		try {
			dtpapa.cargarDatos();
			System.out.println("entro al guardar");
			rs.moveToInsertRow();
			System.out.println("se posiciono en el result set");
	        System.out.println("los datos estan llegando a su destino");
			rs.updateInt("ParienteID", vpapa.getParienteID());
			rs.updateInt("PacienteID", vpapa.getPacienteID());

		//	System.out.println("LOS DATOS: "+p.getNombre1()+" "+p.getNombre2()+" "+p.getApellido1()+" "+p.getApellido2()+".."+"LA FECHA"+p.getFechaCreacion()+"...CARNET: "+p.getCarnet());
			rs.insertRow();
			rs.moveToCurrentRow();
			System.out.println("SI SE GUARDO true");
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el Pariente _ Paciente " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	
//	public boolean eliminarParientePaciente(int parpacID) {
//		boolean eliminado = false;
//		try {
//			dtpapa.cargarVista();
//			rs.beforeFirst();
//			while (rs.next()) {
//				if (rs.getInt("ParPacID") == parpacID) {
//					rs.updateInt("Eliminado", 1);
//					rs.updateRow();
//					eliminado = true;
//				}
//			}
//		} catch (Exception e) {
//			System.out.println("Datos : Error al elimnar el psicologo" + e.getMessage());
//			e.printStackTrace();
//		}
//		return eliminado;
//	}
	
	public boolean actualizarParientePaciente(VParientePaciente vpapa) {
		boolean actualizado = false;
		try {
			dtpapa.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("paciete_parienteID") == vpapa.getPaciente_parienteID()) {
					rs.updateInt("PacienteID", vpapa.getPacienteID());
					rs.updateInt("ParienteID", vpapa.getParienteID());
			
					rs.updateRow();
					actualizado=true;
				}
			}

		} catch (Exception e) {

			System.err.println("Datos: Error al actualizar el pariente - paciente" + e.getMessage());
			e.printStackTrace();
		}

		return actualizado;
	}
	
	
	
}



