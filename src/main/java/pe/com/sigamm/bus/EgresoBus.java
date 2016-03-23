package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteEgreso;

public interface EgresoBus {

	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal);
	
}
