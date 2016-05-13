package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteConcepto;


public interface ConceptoBus {

	public ReporteConcepto reporteConcepto(int pagina, int registros, int codigoConcepto);
	
	
}
