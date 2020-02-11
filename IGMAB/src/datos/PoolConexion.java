package datos;
import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;
import javax.swing.JOptionPane;

import org.apache.commons.dbcp.BasicDataSource;

public class PoolConexion 
{
	//Atributos
	private static PoolConexion INSTANCE = null;
	private static Connection con = null;
	private static DataSource dataSource;
	private static String db = "igmab";
	private static String url = "jdbc:mysql://localhost:3306/"+db;
	private static String user = "root";
	//private static String pass = "1234";
	private static String pass = "1Gm@B";

    //Constructor
	private PoolConexion()
    {
		inicializaDataSource();
    }
	
	//Metodos
	private synchronized static void createInstance()
	{
		if(INSTANCE==null)
		{
			INSTANCE = new PoolConexion();
		}
	}
	
	public static PoolConexion getInstance()
	{
		if(INSTANCE == null)
		{
			createInstance();
		}
		return INSTANCE;
	}
	

    public final void inicializaDataSource()
    {

        BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName("org.gjt.mm.mysql.Driver");
        basicDataSource.setUsername(user);
        basicDataSource.setPassword(pass);
        basicDataSource.setUrl(url);
        basicDataSource.setInitialSize(10);
        basicDataSource.setMaxActive(150);
        basicDataSource.setMaxIdle(30);
        basicDataSource.setMaxWait(10000);
        dataSource = basicDataSource;
    }
    
    public static boolean EstaConectado()
    {
    	boolean resp = false;
    	try
    	{
    		con = PoolConexion.dataSource.getConnection();
    		if ((con==null) || (con.isClosed()))
    			resp = false;
    		else
    			resp = true;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    		System.out.println(e.getMessage());
    	}
    	
    	return resp;
    }

    public static Connection getConnection() 
    {	
	   if (EstaConectado()==false) 
		   {
		   		try 
		   		{
					con = PoolConexion.dataSource.getConnection();
				} 
		   		catch (SQLException e) 
		   		{
					// TODO Auto-generated catch block
		   			e.printStackTrace();
		   			System.out.println(e.getMessage());
				}
		   }
	   return con;
    }
   

	public static void main(String[] args) throws SQLException 
	{
		// TODO Auto-generated method stub
		PoolConexion.getInstance();
		Connection con = null;
        
        try 
        {
	    	con = PoolConexion.getConnection();
	    	if(con!=null)
	    	{
	    		JOptionPane.showMessageDialog(null, "Conectado a IGMAB");
	    		System.out.println("Conectado a IGMAB");
	    	}
	    	else
	    	{
	    		JOptionPane.showMessageDialog(null, "Error al conectar a IGMAB");
	    		System.out.println("Error al conectar a IGMAB");
	    	}
        }
        finally
        {
            try 
            {
               con.close();
               System.out.println("Se desconect� de IGMAB");
            } 
            catch (SQLException ex) 
            {
            	ex.printStackTrace();
                System.out.println(ex.getMessage());
            }
        }

	}

}
