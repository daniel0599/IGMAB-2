package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.Respuesta;


public class DtRespuesta {
	private static DtRespuesta dtresp = new DtRespuesta(); // Instancia unica del DT
	
	private static ResultSet rs; //Resultset Globak
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();
	
	
	public ResultSet cargarDatos(){
		//ArrayList<Respuesta> listaRespuesta = new ArrayList<Respuesta>();
		
		Statement s;
		String sql = ("SELECT * FROM igmab.Respuesta where Eliminado = 0;");
		
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);

		}
		catch(Exception e){
			System.err.println("Datos: Error en DT Respuesta "+e.getMessage());
		}
		return rs;
	}
	
	////////// 	M�TODO PARA GUARDAR  /////////////
	
	public boolean guardarRespuesta(Respuesta r)
	{
		boolean guardado = false;
		try{
			dtresp.cargarDatos();
			System.out.println("entro al guardar");
			rs.moveToInsertRow();
			System.out.println("Se posiciono en el result set");
			System.out.println("LOS DATOS SON:"+r.getSeleccion()+" Descripcion"+r.getDescripcion()+" Seleccion"+r.getSeleccion()+" Grado: "+r.getGrado()+"Paciente ID "+r.getPacienteId()+" Respuesta catalogo ID"+r.getRespuestaCatalogoID()+"Clasificacion ID"+r.getClasificacionID()+"Titulo pregunta id:"+r.getTituloPreguntaId() );
			rs.updateString("Descripcion", r.getDescripcion());
			rs.updateInt("Seleccion", r.getSeleccion());
			rs.updateInt("Grado", r.getGrado());
			rs.updateInt("PacienteID", r.getPacienteId());
			rs.updateInt("RespuestacatalogoID", r.getRespuestaCatalogoID());
			rs.updateInt("TitulopreguntaID", r.getTituloPreguntaId());
			rs.updateInt("ClasificacionID", r.getClasificacionID());
			rs.insertRow();
			rs.moveToCurrentRow();
			System.out.println("SI SE GUARDO ");
			guardado = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Datos: Error al guardar su respuesta");
		}
		return guardado;
	}
	
	
	public boolean validarPaciente(int pacienteID) {
		boolean presente=false;
		try {
			dtresp.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("PacienteID")==pacienteID)
				{	
					presente = true;
					System.out.println("EL paciente si esta en la tabla respuesta");
				    
					break;
					
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al validar si el paciente ya esta en la DB " + e.getMessage());
			e.printStackTrace();
		}
		return presente;
	}
	
	
}
