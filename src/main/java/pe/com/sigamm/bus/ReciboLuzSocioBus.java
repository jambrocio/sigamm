package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboLuzSocioBus {

	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
	public ReporteReciboLuzSocio editarReciboLuzxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo);

}
