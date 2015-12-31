package pe.com.sigamm.modelo;

public class Concepto {

	int codigoConcepto;
	String nombreConcepto;
	int estado;
	String rubro;
	
	public int getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(int codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getNombreConcepto() {
		return nombreConcepto;
	}
	public void setNombreConcepto(String nombreConcepto) {
		this.nombreConcepto = nombreConcepto;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public String getRubro() {
		return rubro;
	}
	public void setRubro(String rubro) {
		this.rubro = rubro;
	}

}
