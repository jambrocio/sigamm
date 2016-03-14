package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboLuzSocioDao {

	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
	public ReporteReciboLuzSocio editarReciboLuzxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);

	public ReporteReciboLuzSocio reporteReciboLuzSocio(
			Integer codigoReciboLuzSocio, String periodo);
	
}
