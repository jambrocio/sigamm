package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;

public interface ReciboAguaSocioBus {
	
	public ReporteReciboAguaSocio reportePuestoAguaSocio(int pagina, int registros, int codigoRecibo);

	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);
}
