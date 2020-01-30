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
import datos.DtVReporteAsistencia;
//import datos.DtVReportePacientes;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SlReporteAsistencia
 */
@WebServlet("/SlReporteAsistencia")
public class SlReporteAsistencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlReporteAsistencia() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			Connection con = null;
			con = PoolConexion.getConnection();
			String psicologoId="";
			String fechaOrigen ="";
			String fechaCierre ="";
			
			psicologoId = request.getParameter("psicologoId");
			fechaOrigen = request.getParameter("fechaOrigen");
			fechaCierre = request.getParameter("fechaCierre");
			
			HashMap<String, Object>hm = new HashMap<>();
			hm.put("psicologoId", psicologoId);
			hm.put("fechaOrigen", fechaOrigen);
			hm.put("fechaCierre", fechaCierre);
			
			System.out.println(hm);
			OutputStream otps = response.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reportes\\Asistencia.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"ReporteAsistencia.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
		} catch (JRException e) {
			// TODO Auto-generated catch block
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
			DtVReporteAsistencia dtn = new DtVReporteAsistencia();
			String psicologoId="";
			String fechaOrigen ="";
			String fechaCierre ="";
			
			psicologoId = request.getParameter("psicologoId");
			fechaOrigen = request.getParameter("fechaOrigen");
			System.out.println("fecha origen: "+fechaOrigen);
			fechaCierre = request.getParameter("fechaCierre");
			System.out.println("fecha origen: "+fechaCierre);
			ResultSet rs = dtn.cargarDatos(psicologoId,fechaOrigen, fechaCierre);
			rs.beforeFirst();
			response.setContentType("text/html; charset=UTF-8");
			String out = "";
			
			out += "<thead>";
			out += "<tr>";
			out += "<th>Nombre completo</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora de entrada</th>";
			out += "<th>Hora de salida</th>";
			out += "</tr>";
			out += "</thead>";
			
			out += "<tbody>";
			while (rs.next()) {
				out += "<tr>";
				out += "<td>" + rs.getString("nombreCompleto") + "</td>";
				out += "<td>" + rs.getString("Fecha") + "</td>";
				out += "<td>" + rs.getString("horaentrada") + "</td>";
				out += "<td>" + rs.getString("horasalida") + "</td>";
				out += "</tr>";
			}
			out += "</tbody>";
			
			out += "<tfoot>";
			out += "<tr>";
			out += "<th>Nombre completo</th>";
			out += "<th>Fecha</th>";
			out += "<th>Hora de entrada</th>";
			out += "<th>Hora de salida</th>";
			out += "</tr>";
			out += "</tfoot>";
			
			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error? " + error);
			
		} catch (Exception e) {
			System.out.println("SL: error en el servlet de reporte asistencia:" + e.getMessage());
			e.printStackTrace();
		}
	}

}
