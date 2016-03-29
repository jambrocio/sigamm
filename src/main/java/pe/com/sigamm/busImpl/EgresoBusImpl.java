package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.bus.EgresoBus;
import pe.com.sigamm.dao.EgresoDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Cuenta;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;

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

	@Override
	public ReporteOperacionesBancarias reporteOperacionesBancarias(int pagina, int registros, String codigoOperacionesBancarias) {

		return egresoDao.reporteOperacionesBancarias(pagina, registros, codigoOperacionesBancarias);
	}
	
	@Override
	public String opcionesCuentas(Cuenta cuenta) {

		List<Cuenta> opciones = egresoDao.opcionesCuentas(cuenta);		
		return gson.toJson(opciones);
		
	}

	@Override
	public Retorno grabarOperacionesBancarias(OperacionesBancarias operacionesBancarias) {

		Retorno retornoEgreso = egresoDao.grabarOperacionesBancarias(operacionesBancarias);
		return retornoEgreso;
		
	}
}
