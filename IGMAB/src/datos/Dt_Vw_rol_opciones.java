package datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entidades.Rol;

public class Dt_Vw_rol_opciones {
	//private static Dt_Vw_rol_opciones dtvrop = new Dt_Vw_rol_opciones(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	

	
	public ResultSet cargarDatos()
	{
		Statement s;
		String sql = ("SELECT * FROM igmab.vw_rol_opciones;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Dt_Vw_rol_opciones: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet obtenerOpc(Rol r)
	{
		Statement s;
		String sql = ("SELECT * FROM igmab.vw_rol_opciones where id_rol="+r.getRolId()+";");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Dt_Vw_rol_opciones: "+e.getMessage());
		}
		return rs;
	}
}

