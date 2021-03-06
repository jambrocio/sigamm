package pe.com.sigamm.modelo;

public class ReciboAgua {
	int codigoRecibo;
	int lecturaInicial;
	int lecturaFinal;
	double monto;
	String fechaCorte;
	String fechaVencimiento;
	String periodo;
	String observaciones;
	int estado;
	int estadoAbierto;
	int suspendido;
	
	public int getCodigoRecibo() {
		return codigoRecibo;
	}
	public void setCodigoRecibo(int codigoRecibo) {
		this.codigoRecibo = codigoRecibo;
	}
	public int getLecturaInicial() {
		return lecturaInicial;
	}
	public void setLecturaInicial(int lecturaInicial) {
		this.lecturaInicial = lecturaInicial;
	}
	public int getLecturaFinal() {
		return lecturaFinal;
	}
	public void setLecturaFinal(int lecturaFinal) {
		this.lecturaFinal = lecturaFinal;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}
	public String getFechaCorte() {
		return fechaCorte;
	}
	public void setFechaCorte(String fechaCorte) {
		this.fechaCorte = fechaCorte;
	}
	public String getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public String getPeriodo() {
		return periodo;
	}
	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getEstadoAbierto() {
		return estadoAbierto;
	}
	public void setEstadoAbierto(int estadoAbierto) {
		this.estadoAbierto = estadoAbierto;
	}
	public int getSuspendido() {
		return suspendido;
	}
	public void setSuspendido(int suspendido) {
		this.suspendido = suspendido;
	}
	
}
