package pe.com.sigamm.session;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

@Component
@Scope(value="session" ,proxyMode=ScopedProxyMode.TARGET_CLASS)
public class DatosSession {

	String usuario;
	String nombresFull;
	String nombreRol;
	int codigoRol;
	int codigoUsuario;
	int codigoInstitucion;
	String nombreInstitucion;
	String listaMenu;
	String clave;
	int codigoUt;
	String nombreUt;
	String serie;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getNombresFull() {
		return nombresFull;
	}
	public void setNombresFull(String nombresFull) {
		this.nombresFull = nombresFull;
	}
	public String getNombreRol() {
		return nombreRol;
	}
	public void setNombreRol(String nombreRol) {
		this.nombreRol = nombreRol;
	}
	public int getCodigoRol() {
		return codigoRol;
	}
	public void setCodigoRol(int codigoRol) {
		this.codigoRol = codigoRol;
	}
	public int getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(int codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public int getCodigoInstitucion() {
		return codigoInstitucion;
	}
	public void setCodigoInstitucion(int codigoInstitucion) {
		this.codigoInstitucion = codigoInstitucion;
	}
	public String getNombreInstitucion() {
		return nombreInstitucion;
	}
	public void setNombreInstitucion(String nombreInstitucion) {
		this.nombreInstitucion = nombreInstitucion;
	}
	public String getListaMenu() {
		return listaMenu;
	}
	public void setListaMenu(String listaMenu) {
		this.listaMenu = listaMenu;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public int getCodigoUt() {
		return codigoUt;
	}
	public void setCodigoUt(int codigoUt) {
		this.codigoUt = codigoUt;
	}
	public String getNombreUt() {
		return nombreUt;
	}
	public void setNombreUt(String nombreUt) {
		this.nombreUt = nombreUt;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
		
}
