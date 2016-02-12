package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboAguaSocioDao {
	
	public ReporteReciboAguaSocio reporteReciboAguaSocio(int pagina, int registros, int codigoRecibo);	

	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);
	
	public ReporteReciboAguaSocio reportePuestoxAgua(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal);
	
	public Retorno grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio);
	
	public ReporteReciboAguaSocio buscarReciboAguaSocio(int codigoReciboAguaSocio);
	
	public ReporteReciboAguaSocio reporteAguaSocioExcel(int pagina, int registros, int exportar, int codigoAguaOriginal);
	
	public Retorno pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio);
}
