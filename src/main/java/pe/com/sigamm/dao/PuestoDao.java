package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;

public interface PuestoDao {

	public List<GiroComercial> listaGiroComercial();
	
	public Retorno grabarPuesto(Puesto puesto);
	
	public ReportePuesto reportePuesto(int pagina, int registros, String dni);
	
	public Retorno eliminarPuesto(Puesto puesto);
	
	public ReportePuesto reportePuestoLuz(int pagina, int registros, String codigoPuesto, int codigoRecibo);
	
	public ReportePuesto reportePuestoAgua(int pagina, int registros, String numeroPuesto, int codigoRecibo);
	
	public ReportePuesto reportePuestoxPto(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal);

}
