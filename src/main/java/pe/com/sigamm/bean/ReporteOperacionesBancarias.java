package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.OperacionesBancarias;

public class ReporteOperacionesBancarias {
	List<OperacionesBancarias> listaOperacionesBancarias;
	int totalRegistros;
	
	public List<OperacionesBancarias> getListaOperacionesBancarias() {
		return listaOperacionesBancarias;
	}
	public void setListaOperacionesBancarias(
			List<OperacionesBancarias> listaOperacionesBancarias) {
		this.listaOperacionesBancarias = listaOperacionesBancarias;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}

}
