package entidades;

import java.util.Date;

/**
 * Usuarios del sistema
 * @author Gang of Seven
 * @version 1.0
 * @created 12-Feb-2017 11:17:18 AM
 */
public class Usuario {
	
	private int eliminado;
	/**
	 * ID correspondiente al usuario.
	 */
	private int UsuarioID;
	/**
	 * Contraseña correspondiente al usuario.
	 */
	private String contrasena;
	/**
	 * Nombre de usuario.
	 */
	private String usuario;
	
	/**
	 *  Fecha en que se crea el registro.
	 */
	private Date fechaCreacion;
	
	/**
	 *  Fecha en que se elimina el registro.
	 */
	private Date fechaEliminacion;
	
	/**
	 *  Fecha en que se modifica el registro.
	 */
	private Date fechaModificacion;
	
	/**
	 *  Usuario que crea el registro.
	 */
	private int usuarioCreacion;
	
	/**
	 *  Usuario que elimina el registro.
	 */
	private int usuarioEliminacion;
	
	/**
	 *  Usuario que modificacion el registro.
	 */
	private int usuarioModificacion;
			
	
	public Usuario(){

	}
	
	
	
	public int getEliminado() {
		return eliminado;
	}



	public void setEliminado(int eliminado) {
		this.eliminado = eliminado;
	}



	public int getUsuarioID() {
		return UsuarioID;
	}



	public void setUsuarioID(int usuarioID) {
		UsuarioID = usuarioID;
	}



	public String getContrasena() {
		return contrasena;
	}


	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}


	public String getUsuario() {
		return usuario;
	}


	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	public Date getFechaCreacion() {
		return fechaCreacion;
	}


	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}


	public Date getFechaEliminacion() {
		return fechaEliminacion;
	}


	public void setFechaEliminacion(Date fechaEliminacion) {
		this.fechaEliminacion = fechaEliminacion;
	}


	public Date getFechaModificacion() {
		return fechaModificacion;
	}


	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}


	public int getUsuarioCreacion() {
		return usuarioCreacion;
	}


	public void setUsuarioCreacion(int usuarioCreacion) {
		this.usuarioCreacion = usuarioCreacion;
	}


	public int getUsuarioEliminacion() {
		return usuarioEliminacion;
	}


	public void setUsuarioEliminacion(int usuarioEliminacion) {
		this.usuarioEliminacion = usuarioEliminacion;
	}


	public int getUsuarioModificacion() {
		return usuarioModificacion;
	}


	public void setUsuarioModificacion(int usuarioModificacion) {
		this.usuarioModificacion = usuarioModificacion;
	}


	public void finalize() throws Throwable {

	}

}