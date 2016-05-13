package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.bus.ConceptoBus;
import pe.com.sigamm.dao.ConceptoDao;

@Service
public class ConceptoBusImpl implements ConceptoBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private ConceptoDao conceptoDao;

	@Override
	public ReporteConcepto reporteConcepto(int pagina, int registros, int codigoConcepto) {

		return conceptoDao.reporteConcepto(pagina, registros, codigoConcepto);
		
	}

	

}
