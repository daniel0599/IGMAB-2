package datos;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

public class DtVReportePacientes {
	//private static DtVReportePacientes dtrpac = new DtVReportePacientes(); // Instanciando la
	// Clase
	private static ResultSet rs; // ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();


	public ResultSet cargarDatos(String sexo, String edad, String estadocivil, String edad2) {
		try {
			
			CallableStatement pacientes = con.prepareCall("{CALL GenerarReportePaciente(?, ?, ?, ?)}");
			pacientes.setString(1, edad);
			pacientes.setString(2, sexo);
			pacientes.setString(3, estadocivil);
			pacientes.setString(4, edad2);
			//pacientes.execute();
			rs = pacientes.executeQuery();
			while(rs.next()){
				System.out.println("Nombre del paciente: "+rs.getString("NombreCompleto"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DtVReportePacientes: " + e.getMessage());
		}
		return rs;
	}
}
