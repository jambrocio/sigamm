package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;

public interface ReciboAguaSocioBus {

	public ReporteReciboAguaSocio reportePuestoAgua(Integer pagina, Integer registros, Integer codigoPuesto, Integer codigoRecibo);

}
