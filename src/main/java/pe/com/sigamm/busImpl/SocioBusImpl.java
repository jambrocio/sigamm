package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.bus.SocioBus;
import pe.com.sigamm.dao.SocioDao;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;

import com.google.gson.Gson;

@Service
public class SocioBusImpl implements SocioBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(SocioBusImpl.class);
	
	@Resource
	private SocioDao socioDao;
	
	@Override
	public ReporteSocio reporteSocio(int pagina, int registros, String dni) {
		
		return socioDao.reporteSocio(pagina, registros, dni);
	}

	@Override
	public Socio buscarSocio(Socio socio) {
		
		return socioDao.buscarSocio(socio);
	}

	@Override
	public Retorno grabarSocio(Socio socio) {
		
		return socioDao.grabarSocio(socio);
	}

}
