package pe.com.sigamm.bean;

import java.util.List;

public class ReporteFacturacionDetalle {

	List<VistaFacturacionDetalle> listaFacturacion;
	int totalRegistros;
	
	public List<VistaFacturacionDetalle> getListaFacturacion() {
		return listaFacturacion;
	}
	public void setListaFacturacion(List<VistaFacturacionDetalle> listaFacturacion) {
		this.listaFacturacion = listaFacturacion;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
