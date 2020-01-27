package TestSuite;
import datos.DtConsulta;
import static org.junit.Assert.*;

import org.junit.Test;

import java.sql.Connection;
import java.sql.ResultSet;


public class DtConsultaJunitTest {
    public static DtConsulta dtc2 = new DtConsulta();
    private static ResultSet rs2;

    @Test
    public void eliminarConsulta(){
        boolean eliminado = false;

        try {

            rs2=dtc2.cargarDatos();

            rs2.beforeFirst();
            while(rs2.next()){
                if(rs2.getInt("ConsultaID")== 1){
                    rs2.updateInt("Eliminado", 1);
                    rs2.updateRow();
                    eliminado = true;
                }
            }
        }
        catch (Exception e){
            System.err.println("Datos: Error al eliminar la consulta " + e.getMessage());
            e.printStackTrace();
        }
        assertTrue(eliminado);
    }

}

