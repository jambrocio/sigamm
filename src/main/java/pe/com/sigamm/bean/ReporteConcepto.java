package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Concepto;

public class ReporteConcepto {
	List<Concepto> listaConcepto;
	int totalRegistros;
	
	public List<Concepto> getListaConcepto() {
		return listaConcepto;
	}
	public void setListaConcepto(List<Concepto> listaConcepto) {
		this.listaConcepto = listaConcepto;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
}
