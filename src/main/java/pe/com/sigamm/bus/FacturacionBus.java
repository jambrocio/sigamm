package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

public interface FacturacionBus {

	public Retorno grabarFacturacion(FacturacionCabecera facturacion, List<FacturacionDetalle> lista);
	
	public String opcionesConceptos(Concepto concepto);
	
	public String razonSocialEmpresa(Empresa empresa);
	
	public Retorno grabarEmpresa(Empresa empresa);
	
	public Retorno grabarEgreso(Egreso egreso);
	
	public ReporteEgreso reporteEgreso(int pagina, int registros, String codigoEgreso);
	
	public Retorno eliminarEgreso(Egreso egreso);
	
	public ReporteEgreso reporteEgresoExcel(int pagina, int registros, int exportar);
	
	public List<DeudaSocio> listarDeudasSocio(DeudaSocio deuda);
}
