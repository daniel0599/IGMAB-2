 package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entidades.RespuestaCatalogo;

public class DtRespuestaCatalogo {

	private static DtRespuestaCatalogo dtrc = new DtRespuestaCatalogo();
	
	private static ResultSet rs; //Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	
	public ResultSet CargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM igmab.RespuestaCatalogo WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtRespuestaCatalogo: " + e.getMessage());
		}
		return rs;
		
	}
		//M�todo para guardar
		public boolean guardarRespuestaCatalogo(RespuestaCatalogo rc) {
			boolean guardado = false;
			try {
				dtrc.CargarDatos();
				rs.moveToInsertRow();
				rs.updateString("Descripcion", rc.getDescripcion());
				rs.updateInt("ClasificacionID", rc.getRespClasificacion());
				rs.updateInt("titulopreguntaid", rc.getTituloPreguntaId());
				rs.insertRow();
				rs.moveToCurrentRow();
				guardado = true;
			}
			catch (Exception e){
				System.err.println("Datos: Error al guardar respuesta catalogo " + e.getMessage());
				e.printStackTrace();
			}
			return guardado;
		}
		
////////M�todo para eliminar l�gicamente/////
	public boolean eliminarRespuestaCatalogo(int respuestaCatalogoID) {
		boolean eliminado = false;
		try {
			dtrc.CargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("respuestaCatalogoID")==respuestaCatalogoID){
					rs.updateInt("Eliminado", 1);
					rs.updateRow();
					eliminado = true;
				}
			}
		} catch (Exception e) {
			System.err.println("Datos: Error al eliminar respuesta catalogo " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
////////M�todo para actualizar/////
public boolean actualizarRespuestaCatalogo(RespuestaCatalogo rc) {
	boolean actualizado = false;
	try {
		dtrc.CargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("respuestaCatalogoID")==rc.getRespuestaCtalogoID())
			{	
				rs.updateString("Descripcion", rc.getDescripcion());
				rs.updateInt("TitulopreguntaID", rc.getTituloPreguntaId());
				rs.updateInt("ClasificacionID", rc.getRespClasificacion());
				rs.updateRow();
				actualizado = true;
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al actualizar respuesta catalogo  " + e.getMessage());
		e.printStackTrace();
	}
	return actualizado;
}

public int calcularRespuestasCatalogo(){
	  int contador=0;
	  try{
	  dtrc.CargarDatos();
	  rs.beforeFirst();
	  while(rs.next()){
		 
		  contador++;
	  }
	  return contador;
		
	}catch(Exception e){
		System.err.println("Datos: Error al calcular el numero de clasificaciones" + e.getMessage());
		e.printStackTrace();
	}
	return contador;
	  }

public int returnIdClasificacion(int respuestacatID) {
	int idClasificacion=0;
	try {
		dtrc.CargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("respuestaCatalogoID")==respuestacatID)
			{	
				idClasificacion = rs.getInt("ClasificacionID");
				
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al traer el ID de clasificacion " + e.getMessage());
		e.printStackTrace();
	}
	return idClasificacion;
}


public int returnIdTitulo(int respuestacatID) {
	int idTitulo=0;
	try {
		dtrc.CargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("respuestaCatalogoID")==respuestacatID)
			{	
				idTitulo = rs.getInt("TitulopreguntaID");
				
			}
		}
	} catch (Exception e) {
		System.err.println("Datos: Error al traer el ID del titulo " + e.getMessage());
		e.printStackTrace();
	}
	return idTitulo;
}



} 