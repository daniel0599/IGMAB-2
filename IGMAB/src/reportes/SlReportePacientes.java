package reportes;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.PoolConexion;
import datos.DtVReportePacientes;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SlReportePacientes
 */
@WebServlet("/SlReportePacientes")
public class SlReportePacientes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlReportePacientes() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try 
		{
			Connection con = null;
			
			con = PoolConexion.getConnection();
			String edad ="";
			String edad2 = "";
			String sexo ="";
			String estadoCivil ="";
			edad = request.getParameter("edad");
			edad2 = request.getParameter("edad2");
			sexo = request.getParameter("sexo");
			estadoCivil = request.getParameter("estadocivil");

			//Aqu� se ponen los par�metros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			hm.put("edad", edad);
			hm.put("sexo", sexo);
			hm.put("estadocivil", estadoCivil);
			hm.put("edad2", edad2);
			
			System.out.println(hm);
			OutputStream otps = response.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reportes\\pacientes.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"ReportePacientes.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
			
		}
		catch (Exception e) 
		{
		 e.printStackTrace();
		 System.out.println("REPORTE: ERROR AL GENERAR REPORTE " + e.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			DtVReportePacientes dtn = new DtVReportePacientes();
			String edad = "";
			String edad2 = "";
			String sexo = "";
			String estadoCivil = "";

			edad = request.getParameter("edad").trim();
			edad2 = request.getParameter("edad2").trim();
			System.out.println("Edad1: "+edad);
			System.out.println("Edad2: "+edad2);
			sexo = request.getParameter("sexo");
			System.out.println("Sexo: "+sexo);
			estadoCivil = request.getParameter("estadocivil");
			System.out.println("Estado civil: "+estadoCivil);

			ResultSet rs = dtn.cargarDatos(sexo, edad, estadoCivil, edad2);
			rs.beforeFirst();
			response.setContentType("text/html; charset=UTF-8");
			String out = "";

			out += "<thead>";
			out += "<tr>";
			out += "<th>Nombre completo</th>";
			out += "<th>Edad</th>";
			out += "<th>Sexo</th>";
			out += "<th>Estado civil</th>";
			out += "<th>Fecha de ingreso</th>";
			out += "</tr>";
			out += "</thead>";

			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("NombreCompleto") + "</td>";
				out += "<td>" + rs.getString("Edad") + "</td>";
				out += "<td>" + rs.getString("Sexo") + "</td>";
				out += "<td>" + rs.getString("Estadocivil") + "</td>";
				out += "<td>" + rs.getString("Fechacreacion") + "</td>";
				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Nombre completo</th>";
			out += "<th>Edad</th>";
			out += "<th>Sexo</th>";
			out += "<th>Estado civil</th>";
			out += "<th>Fecha de ingreso</th>";
			out += "</tr>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error? " + error);

		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
	}

}
