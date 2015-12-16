package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.dao.ReciboAguaSocioDao;

@Service
public class ReciboAguaSocioBusImpl implements ReciboAguaSocioBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzSocioBusImpl.class);
	
	@Resource
	private ReciboAguaSocioDao reciboAguaSocioDao;

	@Override
	public ReporteReciboAguaSocio reportePuestoAguaSocio(int pagina,	int registros, int codigoSocio, int codigoServicio) {
		
		return reciboAguaSocioDao.reporteReciboAguaSocio(pagina, registros, codigoSocio, codigoServicio);
		
	}

}
