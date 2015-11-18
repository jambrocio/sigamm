package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;

public interface PuestoBus {

	public List<GiroComercial> listaGiroComercial();
	
	public Retorno grabarPuesto(Puesto puesto);
	
	public ReportePuesto reportePuesto(int pagina, int registros, String dni);
	
	public ReportePuesto reportePuestoLuz(int pagina, int registros, int codigoPuesto, int codigoRecibo);
	
	public ReportePuesto reportePuestoxPto(int pagina, int registros, String codigoPuesto);
	
	public Retorno eliminarPuesto(Puesto puesto);
	
}
