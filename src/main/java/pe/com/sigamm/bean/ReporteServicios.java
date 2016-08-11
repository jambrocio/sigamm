package pe.com.sigamm.bean;

import java.util.List;

public class ReporteServicios {
	
	List<ServiciosDetalle> listaServicios;
	int totalRegistros;
	
	public List<ServiciosDetalle> getListaServicios() {
		return listaServicios;
	}
	public void setListaServicios(List<ServiciosDetalle> listaServicios) {
		this.listaServicios = listaServicios;
	}
	public int getTotalRegistros() {
		return totalRegistros;
	}
	public void setTotalRegistros(int totalRegistros) {
		this.totalRegistros = totalRegistros;
	}
	
}
