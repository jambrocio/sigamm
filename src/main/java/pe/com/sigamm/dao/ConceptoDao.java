package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Cuenta;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;

public interface ConceptoDao {

	public ReporteConcepto reporteConcepto(int pagina, int registros, int codigoConcepto);
	
	public Retorno grabarConcepto(Concepto concepto);
}
