package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import entidades.TituloPregunta;

public class DtTituloPregunta {

	private static DtTituloPregunta dtt = new DtTituloPregunta(); //Inicializando la clase
	
	private static ResultSet rs; //Resultset Global
	PoolConexion pc = PoolConexion.getInstance();
	Connection con = PoolConexion.getConnection();

	
	public ResultSet cargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM igmab.Titulopregunta WHERE Eliminado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			}
		catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DtTituloPregunta: " + e.getMessage());
		}
		return rs;
	}
	
	//M�todo para guardar
	public boolean guardarTituloPregunta(TituloPregunta t) {
		boolean guardado = false;
		try {
			dtt.cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("Descripcion", t.getDescripcion());
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e){
			System.err.println("Datos: Error al guardar t�tulo pregunta " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	//M�todo para eliminar l�gicamente
	public boolean eliminarTituloPregunta(int tituloPreguntaId){
	boolean eliminado = false;
	try {
		dtt.cargarDatos();
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt("TitulopreguntaID")==tituloPreguntaId){
				rs.updateInt("Eliminado", 1);
				rs.updateRow();
				eliminado = true;
			}
		}
	}
		catch (Exception e){
			System.err.println("Datos: Error al eliminar t�tulo pregunta " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	//M�todo para actualizar 
	public boolean actualizarTituloPregunta(TituloPregunta t){
		boolean actualizado = false;
		try {
			dtt.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("TitulopreguntaID")==t.getTituloPreguntaId()){
					rs.updateString("Descripcion", t.getDescripcion());
					rs.updateRow();
					actualizado = true;
				}
			}
		}
		catch(Exception e){
			System.err.println("Datos: Error al actualizar t�tulo pregunta " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
   
	public int calcularTitulos(){
	  int contador=0;
	  try{
	  dtt.cargarDatos();
	  rs.beforeFirst();
	  while(rs.next()){
		 
		  contador++;
	  }
	  return contador;
		
	}catch(Exception e){
		System.err.println("Datos: Error al calcular el numero de t�tulos pregunta " + e.getMessage());
		e.printStackTrace();
	}
	return contador;
	  }
	
}


