package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bus.EgresoBus;
import pe.com.sigamm.dao.EgresoDao;

@Service
public class EgresoBusImpl implements EgresoBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private EgresoDao egresoDao;
	
	@Override
	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal) {

		return egresoDao.reportarEgreso(fechaInicial, fechaFinal);
	}
	
}
