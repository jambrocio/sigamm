package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;

public interface ReciboAguaSocioDao {
	
	public ReporteReciboAguaSocio reporteReciboAguaSocio(int pagina, int registros, int codigoRecibo);	

	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);
}
