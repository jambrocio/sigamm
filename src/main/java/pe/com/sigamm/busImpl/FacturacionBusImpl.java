package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ServiciosDetalle;
import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.MenuPrincipal;
import pe.com.sigamm.modelo.Retorno;

@Service
public class FacturacionBusImpl implements FacturacionBus {
	
	Gson gson = new Gson();
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

	@Override
	public String opcionesConceptos(Concepto concepto) {

		List<Concepto> opciones = facturacionDao.opcionesConceptos(concepto);
		for(Concepto conceptos : opciones){
			
		}
		
		return gson.toJson(opciones);
		
	}

}
