package pe.com.sigamm.modelo;

public class DeudaSocio {
	
	int codigoDeudaSocio;
	int codigoServicioDetalle;
	String importe;
	String fecPeriodo;
	int codigoSocio;
	int flagImporteVariable;
	
	public int getCodigoDeudaSocio() {
		return codigoDeudaSocio;
	}
	public void setCodigoDeudaSocio(int codigoDeudaSocio) {
		this.codigoDeudaSocio = codigoDeudaSocio;
	}
	public int getCodigoServicioDetalle() {
		return codigoServicioDetalle;
	}
	public void setCodigoServicioDetalle(int codigoServicioDetalle) {
		this.codigoServicioDetalle = codigoServicioDetalle;
	}
	public String getImporte() {
		return importe;
	}
	public void setImporte(String importe) {
		this.importe = importe;
	}
	public String getFecPeriodo() {
		return fecPeriodo;
	}
	public void setFecPeriodo(String fecPeriodo) {
		this.fecPeriodo = fecPeriodo;
	}
	public int getCodigoSocio() {
		return codigoSocio;
	}
	public void setCodigoSocio(int codigoSocio) {
		this.codigoSocio = codigoSocio;
	}
	public int getFlagImporteVariable() {
		return flagImporteVariable;
	}
	public void setFlagImporteVariable(int flagImporteVariable) {
		this.flagImporteVariable = flagImporteVariable;
	}
	
}
