package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboAguaSocioBus {
	
	public ReporteReciboAguaSocio reportePuestoAguaSocio(int pagina, int registros, int codigoRecibo);

	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);
	
	public ReporteReciboAguaSocio reportePuestoxAgua(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal);
	
	public Retorno grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio);
}
