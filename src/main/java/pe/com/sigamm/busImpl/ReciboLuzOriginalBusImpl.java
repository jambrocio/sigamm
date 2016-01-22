package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteReciboLuzOriginal;
import pe.com.sigamm.bus.ReciboLuzOriginalBus;
import pe.com.sigamm.dao.ReciboLuzOriginalDao;
import pe.com.sigamm.modelo.LuzOriginal;
import pe.com.sigamm.modelo.Retorno;

@Service
public class ReciboLuzOriginalBusImpl implements ReciboLuzOriginalBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzOriginalBusImpl.class);
	
	@Resource
	private ReciboLuzOriginalDao reciboLuzOriginalDao;
	
	@Override
	public Retorno grabarReciboLuzOriginal(LuzOriginal luzoriginal) {
		
		return reciboLuzOriginalDao.grabarReciboLuzOriginal(luzoriginal);
		
	}

	@Override
	public ReporteReciboLuzOriginal reporteReciboLuzOriginal(int pagina,int registros, String codigoReciboLuzOriginal) {
		
		return reciboLuzOriginalDao.reporteReciboLuzOriginal(pagina, registros, codigoReciboLuzOriginal);
		
	}

	@Override
	public Retorno cerrarReciboLuzOriginal(LuzOriginal reciboLuzOriginal) {

		return reciboLuzOriginalDao.cerrarReciboLuzOriginal(reciboLuzOriginal);
		
	}

}
