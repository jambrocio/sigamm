package pe.com.sigamm.modelo;

import java.util.List;

public class Facturacion {
	
	FacturacionCabecera cabecera;
	List<FacturacionDetalle> detalle;
	
	public FacturacionCabecera getCabecera() {
		return cabecera;
	}
	public void setCabecera(FacturacionCabecera cabecera) {
		this.cabecera = cabecera;
	}
	public List<FacturacionDetalle> getDetalle() {
		return detalle;
	}
	public void setDetalle(List<FacturacionDetalle> detalle) {
		this.detalle = detalle;
	}
	
}
