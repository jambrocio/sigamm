package pe.com.sigamm.modelo;

import java.util.Date;

public class ReciboLuzSocio {
	
	int codigoSocio;
	int codigoRecibo;
	int lecturaInicial;
	int lecturaFinal;
	double consumoMes;
	double cargoFijo;
	double alumbradoPublico;
	double cargoEnergia;
	double subtotalMes;
	double igv;
	double totalMes;
	double usoEquipo;
	double servicioMantenimiento;
	double aporteLey;
	double recargo;
	double redondeo;
	double total;
	double deudaAnterior;
	double estado;
	Date fechaCarga;
	
	public int getCodigoSocio() {
		return codigoSocio;
	}
	public void setCodigoSocio(int codigoSocio) {
		this.codigoSocio = codigoSocio;
	}
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
	public double getConsumoMes() {
		return consumoMes;
	}
	public void setConsumoMes(double consumoMes) {
		this.consumoMes = consumoMes;
	}
	public double getCargoFijo() {
		return cargoFijo;
	}
	public void setCargoFijo(double cargoFijo) {
		this.cargoFijo = cargoFijo;
	}
	public double getAlumbradoPublico() {
		return alumbradoPublico;
	}
	public void setAlumbradoPublico(double alumbradoPublico) {
		this.alumbradoPublico = alumbradoPublico;
	}
	public double getCargoEnergia() {
		return cargoEnergia;
	}
	public void setCargoEnergia(double cargoEnergia) {
		this.cargoEnergia = cargoEnergia;
	}
	public double getSubtotalMes() {
		return subtotalMes;
	}
	public void setSubtotalMes(double subtotalMes) {
		this.subtotalMes = subtotalMes;
	}
	public double getIgv() {
		return igv;
	}
	public void setIgv(double igv) {
		this.igv = igv;
	}
	public double getTotalMes() {
		return totalMes;
	}
	public void setTotalMes(double totalMes) {
		this.totalMes = totalMes;
	}
	public double getUsoEquipo() {
		return usoEquipo;
	}
	public void setUsoEquipo(double usoEquipo) {
		this.usoEquipo = usoEquipo;
	}
	public double getServicioMantenimiento() {
		return servicioMantenimiento;
	}
	public void setServicioMantenimiento(double servicioMantenimiento) {
		this.servicioMantenimiento = servicioMantenimiento;
	}
	public double getAporteLey() {
		return aporteLey;
	}
	public void setAporteLey(double aporteLey) {
		this.aporteLey = aporteLey;
	}
	public double getRecargo() {
		return recargo;
	}
	public void setRecargo(double recargo) {
		this.recargo = recargo;
	}
	public double getRedondeo() {
		return redondeo;
	}
	public void setRedondeo(double redondeo) {
		this.redondeo = redondeo;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public double getDeudaAnterior() {
		return deudaAnterior;
	}
	public void setDeudaAnterior(double deudaAnterior) {
		this.deudaAnterior = deudaAnterior;
	}
	public double getEstado() {
		return estado;
	}
	public void setEstado(double estado) {
		this.estado = estado;
	}
	public Date getFechaCarga() {
		return fechaCarga;
	}
	public void setFechaCarga(Date fechaCarga) {
		this.fechaCarga = fechaCarga;
	}

}
