package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import entidades.Paciente;
import entidades.Parentesco;

public class DtPaciente {

	private static DtPaciente dtpac = new DtPaciente(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
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
			rs.updateInt("Usuariocreacion", 1);
			rs.updateInt("EscolaridadID", pac.getEscolaridadID());
			if(pac.getEstudianteUCA()==1) {
				rs.updateInt("Uca", pac.getEstudianteUCA());
			}
			rs.insertRow();
			rs.moveToCurrentRow();
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
					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar el paciente " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	//////// M�todo para actualizar/////
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
					rs.updateRow();
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

		try {
			dtpac.cargarDatosAlta();
			rs.beforeFirst();
			while (rs.next()) {
				if (rs.getInt("PacienteID") == pacienteId) {
					rs.updateInt("Eliminado", 0);
					rs.updateRow();
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
		PreparedStatement s;
		try {
			s = con.prepareStatement("UPDATE Consulta SET PsicologoID=? WHERE PacienteID=?;");
			s.setInt(1, psicologoId);
			s.setInt(2, pacienteId);
			s.executeUpdate();
			return true;
		} catch (Exception e) {
			System.err.println("Datos: Error al transferir el paciente " + e.getMessage());
			e.printStackTrace();
		}
		return false;
	}

}
