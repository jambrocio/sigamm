package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.bus.ReciboAguaBus;
import pe.com.sigamm.dao.ReciboAguaDao;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.Retorno;

@Service
public class ReciboAguaBusImpl implements ReciboAguaBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboAguaBusImpl.class);
	
	@Resource
	private ReciboAguaDao reciboAguaDao;

	@Override
	public ReporteReciboAgua reporteReciboAgua(int pagina, int registros, int codigoRecibo) {
		
		return reciboAguaDao.reporteReciboAgua(pagina, registros, codigoRecibo);
		
	}

	@Override
	public Retorno grabarReciboAgua(ReciboAgua reciboAgua) {

		return reciboAguaDao.grabarReciboAgua(reciboAgua);
		
	}

	@Override
	public Retorno eliminarReciboAgua(ReciboAgua reciboAgua) {
		return reciboAguaDao.eliminarReciboAgua(reciboAgua);
	}
	
}
