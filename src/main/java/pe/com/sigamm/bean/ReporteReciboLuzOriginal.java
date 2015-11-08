package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.LuzOriginal;

public class ReporteReciboLuzOriginal {
	
	List<LuzOriginal> listaReciboLuzOriginal;
	int totalRegistros;
	
	public List<LuzOriginal> getListaReciboLuzOriginal() {
		return listaReciboLuzOriginal;
	}
	public void setListaReciboLuzOriginal(List<LuzOriginal> listaReciboLuzOriginal) {
		this.listaReciboLuzOriginal = listaReciboLuzOriginal;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}

}
