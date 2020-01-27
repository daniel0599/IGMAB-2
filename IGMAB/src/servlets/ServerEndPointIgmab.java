package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

//import javax.ejb.Singleton;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/serverendpointigmab")
//@Singleton
public class ServerEndPointIgmab {
	static final Logger LOGGER = Logger.getLogger(ServerEndpoint.class.getName());
	static final List<Session> conexiones = new ArrayList<>();
	
	@OnOpen
	public void handleopen(Session session) {
		// TODO Auto-generated method stub
		System.out.println("La conexion ya esta abierta...");
		LOGGER.info("Iniciando conexion");
		conexiones.add(session);
	}
	
	@OnClose
	public void handleClose(Session session) {
		// TODO Auto-generated method stub
		System.out.println("Conexion cerrada...");
		LOGGER.info("Terminando la conexion");
		if (conexiones.contains(session)) { // se averigua si est� en la colecci�n
            try 
            {
                LOGGER.log(Level.INFO, "Terminando la conexion de {0}", session.getId());
                session.close(); //se cierra la conexi�n
                conexiones.remove(session); // se retira de la lista
            } catch (IOException ex) {
                LOGGER.log(Level.SEVERE, null, ex);
            }
        }
	}
	
	@OnError
	public void handleError(Throwable throwable) {
		// TODO Auto-generated method stub
		System.out.println("Error inesperado...");
	}
	
	@OnMessage
	public String HandlerMessages(String message, Session session) 
	{
		// TODO Auto-generated method stub
		System.out.println("Mensaje recibido desde el cliente: " + message);
		String replayMessage = "echo " + message;	
		System.out.println("Enviar al cliente: " + 	replayMessage);
		LOGGER.log(Level.INFO, "Recibiendo mensaje:{0}", message);
		
		String mensaje = "Son las " + (new Date()) + " y hay " + conexiones.size() + " conectados ";  // el mensaje a enviar
		
		for (Session sesion : conexiones) { //recorro toda la lista de conectados
            RemoteEndpoint.Basic remote = sesion.getBasicRemote(); //tomo la conexion remota con el cliente...
            try {
                remote.sendText(mensaje); //... y env�o el mensaje
                System.out.println(mensaje);
            } catch (IOException ex) {
                LOGGER.log(Level.WARNING, null, ex);
            }
        }
		
		return replayMessage;
	}
	
	//@Schedule(second = "*/10", minute = "*", hour = "*", persistent = false)
	/*public void notificar() {
        LOGGER.log(Level.INFO, "Enviando notificacion a {0} conectados", conexiones.size());
        String mensaje = "Son las " + (new Date()) + " y hay " + conexiones.size() + " conectados ";  // el mensaje a enviar
        System.out.println("enviar a todos");
        for (Session sesion : conexiones) { //recorro toda la lista de conectados
            RemoteEndpoint.Basic remote = sesion.getBasicRemote(); //tomo la conexion remota con el cliente...
            try {
                remote.sendText(mensaje); //... y env�o el mensajue
            } catch (IOException ex) {
                LOGGER.log(Level.WARNING, null, ex);
            }
        }
 
    }*/

}
