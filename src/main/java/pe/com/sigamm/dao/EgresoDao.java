package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteEgreso;

public interface EgresoDao {

	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal);
	
}
