package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteReciboLuzOriginal;
import pe.com.sigamm.modelo.LuzOriginal;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboLuzOriginalBus {

	public Retorno grabarReciboLuzOriginal(LuzOriginal luzoriginal);
	
	public ReporteReciboLuzOriginal reporteReciboLuzOriginal(int pagina, int registros, String codigoReciboLuzOriginal);
}
