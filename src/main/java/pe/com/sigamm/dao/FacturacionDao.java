package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

public interface FacturacionDao {

	public List<Concepto> listaConcepto();
	
	public Retorno grabarFacturacionCabecera(FacturacionCabecera facturacion);
	
	public Retorno grabarFacturacionDetalle(FacturacionDetalle facturacion, int codigoFacturacion);
	
}
