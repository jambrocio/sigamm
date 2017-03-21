package pe.com.sigamm.bean;

import java.util.List;

import pe.com.sigamm.modelo.Procesamiento;

public class ReporteProcesamiento {
	
	List<Procesamiento> listaProcesamiento;
	int totalRegistros;
	
	public List<Procesamiento> getListaProcesamiento() {
		return listaProcesamiento;
	}
	public void setListaProcesamiento(List<Procesamiento> listaProcesamiento) {
		this.listaProcesamiento = listaProcesamiento;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
