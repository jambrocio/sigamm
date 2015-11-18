package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Socio;

public class ReporteSocio {
	
	List<Socio> listaSocio;
	int totalRegistros;
	
	public List<Socio> getListaSocio() {
		return listaSocio;
	}
	public void setListaSocio(List<Socio> listaSocio) {
		this.listaSocio = listaSocio;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
		
}
