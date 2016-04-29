package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.modelo.Cuenta;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;

public interface EgresoDao {

	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal);
	
	public ReporteOperacionesBancarias reportarOperacionesBancarias(String fechaInicial, String fechaFinal);
	
	public ReporteOperacionesBancarias reporteOperacionesBancarias(int pagina, int registros, String codigoOperacionesBancarias);
	
	public List<Cuenta> opcionesCuentas(Cuenta cuenta);
	
	public Retorno grabarOperacionesBancarias(OperacionesBancarias operacionesBancarias);
}
