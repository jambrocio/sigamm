package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboAguaBus {

	public ReporteReciboAgua reporteReciboAgua(int pagina, int registros, int codigoRecibo);
	
	public Retorno grabarReciboAgua(ReciboAgua reciboAgua);
	
}
