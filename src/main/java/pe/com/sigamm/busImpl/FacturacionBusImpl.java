package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.dao.PuestoDao;
import pe.com.sigamm.modelo.Concepto;

@Service
public class FacturacionBusImpl implements FacturacionBus {
	
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private FacturacionDao facturacionDao;
	
	@Override
	public List<Concepto> listaConcepto() {
		
		return facturacionDao.listaConcepto();
		
	}

}
