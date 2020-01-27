package TestSuite;

import static org.junit.Assert.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

import datos.DtPaciente;

public class DtPacienteTest {

	@Test
	public void cargarPacientes() throws SQLException, ParseException{
		System.out.println("Probando que carguen los registros en la tabla 'Paciente'");
		DtPaciente dtp = new DtPaciente();
		ResultSet rs;
		rs = dtp.cargarDatos();
		rs.beforeFirst();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Boolean last=false;		
			
		while (rs.next()) {			
			System.out.println(" Expediente: " + rs.getString("Expediente"));
			System.out.println(" Nombre completo: " + rs.getString("Nombre1") + " "+ rs.getString("Nombre2") + " " + 
			rs.getString("Apellido1") + " "+ rs.getString("Apellido2"));
			System.out.println("Edad: " + rs.getString("Edad"));
			
			Date fecha = formatter.parse(rs.getString("Fechanac"));
			
			System.out.println("Fecha de nacimiento: "+ fecha);
			
			last=rs.isLast();			
		}
		
		assertTrue(last);

	}
}
