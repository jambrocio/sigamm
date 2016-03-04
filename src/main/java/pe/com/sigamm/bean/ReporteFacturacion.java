package pe.com.sigamm.bean;

import java.util.List;

public class ReporteFacturacion {
	
	List<VistaFacturacion> listaFacturacion;
	int totalRegistros;
	
	public List<VistaFacturacion> getListaFacturacion() {
		return listaFacturacion;
	}
	public void setListaFacturacion(List<VistaFacturacion> listaFacturacion) {
		this.listaFacturacion = listaFacturacion;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
		
}
