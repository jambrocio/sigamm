package pe.com.sigamm.modelo;

public class EleccionesResumen {
	
	int codigoUt;
	String nombreUt;
	int cantidadPersonal;
	int cantidadVotos;
	int cantidadVotosBlanco;
	int cantidadFinalizados;
	int cantidadPendientes;
	String porcentajeAvance;
	
	public int getCodigoUt() {
		return codigoUt;
	}
	public void setCodigoUt(int codigoUt) {
		this.codigoUt = codigoUt;
	}
	public String getNombreUt() {
		return nombreUt;
	}
	public void setNombreUt(String nombreUt) {
		this.nombreUt = nombreUt;
	}
	public int getCantidadPersonal() {
		return cantidadPersonal;
	}
	public void setCantidadPersonal(int cantidadPersonal) {
		this.cantidadPersonal = cantidadPersonal;
	}
	public int getCantidadVotos() {
		return cantidadVotos;
	}
	public void setCantidadVotos(int cantidadVotos) {
		this.cantidadVotos = cantidadVotos;
	}
	public int getCantidadVotosBlanco() {
		return cantidadVotosBlanco;
	}
	public void setCantidadVotosBlanco(int cantidadVotosBlanco) {
		this.cantidadVotosBlanco = cantidadVotosBlanco;
	}
	public int getCantidadFinalizados() {
		return cantidadFinalizados;
	}
	public void setCantidadFinalizados(int cantidadFinalizados) {
		this.cantidadFinalizados = cantidadFinalizados;
	}
	public int getCantidadPendientes() {
		return cantidadPendientes;
	}
	public void setCantidadPendientes(int cantidadPendientes) {
		this.cantidadPendientes = cantidadPendientes;
	}
	public String getPorcentajeAvance() {
		return porcentajeAvance;
	}
	public void setPorcentajeAvance(String porcentajeAvance) {
		this.porcentajeAvance = porcentajeAvance;
	}
	
}
