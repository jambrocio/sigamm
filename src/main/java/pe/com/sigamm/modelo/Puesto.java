package pe.com.sigamm.modelo;

public class Puesto {
	int codigoSocio;
	int codigoPuesto;
	int codigoUsuario;
	int codigoGiro;
	int codigoReciboOriginal;
	int codigoReciboAgua;
	int codigoSector;
	int estadoReciboLuz;
	String nombreSector;
	String nroPuesto;
	String dni;
	String nombreFull;
	String nombreGiro;
	int reciboLuz;
	double total;
	int reciboLuzCreado;
	int pagado;
	int reciboAguaCreado;
	int codigoServicioDetalle;
	String periodoSocio;
	double numCostoWatts;
	double alumbradoPublico;
	double mantenimiento;
	double cableadoPrincipal;
	int estadoAbierto;
	int suspendido;
	String lecturaInicial;
	String lecturaFinal;
	int idRecibo;
	
	public int getCodigoSocio() {
		return codigoSocio;
	}
	public void setCodigoSocio(int codigoSocio) {
		this.codigoSocio = codigoSocio;
	}
	public int getCodigoPuesto() {
		return codigoPuesto;
	}
	public void setCodigoPuesto(int codigoPuesto) {
		this.codigoPuesto = codigoPuesto;
	}
	public int getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(int codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public int getCodigoGiro() {
		return codigoGiro;
	}
	public void setCodigoGiro(int codigoGiro) {
		this.codigoGiro = codigoGiro;
	}
	public int getCodigoReciboOriginal() {
		return codigoReciboOriginal;
	}
	public void setCodigoReciboOriginal(int codigoReciboOriginal) {
		this.codigoReciboOriginal = codigoReciboOriginal;
	}
	public int getCodigoReciboAgua() {
		return codigoReciboAgua;
	}
	public void setCodigoReciboAgua(int codigoReciboAgua) {
		this.codigoReciboAgua = codigoReciboAgua;
	}
	public int getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(int codigoSector) {
		this.codigoSector = codigoSector;
	}
	public int getEstadoReciboLuz() {
		return estadoReciboLuz;
	}
	public void setEstadoReciboLuz(int estadoReciboLuz) {
		this.estadoReciboLuz = estadoReciboLuz;
	}
	public String getNombreSector() {
		return nombreSector;
	}
	public void setNombreSector(String nombreSector) {
		this.nombreSector = nombreSector;
	}
	public String getNroPuesto() {
		return nroPuesto;
	}
	public void setNroPuesto(String nroPuesto) {
		this.nroPuesto = nroPuesto;
	}
	public String getDni() {
		return dni;
	}
	public void setDni(String dni) {
		this.dni = dni;
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
	public int getReciboLuz() {
		return reciboLuz;
	}
	public void setReciboLuz(int reciboLuz) {
		this.reciboLuz = reciboLuz;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public int getReciboLuzCreado() {
		return reciboLuzCreado;
	}
	public void setReciboLuzCreado(int reciboLuzCreado) {
		this.reciboLuzCreado = reciboLuzCreado;
	}
	public int getPagado() {
		return pagado;
	}
	public void setPagado(int pagado) {
		this.pagado = pagado;
	}
	public int getReciboAguaCreado() {
		return reciboAguaCreado;
	}
	public void setReciboAguaCreado(int reciboAguaCreado) {
		this.reciboAguaCreado = reciboAguaCreado;
	}
	public int getCodigoServicioDetalle() {
		return codigoServicioDetalle;
	}
	public void setCodigoServicioDetalle(int codigoServicioDetalle) {
		this.codigoServicioDetalle = codigoServicioDetalle;
	}
	public String getPeriodoSocio() {
		return periodoSocio;
	}
	public void setPeriodoSocio(String periodoSocio) {
		this.periodoSocio = periodoSocio;
	}
	public double getNumCostoWatts() {
		return numCostoWatts;
	}
	public void setNumCostoWatts(double numCostoWatts) {
		this.numCostoWatts = numCostoWatts;
	}
	public double getAlumbradoPublico() {
		return alumbradoPublico;
	}
	public void setAlumbradoPublico(double alumbradoPublico) {
		this.alumbradoPublico = alumbradoPublico;
	}
	public double getMantenimiento() {
		return mantenimiento;
	}
	public void setMantenimiento(double mantenimiento) {
		this.mantenimiento = mantenimiento;
	}
	public double getCableadoPrincipal() {
		return cableadoPrincipal;
	}
	public void setCableadoPrincipal(double cableadoPrincipal) {
		this.cableadoPrincipal = cableadoPrincipal;
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
	public String getLecturaInicial() {
		return lecturaInicial;
	}
	public void setLecturaInicial(String lecturaInicial) {
		this.lecturaInicial = lecturaInicial;
	}
	public String getLecturaFinal() {
		return lecturaFinal;
	}
	public void setLecturaFinal(String lecturaFinal) {
		this.lecturaFinal = lecturaFinal;
	}
	public int getIdRecibo() {
		return idRecibo;
	}
	public void setIdRecibo(int idRecibo) {
		this.idRecibo = idRecibo;
	}
	
}
