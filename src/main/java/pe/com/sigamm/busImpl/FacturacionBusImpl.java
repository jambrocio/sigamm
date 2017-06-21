package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.AnularFacturacion;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bean.ReporteFacturacionDetalle;
import pe.com.sigamm.bean.ReporteServicios;
import pe.com.sigamm.bean.ReporteServiciosOtros;
import pe.com.sigamm.bean.ServiciosDetalle;
import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.dao.FacturacionDao;
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

import com.google.gson.Gson;

@Service
public class FacturacionBusImpl implements FacturacionBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private FacturacionDao facturacionDao;
	
	@Override
	public Retorno grabarFacturacion(FacturacionCabecera facturacion, List<FacturacionDetalle> lista, String serie, String secuencia) {
		
		Retorno retornoCabecera = facturacionDao.grabarFacturacionCabecera(facturacion, serie, secuencia);
		if(retornoCabecera.getIndicador().equals("00")){
			
			for(FacturacionDetalle detalle : lista){
					
				Retorno retornoDetalle = facturacionDao.grabarFacturacionDetalle(detalle, retornoCabecera.getCodigo());
					
			}
			
		}
		
		return retornoCabecera;
	}

	@Override
	public String opcionesConceptos(Concepto concepto) {

		List<Concepto> opciones = facturacionDao.opcionesConceptos(concepto);		
		return gson.toJson(opciones);
		
	}

	@Override
	public String razonSocialEmpresa(Empresa empresa) {

		List<Empresa> razonSocial = facturacionDao.razonSocialEmpresa(empresa);		
		return gson.toJson(razonSocial);

	}

	@Override
	public Retorno grabarEmpresa(Empresa empresa) {

		Retorno retornoEmpresa = facturacionDao.grabarEmpresa(empresa);		
		return retornoEmpresa;
	}

	@Override
	public Retorno grabarEgreso(Egreso egreso) {

		Retorno retornoEgreso = facturacionDao.grabarEgreso(egreso);		
		return retornoEgreso;
	}

	@Override
	public ReporteEgreso reporteEgreso(int pagina, int registros, String codigoEgreso) {

		return facturacionDao.reporteEgreso(pagina, registros, codigoEgreso);
	}

	@Override
	public Retorno eliminarEgreso(Egreso egreso) {

		return facturacionDao.eliminarEgreso(egreso);
	}

	@Override
	public ReporteEgreso reporteEgresoExcel(int pagina, int registros, int exportar) {
		
		return facturacionDao.reporteEgresoExcel(pagina, registros, exportar);
	}
	
	@Override
	public List<DeudaSocio> listarDeudasSocio(DeudaSocio deuda) {
		
		return facturacionDao.listarDeudasSocio(deuda);
	}

	@Override
	public Facturacion buscarFacturacion(int codigoFacturacion) {
		
		return facturacionDao.buscarFacturacion(codigoFacturacion);
	}
	
	@Override
	public Retorno anularEgreso(Egreso egreso) {

		return facturacionDao.anularEgreso(egreso);
	}

	@Override
	public ReporteFacturacion reporteFacturacion(int pagina, int registros, String puesto, String nombres, int exportar) {
		
		return facturacionDao.reporteFacturacion(pagina, registros, puesto, nombres, exportar);
	}

	@Override
	public String montoTotalDiario() {
		
		return facturacionDao.montoTotalDiario();
	}

	@Override
	public String listarBanios() {
		
		List<Banio> opciones = facturacionDao.listarBanios();		
		return gson.toJson(opciones);
		
	}

	@Override
	public Retorno grabarServicioOtros(ServicioOtrosCabecera facturacion, List<ServicioOtrosDetalle> lista) {
		
		Retorno retornoCabecera = facturacionDao.grabarServicioOtrosCabecera(facturacion);
		if(retornoCabecera.getIndicador().equals("00")){
			
			Retorno retornoEliminaCabeceraDetalle = facturacionDao.eliminarOtrosServiciosDetalle(retornoCabecera.getCodigo());
			if(retornoEliminaCabeceraDetalle.getIndicador().equals("00")){
				for(ServicioOtrosDetalle detalle : lista){
				
					Retorno retornoDetalle = facturacionDao.grabarServicioOtrosDetalle(detalle, retornoCabecera.getCodigo());
				
				}
			}
		}
		
		return retornoCabecera;
		
	}

	@Override
	public ReporteServiciosOtros listarServiciosOtros(int pagina, int registros, int codigoServicio) {
		
		return facturacionDao.listarServiciosOtros(pagina, registros, codigoServicio);
	}

	@Override
	public ReporteServiciosOtros listarServiciosOtrosDetalle(int codigoServicioOtros) {
		
		return facturacionDao.listarServiciosOtrosDetalle(codigoServicioOtros);
	}

	@Override
	public ServicioOtrosCabecera ServiciosOtrosCabecera(int codigoServicioOtros) {
		
		return facturacionDao.ServiciosOtrosCabecera(codigoServicioOtros);
	}

	@Override
	public List<ServicioOtrosDetalle> ServiciosOtrosDetalle(int codigoServicioOtros) {
		
		return facturacionDao.ServiciosOtrosDetalle(codigoServicioOtros);
	}

	@Override
	public Retorno eliminarOtrosServiciosCabeceraDetalle(int codigoServicioOtros) {
		
		return facturacionDao.eliminarOtrosServiciosCabeceraDetalle(codigoServicioOtros);
	}

	@Override
	public Retorno eliminarOtrosServiciosDetalle(int codigoServicioOtros) {
		
		return facturacionDao.eliminarOtrosServiciosDetalle(codigoServicioOtros);
	}

	@Override
	public FacturacionCabecera buscarFacturacionCabecera(FacturacionCabecera facturacion) {
		
		return facturacionDao.buscarFacturacionCabecera(facturacion);
	}

	@Override
	public List<FacturacionDetalle> buscarFacturacionDetalle(FacturacionCabecera facturacion) {

		return facturacionDao.buscarFacturacionDetalle(facturacion);
	}

	@Override
	public ReporteFacturacionDetalle reporteFacturacionDetalle(int codigoFacturacionCab) {
		
		return facturacionDao.reporteFacturacionDetalle(codigoFacturacionCab);
	}

	@Override
	public Retorno anularFacturacion(AnularFacturacion anular) {
		
		return facturacionDao.anularFacturacion(anular);
	}

	@Override
	public ReporteServicios reporteServicios(int pagina, int registros, int codigoServicioDetalle, int exportar) {
		
		return facturacionDao.reporteServicios(pagina, registros, codigoServicioDetalle, exportar);
	}

	@Override
	public Retorno grabarServicios(ServiciosDetalle servicios) {
		
		return facturacionDao.grabarServicios(servicios);
	}

	@Override
	public Retorno eliminarServicios(ServiciosDetalle servicios) {
		
		return facturacionDao.eliminarServicios(servicios);
	}

	@Override
	public ReporteFacturacion reporteFacturacionGeneral(int pagina, int registros, String puesto, String nombre, int exportar) {
		
		return facturacionDao.reporteFacturacionGeneral(pagina, registros, puesto, nombre, exportar);
	}
	
}