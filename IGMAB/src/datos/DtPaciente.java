package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
//import java.util.ArrayList;
import java.util.Date;

import entidades.Paciente;
//import entidades.Parentesco;

public class DtPaciente {

	private static DtPaciente dtpac = new DtPaciente(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global;
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Paciente WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPaciente: " + e.getMessage());

		}
		
		return rs;
	
	}
	
	public ResultSet cargarPacientesAPsicologos(int psicologoID) {
		ResultSet rsn = null;
		PreparedStatement s;
		try {
			s = con.prepareStatement("SELECT * FROM igmab.Paciente pac WHERE pac.Usuariocreacion = ? AND pac.Eliminado = 0");
			s.setInt(1, psicologoID);
			rsn = s.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
		}
		return rsn;
	}
	
	public ResultSet cargarDatosInactivosAPsicologos(int psicologoID) {
		ResultSet rsn = null;
		PreparedStatement s;
		try {
			s = con.prepareStatement("SELECT * FROM igmab.Paciente pac WHERE pac.Usuariocreacion = ? AND pac.Eliminado=1");
			s.setInt(1, psicologoID);
			rsn = s.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
		}
		return rsn;
	}

	public ResultSet cargarDatosInactivos() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Paciente WHERE Eliminado = 1;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPaciente: " + e.getMessage());
		}
		return rs;
	}

	public ResultSet cargarDatosAlta() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Paciente WHERE Eliminado = 2;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPaciente: " + e.getMessage());
		}
		return rs;
	}

	public ResultSet cargarDatosAltaAPsicologos(int psicologoID) {
		ResultSet rsn = null;
		PreparedStatement s;
		try {
			s = con.prepareStatement("SELECT * FROM igmab.Paciente pac WHERE pac.Usuariocreacion = ? AND pac.Eliminado=2");
			s.setInt(1, psicologoID);
			rsn = s.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
		}
		return rsn;
	}

	public ResultSet cargarPacientesAPsicologosConsulta(int psicologoID) {
		ResultSet rsn = null;
		PreparedStatement s;
		try {
			s = con.prepareStatement("SELECT  pac.PacienteID, pac.Nombre1, pac.Nombre2, pac.Apellido1, pac.Apellido2  FROM igmab.Paciente pac left JOIN Consulta con ON pac.PacienteID=con.PacienteID left JOIN Psicologo psi ON con.PsicologoID=psi.PsicologoID wHERE psi.PsicologoID = ? or isnull(psi.PsicologoID) AND pac.Eliminado =0");
			s.setInt(1, psicologoID);
			rsn = s.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en obtenerPsicologoID() de DtConsulta: " + e.getMessage());
		}
		return rsn;
	}
	
	public ResultSet cargarEscolaridades() {
		Statement s;
		String sql = ("SELECT * FROM igmab.Escolaridad;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtPaciente (cargarEscolaridades): " + e.getMessage());
		}
		return rs;
	}

	//////// M�todo para guardar/////
	public boolean guardarPaciente(Paciente pac) {
		boolean guardado = false;
		try {
			DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
			Date fechaC = new Date();

			dtpac.cargarDatos();
			rs.moveToInsertRow();
			System.out.println(pac.getExpediente());
			rs.updateString("Expediente", pac.getExpediente());
			rs.updateString("Nombre1", pac.getNombre1());
			rs.updateString("Nombre2", pac.getNombre2());
			rs.updateString("Apellido1", pac.getApellido1());
			rs.updateString("Apellido2", pac.getApellido2());
			rs.updateString("Celular", pac.getCelular());
			rs.updateString("Direccion", pac.getDireccion());
			rs.updateString("Edad", pac.getEdad());
			rs.updateInt("Estadocivil", pac.getEstadoCivil());
			rs.updateInt("Internado", pac.getInternado());
			rs.updateString("Internadoafirmativo", pac.getInternadoAfirmativo());
			rs.updateInt("Sexo", pac.getSexo());
			rs.updateInt("Terapia", pac.getTerapia());
			rs.updateString("Fechanac", fecha.format(pac.getFechaNac()));
			rs.updateString("Fechacreacion", fecha.format(fechaC));
			rs.updateString("Escolaridad", pac.getEscolaridad());
			rs.updateString("Conquienvive", pac.getConQuienVive());
			rs.updateString("Lugartrabajo", pac.getLugarTrabajo());
			rs.updateString("Empleo", pac.getEmpleo());
			rs.updateString("Salario", pac.getSalario());
			rs.updateInt("Usuariocreacion", pac.getUsuarioCreacion());
			rs.updateInt("EscolaridadID", pac.getEscolaridadID());
			
			rs.updateString("religion", pac.getReligion());
			rs.updateString("motivoconsulta", pac.getMotivoconsulta());
			rs.updateString("crianzaAnios", pac.getCrianzaAnios());
			rs.updateString("relacionProgenitores", pac.getRelacionProgenitores());
			
			
			
			
			if(pac.getEstudianteUCA()==1) {
				rs.updateInt("Uca", pac.getEstudianteUCA());
			}
			rs.insertRow();
			rs.moveToCurrentRow();
			rs.close();
			rs = null;
			Runtime garbage = Runtime.getRuntime();
		    garbage.gc();
			guardado = true;
		} catch (Exception e) {
			System.err.println("Datos: Error al guardar el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return guardado;
	}

	//////// M�todo para eliminar l�gicamente/////
	public boolean eliminarPaciente(int pacienteId) {
		boolean eliminado = false;
		try {
			dtpac.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PacienteID") == pacienteId) {
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
			System.err.println("Datos: Error al eliminar el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return eliminado;
	}

	public boolean eliminarPacienteAlta(int pacienteId) {
		boolean eliminado = false;
		try {
			dtpac.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PacienteID") == pacienteId) {
					rs.updateInt("Eliminado", 2);
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();

					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return eliminado;
	}


	public boolean actualizarPaciente(Paciente pac) {
		boolean actualizado = false;
		DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
		Date fechaC = new Date();
		try {
			dtpac.cargarDatos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PacienteID") == pac.getPacienteID()) {
					rs.updateString("Nombre1", pac.getNombre1());
					rs.updateString("Nombre2", pac.getNombre2());
					rs.updateString("Apellido1", pac.getApellido1());
					rs.updateString("Apellido2", pac.getApellido2());
					rs.updateString("Celular", pac.getCelular());
					rs.updateString("Direccion", pac.getDireccion());
					rs.updateString("Edad", pac.getEdad());
					rs.updateInt("Estadocivil", pac.getEstadoCivil());
					rs.updateInt("Internado", pac.getInternado());
					rs.updateString("Internadoafirmativo", pac.getInternadoAfirmativo());
					rs.updateInt("Sexo", pac.getSexo());
					rs.updateInt("Terapia", pac.getTerapia());
					rs.updateString("Fechanac", fecha.format(pac.getFechaNac()));
					rs.updateString("Fechamodificacion", fecha.format(fechaC));
					rs.updateString("Escolaridad", pac.getEscolaridad());
					rs.updateString("Conquienvive", pac.getConQuienVive());
					rs.updateString("Lugartrabajo", pac.getLugarTrabajo());
					rs.updateString("Empleo", pac.getEmpleo());
					rs.updateString("Salario", pac.getSalario());
					rs.updateInt("Usuariomodificacion", 1);
					rs.updateInt("EscolaridadID", pac.getEscolaridadID());
					rs.updateInt("Uca", pac.getEstudianteUCA());
					rs.updateString("religion", pac.getReligion());
					rs.updateString("motivoconsulta", pac.getMotivoconsulta());
					rs.updateString("crianzaAnios", pac.getCrianzaAnios());
					rs.updateString("relacionProgenitores", pac.getRelacionProgenitores());
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();

					actualizado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al actualizar el paciente " + e.getMessage());
			e.printStackTrace();
	
		}
		return actualizado;
	}

	public boolean reactivar(int pacienteId) {
		boolean reactivado = false;

		try {
			dtpac.cargarDatosInactivos();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PacienteID") == pacienteId) {
					rs.updateInt("Eliminado", 0);
					rs.updateRow();
					rs.close();
					rs = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();

					reactivado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al reactivar el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return reactivado;
	}

	public boolean reactivarDadoAlta(int pacienteId) {
		boolean reactivado = false;
        ResultSet rsAlta;
		try {
			rsAlta=dtpac.cargarDatosAlta();
			rsAlta.beforeFirst();
			while (rsAlta.next()) {
				if (rsAlta.getInt("PacienteID") == pacienteId) {
					rsAlta.updateInt("Eliminado", 0);
					rsAlta.updateRow();
					rsAlta.close();
					rsAlta = null;
					Runtime garbage = Runtime.getRuntime();
				    garbage.gc();

					reactivado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al reactivar el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return reactivado;
	}
	
	//Método para transferir un paciente a otro psicólogo //
	public boolean transferirPaciente(int pacienteId, int psicologoId) {
		DtConsulta cons = new DtConsulta();
		int usuarioIDnuevo = cons.obtenerUsuarioID(psicologoId);
		
		PreparedStatement s;
		PreparedStatement t;
		PreparedStatement u;
		PreparedStatement v;
		PreparedStatement w;
		PreparedStatement x;
		try {
			s = con.prepareStatement("UPDATE Consulta SET PsicologoID=? WHERE PacienteID=?");
			s.setInt(1, psicologoId);
			s.setInt(2, pacienteId);
			s.executeUpdate();
			
			t = con.prepareStatement("UPDATE Paciente SET UsuarioCreacion=? WHERE PacienteID=?");
			t.setInt(1, usuarioIDnuevo);
			t.setInt(2, pacienteId);
			t.executeUpdate();
			
			
			
			u = con.prepareStatement("Select * from pariente inner join paciente_pariente parO on parO.ParienteID=pariente.ParienteID inner join paciente pac on parO.ParienteID=pac.PacienteID WHERE pac.PacienteID=?");
			u.setInt(1, pacienteId);
			ResultSet rsaux;
			rsaux= u.executeQuery();
			rs.beforeFirst();
			while(rsaux.next()){
			v = con.prepareStatement("UPDATE Pariente SET Usuariocreacion=?");
			v.setInt(1, usuarioIDnuevo);
			v.executeUpdate();
			}
			
			w = con.prepareStatement("	Select * from paciente_pariente inner join paciente pacO on pacO.PacienteID=paciente_pariente.PacienteID WHERE pacO.PacienteID=?");
			w.setInt(1, pacienteId);
			ResultSet rsaux1;
			rsaux1= w.executeQuery();
			rs.beforeFirst();
			while(rsaux1.next()){
			x = con.prepareStatement("UPDATE paciente_pariente SET Usuariocreacion=?");
			x.setInt(1, usuarioIDnuevo);
			x.executeUpdate();
			}
			return true;
		} catch (Exception e) {
			System.err.println("Datos: Error al transferir el paciente " + e.getMessage());
			e.printStackTrace();
		
		}
		return false;
	}

}

