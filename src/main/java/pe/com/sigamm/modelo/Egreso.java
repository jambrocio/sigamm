package pe.com.sigamm.modelo;

import java.sql.Date;

public class Egreso {
	int codigo_egreso;
	int tipo_documento;
	String numero_documento;
	String ruc;
	Date fecha;
	int codigo_empresa;
	String detalle;
	double total;
	String representante;
	
	public int getCodigo_egreso() {
		return codigo_egreso;
	}
	public void setCodigo_egreso(int codigo_egreso) {
		this.codigo_egreso = codigo_egreso;
	}
	public int getTipo_documento() {
		return tipo_documento;
	}
	public void setTipo_documento(int tipo_documento) {
		this.tipo_documento = tipo_documento;
	}
	public String getNumero_documento() {
		return numero_documento;
	}
	public void setNumero_documento(String numero_documento) {
		this.numero_documento = numero_documento;
	}
	public String getRuc() {
		return ruc;
	}
	public void setRuc(String ruc) {
		this.ruc = ruc;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public int getCodigo_empresa() {
		return codigo_empresa;
	}
	public void setCodigo_empresa(int codigo_empresa) {
		this.codigo_empresa = codigo_empresa;
	}
	public String getDetalle() {
		return detalle;
	}
	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getRepresentante() {
		return representante;
	}
	public void setRepresentante(String representante) {
		this.representante = representante;
	}

}
