package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bean.ReporteServiciosOtros;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.ServicioOtrosCabecera;
import pe.com.sigamm.modelo.ServicioOtrosDetalle;

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
	
	public Facturacion buscarFacturacion(int codigoFacturacion);
	
	public Retorno anularEgreso(Egreso egreso);
	
	public ReporteFacturacion reporteFacturacion(int pagina, int registros, String dni, String nombre, int exportar);
	
	public String montoTotalDiario();
	
	public String listarBanios();
	
	public Retorno grabarServicioOtros(ServicioOtrosCabecera facturacion, List<ServicioOtrosDetalle> lista);
	
	public ReporteServiciosOtros listarServiciosOtros(int pagina, int registros, int codigoServicio);
	
	public ReporteServiciosOtros listarServiciosOtrosDetalle(int codigoServicioOtros);
	
}
