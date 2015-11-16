package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.google.gson.Gson;

import pe.com.sigamm.bus.ReciboLuzSocioBus;
import pe.com.sigamm.dao.ReciboLuzSocioDao;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

public class ReciboLuzSocioBusImpl implements ReciboLuzSocioBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzOriginalBusImpl.class);
	
	@Resource
	private ReciboLuzSocioDao reciboLuzSocioDao;
	
	/*@Override
	public Retorno grabarReciboLuzSocio(ReciboLuzSocio reciboLuzSocio) {
		
		return reciboLuzSocioDao.grabarReciboLuzSocio(reciboLuzSocio);
		
	}*/

}
