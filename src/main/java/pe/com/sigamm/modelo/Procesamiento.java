package pe.com.sigamm.modelo;

public class Procesamiento {
	
	int codigoProcesamiento;
	String periodo;
	int flagCuotaAdministrativa;
	int flagVigilancia;
	int estado;
	int usuarioCreacion;
	String fechaCreacion;
	String fechaVencimiento;
	String descripcionPeriodo;
	int flagImpresion;
	
	public int getCodigoProcesamiento() {
		return codigoProcesamiento;
	}
	public void setCodigoProcesamiento(int codigoProcesamiento) {
		this.codigoProcesamiento = codigoProcesamiento;
	}
	public String getPeriodo() {
		return periodo;
	}
	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}
	public int getFlagCuotaAdministrativa() {
		return flagCuotaAdministrativa;
	}
	public void setFlagCuotaAdministrativa(int flagCuotaAdministrativa) {
		this.flagCuotaAdministrativa = flagCuotaAdministrativa;
	}
	public int getFlagVigilancia() {
		return flagVigilancia;
	}
	public void setFlagVigilancia(int flagVigilancia) {
		this.flagVigilancia = flagVigilancia;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public int getUsuarioCreacion() {
		return usuarioCreacion;
	}
	public void setUsuarioCreacion(int usuarioCreacion) {
		this.usuarioCreacion = usuarioCreacion;
	}
	public String getFechaCreacion() {
		return fechaCreacion;
	}
	public void setFechaCreacion(String fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}
	public String getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public String getDescripcionPeriodo() {
		return descripcionPeriodo;
	}
	public void setDescripcionPeriodo(String descripcionPeriodo) {
		this.descripcionPeriodo = descripcionPeriodo;
	}
	public int getFlagImpresion() {
		return flagImpresion;
	}
	public void setFlagImpresion(int flagImpresion) {
		this.flagImpresion = flagImpresion;
	}
				
}
