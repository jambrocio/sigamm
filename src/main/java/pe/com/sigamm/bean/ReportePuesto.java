package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Puesto;

public class ReportePuesto {
	
	List<Puesto> listaPuesto;
	int totalRegistros;
	
	public List<Puesto> getListaPuesto() {
		return listaPuesto;
	}
	public void setListaPuesto(List<Puesto> listaPuesto) {
		this.listaPuesto = listaPuesto;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
