package pe.com.sigamm.bean;

public class Usuario {
	
	String usuario;
	String clave;
	int codigoInstitucion;
	String ipRemote;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public int getCodigoInstitucion() {
		return codigoInstitucion;
	}
	public void setCodigoInstitucion(int codigoInstitucion) {
		this.codigoInstitucion = codigoInstitucion;
	}
	public String getIpRemote() {
		return ipRemote;
	}
	public void setIpRemote(String ipRemote) {
		this.ipRemote = ipRemote;
	}
	
}
