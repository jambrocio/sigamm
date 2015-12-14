package pe.com.sigamm.modelo;

import java.util.Date;

public class ReciboLuzSocio {
	
	int codigoSocio;
	int codigoRecibo;
	int correlativo;
	int lecturaInicial;
	int lecturaFinal;
	int consumoMes;
	double cargoFijo;
	double alumbradoPublico;
	double cargoEnergia;
	double subtotalMes;
	double igv;
	double totalMes;
	double usoEquipo;
	double servicioMantenimiento;
	double aporteLey;
	double reconexion;
	double recargo;
	double redondeo;
	double total;
	double deudaAnterior;
	int estado;
	Date fechaCarga;
	int reciboLuzCreado;
	String puestoSocio;
	String nombreFull;
	String nombreGiro;
	String nombreSector;
	String fecPeriodo;
	double costoWatts;
	Socio socio;
	
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
	public int getCorrelativo() {
		return correlativo;
	}
	public void setCorrelativo(int correlativo) {
		this.correlativo = correlativo;
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
	public int getConsumoMes() {
		return consumoMes;
	}
	public void setConsumoMes(int consumoMes) {
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
	public double getReconexion() {
		return reconexion;
	}
	public void setReconexion(double reconexion) {
		this.reconexion = reconexion;
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
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public Date getFechaCarga() {
		return fechaCarga;
	}
	public void setFechaCarga(Date fechaCarga) {
		this.fechaCarga = fechaCarga;
	}
	public int getReciboLuzCreado() {
		return reciboLuzCreado;
	}
	public void setReciboLuzCreado(int reciboLuzCreado) {
		this.reciboLuzCreado = reciboLuzCreado;
	}
	public String getPuestoSocio() {
		return puestoSocio;
	}
	public void setPuestoSocio(String puestoSocio) {
		this.puestoSocio = puestoSocio;
	}
	public Socio getSocio() {
		return socio;
	}
	public void setSocio(Socio socio) {
		this.socio = socio;
	}
	public String getNombreFull() {
		return nombreFull;
	}
	public void setNombreFull(String nombreFull) {
		this.nombreFull = nombreFull;
	}
	public String getNombreGiro() {
		return nombreGiro;
	}
	public void setNombreGiro(String nombreGiro) {
		this.nombreGiro = nombreGiro;
	}
	public String getNombreSector() {
		return nombreSector;
	}
	public void setNombreSector(String nombreSector) {
		this.nombreSector = nombreSector;
	}
	public String getFecPeriodo() {
		return fecPeriodo;
	}
	public void setFecPeriodo(String fecPeriodo) {
		this.fecPeriodo = fecPeriodo;
	}
	public double getCostoWatts() {
		return costoWatts;
	}
	public void setCostoWatts(double costoWatts) {
		this.costoWatts = costoWatts;
	}

}
