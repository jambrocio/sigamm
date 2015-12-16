package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.ReciboAgua;

public class ReporteReciboAgua {

	List<ReciboAgua> listaReciboAgua;
	int totalRegistros;
	
	public List<ReciboAgua> getListaReciboAgua() {
		return listaReciboAgua;
	}
	public void setListaReciboAgua(List<ReciboAgua> listaReciboAgua) {
		this.listaReciboAgua = listaReciboAgua;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	

}
