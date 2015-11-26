package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

@Service
public class FacturacionBusImpl implements FacturacionBus {
	
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private FacturacionDao facturacionDao;
	
	@Override
	public Retorno grabarFacturacion(FacturacionCabecera facturacion, List<FacturacionDetalle> lista) {
		
		Retorno retornoCabecera = facturacionDao.grabarFacturacionCabecera(facturacion);
		if(retornoCabecera.getIndicador().equals("00")){
			
			for(FacturacionDetalle detalle : lista){
				
				Retorno retornoDetalle = facturacionDao.grabarFacturacionDetalle(detalle, retornoCabecera.getCodigo());
				
			}
			
		}
		
		return retornoCabecera;
	}

}
