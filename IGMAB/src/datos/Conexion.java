package datos;
import java.sql.*;

public class Conexion {
	
	private static Connection cn = null;
	private static String url = "jdbc:mysql://localhost:3306/igmab";
	private static String user = "root";
	private static String password = "My$qlS3rv3rAPS*";
	
	
	public Conexion(){
		
	}
	
	public static Connection getConnection(){
		if(estaConectado()==false){
			Conexion.crearConexion();
		}
		return cn;
	}
	
	public static boolean estaConectado(){
		boolean resp = false;
		try{
			if((cn==null) || (cn.isClosed())){
				resp = false;
			}
			else
				resp = true;
		}
		catch(Exception e){}
		return resp;
	}
	
	public static void crearConexion(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			cn=DriverManager.getConnection(url,user,password);
			System.out.println("Se conectó a la base de datos");
		}
		catch (ClassNotFoundException e) 
        {
           cn=null;
           System.out.println("Error no se puede cargar el driver:" + e.getMessage());
       } 
        catch (SQLException e) 
        {
           cn=null;
           System.out.println("Error al establecer la conexion:" + e.getMessage());
       }
		
	}

	public static void main(String[] args) {
		new Conexion();
		Conexion.getConnection();

	}

}
