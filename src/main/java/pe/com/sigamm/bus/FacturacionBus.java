package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

public interface FacturacionBus {

	public Retorno grabarFacturacion(FacturacionCabecera facturacion, List<FacturacionDetalle> lista);
	
	
	
}
