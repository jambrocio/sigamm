package pe.com.sigamm.bean;

public class ServiciosDetalle {

	int codigoServico;
	String nombreServicio;
	int ordenServicio;
	int codigoServicioDetalle;
	String nombreDetalle;
	String importe;
	int obligatorio;
	int ordenDetalle;
	int seleccionado;
	
	public int getCodigoServico() {
		return codigoServico;
	}
	public void setCodigoServico(int codigoServico) {
		this.codigoServico = codigoServico;
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
	public int getCodigoServicioDetalle() {
		return codigoServicioDetalle;
	}
	public void setCodigoServicioDetalle(int codigoServicioDetalle) {
		this.codigoServicioDetalle = codigoServicioDetalle;
	}
	public String getNombreDetalle() {
		return nombreDetalle;
	}
	public void setNombreDetalle(String nombreDetalle) {
		this.nombreDetalle = nombreDetalle;
	}
	public String getImporte() {
		return importe;
	}
	public void setImporte(String importe) {
		this.importe = importe;
	}
	public int getObligatorio() {
		return obligatorio;
	}
	public void setObligatorio(int obligatorio) {
		this.obligatorio = obligatorio;
	}
	public int getOrdenDetalle() {
		return ordenDetalle;
	}
	public void setOrdenDetalle(int ordenDetalle) {
		this.ordenDetalle = ordenDetalle;
	}
	public int getSeleccionado() {
		return seleccionado;
	}
	public void setSeleccionado(int seleccionado) {
		this.seleccionado = seleccionado;
	}
		
}