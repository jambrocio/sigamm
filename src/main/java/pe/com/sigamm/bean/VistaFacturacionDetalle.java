package pe.com.sigamm.bean;

public class VistaFacturacionDetalle {
	
	int codigoFacturacionCab;
	String nombreDetalle;
	String fecPeriodo;
	String monto;
	
	public int getCodigoFacturacionCab() {
		return codigoFacturacionCab;
	}
	public void setCodigoFacturacionCab(int codigoFacturacionCab) {
		this.codigoFacturacionCab = codigoFacturacionCab;
	}
	public String getNombreDetalle() {
		return nombreDetalle;
	}
	public void setNombreDetalle(String nombreDetalle) {
		this.nombreDetalle = nombreDetalle;
	}
	public String getFecPeriodo() {
		return fecPeriodo;
	}
	public void setFecPeriodo(String fecPeriodo) {
		this.fecPeriodo = fecPeriodo;
	}
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	
}
