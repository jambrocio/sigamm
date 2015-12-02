package pe.com.sigamm.modelo;

public class Puesto {

	int codigoPuesto;
	int codigoUsuario;
	int codigoGiro;
	int codigoReciboOriginal;
	int codigoSector;
	String nombreSector;
	String nroPuesto;
	String dni;
	String nombreFull;
	String nombreGiro;
	int reciboLuz;
	double total;
	int reciboLuzCreado;
	
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
	public int getCodigoReciboOriginal() {
		return codigoReciboOriginal;
	}
	public void setCodigoReciboOriginal(int codigoReciboOriginal) {
		this.codigoReciboOriginal = codigoReciboOriginal;
	}
	public int getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(int codigoSector) {
		this.codigoSector = codigoSector;
	}
	public String getNombreSector() {
		return nombreSector;
	}
	public void setNombreSector(String nombreSector) {
		this.nombreSector = nombreSector;
	}
	
}
