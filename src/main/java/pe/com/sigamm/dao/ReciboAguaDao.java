package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboAguaDao {
	
	public ReporteReciboAgua reporteReciboAgua(int pagina, int registros, int codigoRecibo);
	
	public Retorno grabarReciboAgua(ReciboAgua reciboAgua);
	
	public Retorno eliminarReciboAgua(ReciboAgua reciboAgua);

}
