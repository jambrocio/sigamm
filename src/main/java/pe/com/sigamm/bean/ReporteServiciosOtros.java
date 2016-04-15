package pe.com.sigamm.bean;

import java.util.List;

public class ReporteServiciosOtros {

	List<ListaServiciosOtros> listaServiciosOtros;
	int totalRegistros;
	
	public List<ListaServiciosOtros> getListaServiciosOtros() {
		return listaServiciosOtros;
	}
	public void setListaServiciosOtros(List<ListaServiciosOtros> listaServiciosOtros) {
		this.listaServiciosOtros = listaServiciosOtros;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
