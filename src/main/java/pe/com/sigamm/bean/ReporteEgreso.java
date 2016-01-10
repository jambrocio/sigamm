package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Egreso;

public class ReporteEgreso {
	List<Egreso> listaEgreso;
	int totalRegistros;
	
	public List<Egreso> getListaEgreso() {
		return listaEgreso;
	}
	public void setListaEgreso(List<Egreso> listaEgreso) {
		this.listaEgreso = listaEgreso;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
