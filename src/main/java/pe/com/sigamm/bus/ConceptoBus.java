package pe.com.sigamm.bus;

import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Retorno;


public interface ConceptoBus {

	public ReporteConcepto reporteConcepto(int pagina, int registros, int codigoConcepto);
	
	public Retorno grabarConcepto(Concepto concepto);	
}
