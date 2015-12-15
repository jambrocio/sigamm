package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.ReciboAguaSocio;

public class ReporteReciboAguaSocio {

	List<ReciboAguaSocio> listaReciboAguaSocio;
	int totalRegistros;
	
	public List<ReciboAguaSocio> getListaReciboAguaSocio() {
		return listaReciboAguaSocio;
	}
	public void setListaReciboAguaSocio(List<ReciboAguaSocio> listaReciboAguaSocio) {
		this.listaReciboAguaSocio = listaReciboAguaSocio;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
