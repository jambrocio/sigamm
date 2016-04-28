package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bean.ReporteFacturacionDetalle;
import pe.com.sigamm.bean.ReporteServiciosOtros;
import pe.com.sigamm.modelo.Banio;
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

public interface FacturacionDao {

	public Retorno grabarFacturacionCabecera(FacturacionCabecera facturacion);
	
	public Retorno grabarFacturacionDetalle(FacturacionDetalle facturacion, int codigoFacturacion);

	public List<Concepto> opcionesConceptos(Concepto concepto);

	public List<Empresa> razonSocialEmpresa(Empresa empresa);
	
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

	public List<Banio> listarBanios();
	
	public Retorno grabarServicioOtrosCabecera(ServicioOtrosCabecera servicio);
	
	public Retorno grabarServicioOtrosDetalle(ServicioOtrosDetalle servicio, int codigoServicio);
	
	public ReporteServiciosOtros listarServiciosOtros(int pagina, int registros, int codigoServicio);
	
	public ReporteServiciosOtros listarServiciosOtrosDetalle(int codigoServicioOtros);
	
	public ServicioOtrosCabecera ServiciosOtrosCabecera(int codigoServicioOtros);
	
	public List<ServicioOtrosDetalle> ServiciosOtrosDetalle(int codigoServicioOtros);
	
	public Retorno eliminarOtrosServiciosCabeceraDetalle(int codigoServicioOtros);
	
	public Retorno eliminarOtrosServiciosDetalle(int codigoServicioOtros);
	
	public FacturacionCabecera buscarFacturacionCabecera(FacturacionCabecera facturacion);
	
	public List<FacturacionDetalle> buscarFacturacionDetalle(FacturacionCabecera facturacion);

	public ReporteFacturacionDetalle reporteFacturacionDetalle(int codigoFacturacionCab);
	
}