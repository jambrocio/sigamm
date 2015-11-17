package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bus.ReciboLuzSocioBus;
import pe.com.sigamm.dao.ReciboLuzSocioDao;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;

@Service
public class ReciboLuzSocioBusImpl implements ReciboLuzSocioBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzSocioBusImpl.class);
	
	@Resource
	private ReciboLuzSocioDao reciboLuzSocioDao;
	
	@Override
	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {
		
		return reciboLuzSocioDao.grabarReciboLuzxSocio(reciboLuzSocio);
		
	}

}
