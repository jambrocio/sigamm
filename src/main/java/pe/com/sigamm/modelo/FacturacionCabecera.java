package pe.com.sigamm.modelo;

public class FacturacionCabecera {

	int codigoFacturacionCab;
	int codigoUsuario;
	String serie;
	String secuencia;
	int estado;
	String facturacionDetalle;
	
	public int getCodigoFacturacionCab() {
		return codigoFacturacionCab;
	}
	public void setCodigoFacturacionCab(int codigoFacturacionCab) {
		this.codigoFacturacionCab = codigoFacturacionCab;
	}
	public int getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(int codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public String getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(String secuencia) {
		this.secuencia = secuencia;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public String getFacturacionDetalle() {
		return facturacionDetalle;
	}
	public void setFacturacionDetalle(String facturacionDetalle) {
		this.facturacionDetalle = facturacionDetalle;
	}
		
}
