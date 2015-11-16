package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.ReciboLuzSocio;

public class ReporteReciboLuzSocio {

	List<ReciboLuzSocio> listaReciboLuzSocio;
	int totalRegistros;
	
	public List<ReciboLuzSocio> getListaReciboLuzSocio() {
		return listaReciboLuzSocio;
	}
	public void setListaReciboLuzSocio(List<ReciboLuzSocio> listaReciboLuzSocio) {
		this.listaReciboLuzSocio = listaReciboLuzSocio;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
