package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.OtroServicio;
import pe.com.sigamm.bus.OtrosServiciosBus;
import pe.com.sigamm.dao.OtrosServiciosDao;

@Service
public class OtrosServiciosBusImpl implements OtrosServiciosBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(OtrosServiciosBusImpl.class);
	
	@Resource
	private OtrosServiciosDao otrosServiciosDao;
	
	@Override
	public String otrosServicios() {
		
		return gson.toJson(otrosServiciosDao.otrosServicios());
		
	}

	@Override
	public String otrosServiciosDetalle(OtroServicio otro) {
		
		return gson.toJson(otrosServiciosDao.otrosServiciosDetalle(otro));
		
	}

}
