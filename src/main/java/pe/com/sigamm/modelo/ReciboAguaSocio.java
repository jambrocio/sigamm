package pe.com.sigamm.modelo;

public class ReciboAguaSocio { 
	int idRecibo;
	int codigoSocioServicio; 
	int codigoSocio; 
    int estadoSocio;
    int codigoGiro;
    int codigoReciboAgua;
    int correlativo;
    int codigoSector;
	int codigoServicioDetalle;
	int codigoServicio;
	int estado;
	int reciboAguaCreado;
	int estadoAbierto;
	int lecturaInicial;
	int lecturaFinal;
	int trabado;
	int pagado;
	int corteAgua;
	double consumoMes;
	double servicioMantenimiento;
	double deudaAnterior;
	double reconexion;
	double alcantarillado;
	double total;
    String nroPuesto;
    String nombreFull; 
    String numeroPadron; 
    String nombreGiro;
    String nombreSector;
	String nombreServicio;  
	String nombreDetalle;
	String periodoSocio;
	public int getIdRecibo() {
		return idRecibo;
	}
	public void setIdRecibo(int idRecibo) {
		this.idRecibo = idRecibo;
	}
	public int getCodigoSocioServicio() {
		return codigoSocioServicio;
	}
	public void setCodigoSocioServicio(int codigoSocioServicio) {
		this.codigoSocioServicio = codigoSocioServicio;
	}
	public int getCodigoSocio() {
		return codigoSocio;
	}
	public void setCodigoSocio(int codigoSocio) {
		this.codigoSocio = codigoSocio;
	}
	public int getEstadoSocio() {
		return estadoSocio;
	}
	public void setEstadoSocio(int estadoSocio) {
		this.estadoSocio = estadoSocio;
	}
	public int getCodigoGiro() {
		return codigoGiro;
	}
	public void setCodigoGiro(int codigoGiro) {
		this.codigoGiro = codigoGiro;
	}
	public int getCodigoReciboAgua() {
		return codigoReciboAgua;
	}
	public void setCodigoReciboAgua(int codigoReciboAgua) {
		this.codigoReciboAgua = codigoReciboAgua;
	}
	public int getCorrelativo() {
		return correlativo;
	}
	public void setCorrelativo(int correlativo) {
		this.correlativo = correlativo;
	}
	public int getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(int codigoSector) {
		this.codigoSector = codigoSector;
	}
	public int getCodigoServicioDetalle() {
		return codigoServicioDetalle;
	}
	public void setCodigoServicioDetalle(int codigoServicioDetalle) {
		this.codigoServicioDetalle = codigoServicioDetalle;
	}
	public int getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(int codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getReciboAguaCreado() {
		return reciboAguaCreado;
	}
	public void setReciboAguaCreado(int reciboAguaCreado) {
		this.reciboAguaCreado = reciboAguaCreado;
	}
	public int getEstadoAbierto() {
		return estadoAbierto;
	}
	public void setEstadoAbierto(int estadoAbierto) {
		this.estadoAbierto = estadoAbierto;
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
	public int getTrabado() {
		return trabado;
	}
	public void setTrabado(int trabado) {
		this.trabado = trabado;
	}
	public int getPagado() {
		return pagado;
	}
	public void setPagado(int pagado) {
		this.pagado = pagado;
	}
	public int getCorteAgua() {
		return corteAgua;
	}
	public void setCorteAgua(int corteAgua) {
		this.corteAgua = corteAgua;
	}
	public double getConsumoMes() {
		return consumoMes;
	}
	public void setConsumoMes(double consumoMes) {
		this.consumoMes = consumoMes;
	}
	public double getServicioMantenimiento() {
		return servicioMantenimiento;
	}
	public void setServicioMantenimiento(double servicioMantenimiento) {
		this.servicioMantenimiento = servicioMantenimiento;
	}
	public double getDeudaAnterior() {
		return deudaAnterior;
	}
	public void setDeudaAnterior(double deudaAnterior) {
		this.deudaAnterior = deudaAnterior;
	}
	public double getReconexion() {
		return reconexion;
	}
	public void setReconexion(double reconexion) {
		this.reconexion = reconexion;
	}
	public double getAlcantarillado() {
		return alcantarillado;
	}
	public void setAlcantarillado(double alcantarillado) {
		this.alcantarillado = alcantarillado;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getNroPuesto() {
		return nroPuesto;
	}
	public void setNroPuesto(String nroPuesto) {
		this.nroPuesto = nroPuesto;
	}
	public String getNombreFull() {
		return nombreFull;
	}
	public void setNombreFull(String nombreFull) {
		this.nombreFull = nombreFull;
	}
	public String getNumeroPadron() {
		return numeroPadron;
	}
	public void setNumeroPadron(String numeroPadron) {
		this.numeroPadron = numeroPadron;
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
	public String getNombreServicio() {
		return nombreServicio;
	}
	public void setNombreServicio(String nombreServicio) {
		this.nombreServicio = nombreServicio;
	}
	public String getNombreDetalle() {
		return nombreDetalle;
	}
	public void setNombreDetalle(String nombreDetalle) {
		this.nombreDetalle = nombreDetalle;
	}
	public String getPeriodoSocio() {
		return periodoSocio;
	}
	public void setPeriodoSocio(String periodoSocio) {
		this.periodoSocio = periodoSocio;
	}
	
}
