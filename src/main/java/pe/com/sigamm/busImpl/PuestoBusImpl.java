package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bus.PuestoBus;
import pe.com.sigamm.dao.PuestoDao;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;

import com.google.gson.Gson;

@Service
public class PuestoBusImpl implements PuestoBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(PuestoBusImpl.class);
	
	@Resource
	private PuestoDao puestoDao;
	
	@Override
	public List<GiroComercial> listaGiroComercial() {
		
		return puestoDao.listaGiroComercial();
	}

	@Override
	public Retorno grabarPuesto(Puesto puesto) {
		
		return puestoDao.grabarPuesto(puesto);
	}

	@Override
	public ReportePuesto reportePuesto(int pagina, int registros, String dni) {
		
		return puestoDao.reportePuesto(pagina, registros, dni);
	}

	@Override
	public Retorno eliminarPuesto(Puesto puesto) {
		
		return puestoDao.eliminarPuesto(puesto);
	}

}
