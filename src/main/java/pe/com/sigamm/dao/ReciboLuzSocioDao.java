package pe.com.sigamm.dao;

import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboLuzSocioDao {

	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
	public Retorno eliminarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
}
