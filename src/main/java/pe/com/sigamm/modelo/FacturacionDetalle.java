package pe.com.sigamm.modelo;

public class FacturacionDetalle {

	int codigoFacturacionDet;
	int codigoDeudaSocio;
	String monto;
	int codigoFacturacioncab;
	int codigoServicio;
	int codigoServicioDetalle;
	
	String fecPeriodo;
	String nombreDetalle;
	
	public int getCodigoFacturacionDet() {
		return codigoFacturacionDet;
	}
	public void setCodigoFacturacionDet(int codigoFacturacionDet) {
		this.codigoFacturacionDet = codigoFacturacionDet;
	}
	public int getCodigoDeudaSocio() {
		return codigoDeudaSocio;
	}
	public void setCodigoDeudaSocio(int codigoDeudaSocio) {
		this.codigoDeudaSocio = codigoDeudaSocio;
	}
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	public int getCodigoFacturacioncab() {
		return codigoFacturacioncab;
	}
	public void setCodigoFacturacioncab(int codigoFacturacioncab) {
		this.codigoFacturacioncab = codigoFacturacioncab;
	}
	public int getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(int codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public int getCodigoServicioDetalle() {
		return codigoServicioDetalle;
	}
	public void setCodigoServicioDetalle(int codigoServicioDetalle) {
		this.codigoServicioDetalle = codigoServicioDetalle;
	}
	public String getFecPeriodo() {
		return fecPeriodo;
	}
	public void setFecPeriodo(String fecPeriodo) {
		this.fecPeriodo = fecPeriodo;
	}
	public String getNombreDetalle() {
		return nombreDetalle;
	}
	public void setNombreDetalle(String nombreDetalle) {
		this.nombreDetalle = nombreDetalle;
	}
				
}
