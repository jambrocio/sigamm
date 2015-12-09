package pe.com.sigamm.bus;

import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

public interface ReciboLuzSocioBus {

	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
	public Retorno editarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio);
	
}
