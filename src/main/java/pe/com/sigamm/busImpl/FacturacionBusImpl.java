package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;

import com.google.gson.Gson;

@Service
public class FacturacionBusImpl implements FacturacionBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private FacturacionDao facturacionDao;
	
	@Override
	public Retorno grabarFacturacion(FacturacionCabecera facturacion, List<FacturacionDetalle> lista) {
		
		Retorno retornoCabecera = facturacionDao.grabarFacturacionCabecera(facturacion);
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
	public ReporteFacturacion reporteFacturacion(int pagina, int registros, String dni, String nombre, int exportar) {
		
		return facturacionDao.reporteFacturacion(pagina, registros, dni, nombre, exportar);
	}
}