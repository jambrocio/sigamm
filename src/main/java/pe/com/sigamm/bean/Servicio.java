package pe.com.sigamm.bean;

import java.util.List;

public class Servicio {

	int codigoServicio;
	String nombreServicio;
	int ordenServicio;
	List<DetalleServicio> detalle;
	
	public int getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(int codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getNombreServicio() {
		return nombreServicio;
	}
	public void setNombreServicio(String nombreServicio) {
		this.nombreServicio = nombreServicio;
	}
	public int getOrdenServicio() {
		return ordenServicio;
	}
	public void setOrdenServicio(int ordenServicio) {
		this.ordenServicio = ordenServicio;
	}
	public List<DetalleServicio> getDetalle() {
		return detalle;
	}
	public void setDetalle(List<DetalleServicio> detalle) {
		this.detalle = detalle;
	}
	
}
