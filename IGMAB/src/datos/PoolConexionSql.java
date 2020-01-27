package datos;
import java.sql.Connection;
import java.sql.SQLException;
import com.microsoft.sqlserver.jdbc.*;
import javax.swing.JOptionPane;


public class PoolConexionSql 
{
	//Atributos
	private static PoolConexionSql INSTANCE = null;
	private static Connection con = null;
	private static SQLServerDataSource dataSource;
	private static String db = "Externa";
	private static String server = "localhost";
	private static String user = "SA";
	private static String pass = "SomosUCA1";

    //Constructor
	private PoolConexionSql()
    {
		inicializaDataSource();
    }
	
	//Metodos
	private synchronized static void createInstance()
	{
		if(INSTANCE==null)
		{
			INSTANCE = new PoolConexionSql();
		}
	}
	
	public static PoolConexionSql getInstance()
	{
		if(INSTANCE == null)
		{
			createInstance();
		}
		return INSTANCE;
	}
	

    public final void inicializaDataSource()
    {

        SQLServerDataSource basicDataSource = new SQLServerDataSource();
        basicDataSource.setUser(user);
        basicDataSource.setPassword(pass);
        basicDataSource.setServerName(server);
        basicDataSource.setPortNumber(1433);
        basicDataSource.setDatabaseName(db);
        dataSource = basicDataSource;
    }
    
    public static boolean EstaConectado()
    {
    	boolean resp = false;
    	try
    	{
    		con = PoolConexionSql.dataSource.getConnection();
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
					con = PoolConexionSql.dataSource.getConnection();
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
		PoolConexionSql.getInstance();
		Connection con = null;
        
        try 
        {
	    	con = PoolConexionSql.getConnection();
	    	if(con!=null)
	    	{
	    		JOptionPane.showMessageDialog(null, "Conectado a Externa");
	    		System.out.println("Conectado a Externa");
	    	}
	    	else
	    	{
	    		JOptionPane.showMessageDialog(null, "Error al conectar a Externa");
	    		System.out.println("Error al conectar a Externa");
	    	}
        }
        finally
        {
            try 
            {
               con.close();
               System.out.println("Se desconect� de Externa");
            } 
            catch (SQLException ex) 
            {
            	ex.printStackTrace();
                System.out.println(ex.getMessage());
            }
        }

	}

}
