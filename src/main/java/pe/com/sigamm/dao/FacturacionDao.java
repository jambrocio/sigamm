package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

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
	
}
