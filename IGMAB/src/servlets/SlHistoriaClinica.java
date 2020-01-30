package servlets;

import java.io.IOException;
//import java.io.OutputStream;
import java.io.PrintWriter;
//import java.sql.Connection;
import java.sql.ResultSet;
//import java.util.HashMap;

//import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DtHistoriaClinica;
import datos.DtVHistoriaClinicaPaciente;
//import datos.PoolConexion;
import entidades.HistoriaClinica;
//import net.sf.jasperreports.engine.JasperFillManager;
//import net.sf.jasperreports.engine.JasperPrint;
//import net.sf.jasperreports.engine.export.JRPdfExporter;
//import net.sf.jasperreports.export.Exporter;
//import net.sf.jasperreports.export.SimpleExporterInput;
//import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SlHistoriaClinica
 */
@WebServlet("/SlHistoriaClinica")
public class SlHistoriaClinica extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SlHistoriaClinica() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion").trim();
		String motivoConsulta ="";
		String historiaPadecimiento ="";
		String expectativas="";
		String antecedentesHeredoFamiliares="";
		String antecedentesPersonalesNoPatologicos="";
		String antecedentesPatologicosPersonales="";
		String antecedentesPatologicosFamiliares="";
		String relacionConElNucleoFamilar="";
		String areaEscolar="";
		String desarrolloSocial="";
		String desarrolloLaboral="";
		String desarrolloSexual="";
		String desarrolloConyugal="";
		String desarrolloEspiritual="";
		String aspectoYConductaGeneral="";
		String algoMasAgregar="";
		String impresionDiagnostica="";
		
		DtHistoriaClinica dthc = new DtHistoriaClinica();
		HistoriaClinica hc = new HistoriaClinica();
		
		switch (opcion) {
		case "guardar":
			try {
				int PacienteId = Integer.parseInt(request.getParameter("fpacienteId"));
				motivoConsulta = request.getParameter("fmotivoConsulta");
				historiaPadecimiento = request.getParameter("fhistoriaPadecimiento");
				expectativas = request.getParameter("fexpectativas");
				antecedentesHeredoFamiliares = request.getParameter("fantecedentesHeredoFamiliares");
				antecedentesPersonalesNoPatologicos = request.getParameter("fantecedentesPersonalesNoPatologicos");
				antecedentesPatologicosPersonales = request.getParameter("fantecedentesPatologicosPersonales");
				antecedentesPatologicosFamiliares = request.getParameter("fantecedentesPatologicosFamiliares");
				relacionConElNucleoFamilar = request.getParameter("frelacionConElNucleoFamilar");
				areaEscolar = request.getParameter("fareaEscolar");
				desarrolloSocial = request.getParameter("fdesarrolloSocial");
				desarrolloLaboral = request.getParameter("fdesarrolloLaboral");
				desarrolloSexual = request.getParameter("fdesarrolloSexual");
				desarrolloConyugal = request.getParameter("fdesarrolloConyugal");
				desarrolloEspiritual = request.getParameter("fdesarrolloEspiritual");
				aspectoYConductaGeneral = request.getParameter("faspectoYConductaGeneral");
				algoMasAgregar = request.getParameter("falgoMasAgregar");
				impresionDiagnostica = request.getParameter("impresionDiagnostica");
				
				hc.setAlgoMasAgregar(algoMasAgregar);
				hc.setAntecedentesPatologicosF(antecedentesPatologicosFamiliares);
				hc.setAntecedentesPatologicosP(antecedentesPatologicosPersonales);
				hc.setAntecedentesPersonalesNP(antecedentesPersonalesNoPatologicos);
				hc.setAreaEscolar(areaEscolar);
				hc.setAspectoConductaGeneral(aspectoYConductaGeneral);
				hc.setDesarrolloConyugal(desarrolloConyugal);
				hc.setDesarrolloEspiritual(desarrolloEspiritual);
				hc.setDesarrolloLaboral(desarrolloLaboral);
				hc.setDesarrolloSexual(desarrolloSexual);
				hc.setDesarrolloSocial(desarrolloSocial);
				hc.setExpectativa(expectativas);
				hc.setImpresionDiagnostica(impresionDiagnostica);
				hc.setMotivoConsulta(motivoConsulta);
				hc.setPacienteId(PacienteId);
				hc.setPadecimientoActual(historiaPadecimiento);
				hc.setPadecimientoH_F(antecedentesHeredoFamiliares);
				hc.setRelacionNucleoF(relacionConElNucleoFamilar);
				
				if (dthc.guardarHistoriaClinica(hc)){
					System.out.println("Guardado exitosamente");
				}
				
				
				
						
				
				
				
				
			} catch (Exception e) {
				System.out.println("SL error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			
			break;

		case "actualizar":
			try {
				int HistoriaclinicaId = Integer.parseInt(request.getParameter("fHistoriaClinicaId"));
				int PacienteId = Integer.parseInt(request.getParameter("fpacienteIdEditar"));
				motivoConsulta = request.getParameter("fmotivoConsultaEditar");
				historiaPadecimiento = request.getParameter("fhistoriaPadecimientoEditar");
				expectativas = request.getParameter("fexpectativasEditar");
				antecedentesHeredoFamiliares = request.getParameter("fantecedentesHeredoFamiliaresEditar");
				antecedentesPersonalesNoPatologicos = request.getParameter("fantecedentesPersonalesNoPatologicosEditar");
				antecedentesPatologicosPersonales = request.getParameter("fantecedentesPatologicosPersonalesEditar");
				antecedentesPatologicosFamiliares = request.getParameter("fantecedentesPatologicosFamiliaresEditar");
				relacionConElNucleoFamilar = request.getParameter("frelacionConElNucleoFamilarEditar");
				areaEscolar = request.getParameter("fareaEscolarEditar");
				desarrolloSocial = request.getParameter("fdesarrolloSocialEditar");
				desarrolloLaboral = request.getParameter("fdesarrolloLaboralEditar");
				desarrolloSexual = request.getParameter("fdesarrolloSexualEditar");
				desarrolloConyugal = request.getParameter("fdesarrolloConyugalEditar");
				desarrolloEspiritual = request.getParameter("fdesarrolloEspiritualEditar");
				aspectoYConductaGeneral = request.getParameter("faspectoYConductaGeneralEditar");
				algoMasAgregar = request.getParameter("falgoMasAgregarEditar");
				impresionDiagnostica = request.getParameter("impresionDiagnosticaEditar");
				
				hc.setHistoriaClinicaId(HistoriaclinicaId);
				hc.setAlgoMasAgregar(algoMasAgregar);
				hc.setAntecedentesPatologicosF(antecedentesPatologicosFamiliares);
				hc.setAntecedentesPatologicosP(antecedentesPatologicosPersonales);
				hc.setAntecedentesPersonalesNP(antecedentesPersonalesNoPatologicos);
				hc.setAreaEscolar(areaEscolar);
				hc.setAspectoConductaGeneral(aspectoYConductaGeneral);
				hc.setDesarrolloConyugal(desarrolloConyugal);
				hc.setDesarrolloEspiritual(desarrolloEspiritual);
				hc.setDesarrolloLaboral(desarrolloLaboral);
				hc.setDesarrolloSexual(desarrolloSexual);
				hc.setDesarrolloSocial(desarrolloSocial);
				hc.setExpectativa(expectativas);
				hc.setImpresionDiagnostica(impresionDiagnostica);
				hc.setMotivoConsulta(motivoConsulta);
				hc.setPacienteId(PacienteId);
				hc.setPadecimientoActual(historiaPadecimiento);
				hc.setPadecimientoH_F(antecedentesHeredoFamiliares);
				hc.setRelacionNucleoF(relacionConElNucleoFamilar);
				
				if (dthc.actualizarHistoriaClinica(hc)){
					System.out.println("Actualizado exitosamente");
				}
				
			} catch (Exception e) {
				System.out.println("SL: error en el servlet: " + e.getMessage());
				e.printStackTrace();
			}
			break;
			
		case "refrescar" :
			refrescar(request,response);
			break;
		}
		
	}
	
	protected void refrescar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			DtVHistoriaClinicaPaciente dtc = new DtVHistoriaClinicaPaciente();
			ResultSet rs = dtc.cargarVista();
			
			response.setContentType("text/html; charset=UTF-8");
			String out = "";
			
			out+="<thead>";
			out+="<tr>";
			out+="<th>Paciente</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
			out+="</thead>";
			
			out += "<tbody>";
			while(rs.next()){
				out += "<tr>";
				out += "<td>" + rs.getString("Nombre1") + " " + rs.getString("Nombre2") + " " + rs.getString("Apellido1") + " " + rs.getString("Apellido2")+ "</td>";
				out += "<td>";
				out += "<button id='btnIdVisualizar' value="+rs.getInt("HistoriaclinicaID")+" class='ajax-link action btn btn-default btn-label-left' "
						+"onclick ='visualizarDatos(this.value, \""+rs.getString("Motivoconsulta")+"\","
						+ "\""+rs.getString("Padecimientoactual")+"\","
						+ "\""+rs.getString("Expectativa")+"\","
						+ "\""+rs.getString("Padecimientoh_f")+"\","
						+ "\""+rs.getString("Antecedentespersonalesnp")+"\","
						+ "\""+rs.getString("Antecedentespatologicosp")+"\","
						+ "\""+rs.getString("Antecedentespatologicosf")+"\","
						+ "\""+rs.getString("Relacionnucleof")+"\","
						+ "\""+rs.getString("Areaescolar")+"\","
					    + "\""+rs.getString("Desarrollosocial")+"\","
					    + "\""+rs.getString("Desarrollolaboral")+"\","
					    + "\""+rs.getString("Desarrollosexual")+"\","
					    + "\""+rs.getString("Desarrolloconyugal")+"\","
					    + "\""+rs.getString("Desarrolloespiritual")+"\","
					    + "\""+rs.getString("Aspectoconductageneral")+"\","
					    + "\""+rs.getString("Algomasagregar")+"\","
					    + "\""+rs.getString("Impresiondiagnostica")+"\","
					    + "\""+rs.getInt("PacienteID")+"\")'><span><i class='fa fa-eye'></i></span>Ver Historia Clinica</button>";
				
				out +="<button id='btnIdActualizar' value="+rs.getInt("HistoriaclinicaID")+" class='btn btn-primary btn-label-left' "
						+"onclick = 'cargarDatos(this.value, \""+rs.getString("Motivoconsulta")+"\","
						+ "\""+rs.getString("Padecimientoactual")+"\","
						+ "\""+rs.getString("Expectativa")+"\","
						+ "\""+rs.getString("Padecimientoh_f")+"\","
						+ "\""+rs.getString("Antecedentespersonalesnp")+"\","
						+ "\""+rs.getString("Antecedentespatologicosp")+"\","
						+ "\""+rs.getString("Antecedentespatologicosf")+"\","
						+ "\""+rs.getString("Relacionnucleof")+"\","
						+ "\""+rs.getString("Areaescolar")+"\","
					    + "\""+rs.getString("Desarrollosocial")+"\","
					    + "\""+rs.getString("Desarrollolaboral")+"\","
					    + "\""+rs.getString("Desarrollosexual")+"\","
					    + "\""+rs.getString("Desarrolloconyugal")+"\","
					    + "\""+rs.getString("Desarrolloespiritual")+"\","
					    + "\""+rs.getString("Aspectoconductageneral")+"\","
					    + "\""+rs.getString("Algomasagregar")+"\","
					    + "\""+rs.getString("Impresiondiagnostica")+"\","
					    + "\""+rs.getInt("PacienteID")+"\")'><span><i class='fa fa-edit'></i></span>Actualizar</button>";
					   
				
			out +="</td>";
			out += "</tr>";
			}
			out += "</tbody>";
			
			out += "<tfoot>";
			out += "<tr>";
			out+="<th>Paciente</th>";
			out+="<th>Acciones</th>";
			out+="</tr>";
			out += "</tfoot>";
			
			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);
		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}
		
		
	}
	

}
