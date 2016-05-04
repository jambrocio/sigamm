package pe.com.sigamm.controller;

import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.AnularFacturacion;
import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ListaServiciosOtros;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bean.ReporteFacturacionDetalle;
import pe.com.sigamm.bean.ReporteServiciosOtros;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bean.VistaFacturacion;
import pe.com.sigamm.bean.VistaFacturacionDetalle;
import pe.com.sigamm.bus.FacturacionBus;
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
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class FacturacionController {
	
	private static final Logger log = Logger.getLogger(FacturacionController.class);
	
	@Autowired
	private FacturacionBus facturacionBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/cobro", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "facturacion/cobro";
	
	}
	
	@RequestMapping(value = "/reporteCobro", method=RequestMethod.GET)
	public String reporteCobro(HttpServletRequest request) {
		
		return "facturacion/reporteCobro";
	
	}
	
	@RequestMapping(value = "/egreso", method=RequestMethod.GET)
	public String reporteEgresos(HttpServletRequest request) {
		
		return "facturacion/egreso";
	
	}
	
	@RequestMapping(value = "/grabar-facturacion.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarFacturacion(FacturacionCabecera facturacion){
		
		Gson gson = new Gson();
		Type type = new TypeToken<List<FacturacionDetalle>>(){}.getType();
		List<FacturacionDetalle> lista = gson.fromJson(facturacion.getFacturacionDetalle(), type);
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		Retorno retorno = facturacionBus.grabarFacturacion(facturacion, lista);
		
		String resultado = "{\"idFacturacion\":" + retorno.getCodigo() + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + retorno.getMensaje() + "\"}";
		
		return resultado;
		
	}
	
	@RequestMapping(value = "/cargar-conceptos.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarConceptos(Concepto concepto){
		
		return facturacionBus.opcionesConceptos(concepto);
	}
	
	@RequestMapping(value = "/buscar-ruc.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarConceptos(Empresa empresa){
		
		return facturacionBus.razonSocialEmpresa(empresa);
	}
	
	@RequestMapping(value = "/grabar-empresa.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarEmpresa(Empresa empresa){
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(empresa.getCodigoEmpresa() == 0){
			
			if(empresa.getRucNuevo() == ""){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_RUC, Constantes.RUC_OBLIGATORIO));
			}
			
			if(empresa.getRazonSocialNueva() == ""){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_RAZON_SOCIAL, Constantes.RAZON_SOCIAL_OBLIGATORIO));
			}
			
			if(empresa.getRazonSocialNueva() == null){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_RAZON_SOCIAL, Constantes.RAZON_SOCIAL_OBLIGATORIO));
			}
			
		}
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = facturacionBus.grabarEmpresa(empresa);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
	 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		return resultado;
	}

	
	@RequestMapping(value = "/grabar-egreso.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarEgreso(Egreso egreso){
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(egreso.getCodigoEmpresa() == 0){
			
			
		}
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = facturacionBus.grabarEgreso(egreso);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
	 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/reporte-egreso.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Egreso> reporteEgreso(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoEgreso", defaultValue = "0") String codigoEgreso){
		
		ResponseListBean<Egreso> response = new ResponseListBean<Egreso>();
		
		ReporteEgreso reporteEgreso = facturacionBus.reporteEgreso(pagina, registros, codigoEgreso);
		
		Integer totalEgreso = reporteEgreso.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalEgreso);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalEgreso, registros));
				
		response.setRows(reporteEgreso.getListaEgreso());
		
		return response;
	}
	
	@RequestMapping(value = "/eliminar-egreso.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String eliminarEgreso(Egreso egreso){
		
		Gson gson = new Gson();
		
		Retorno retorno = facturacionBus.eliminarEgreso(egreso);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/reporteEgresoExcel", method = RequestMethod.GET)
    public ModelAndView downloadExcel() {
        
		// create some sample data
		ReporteEgreso reporte = facturacionBus.reporteEgresoExcel(1, 1, 1);
		
		List<Egreso> lista = reporte.getListaEgreso();
		
		// return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelViewEgresos", "listaRegistrosEgresos", lista);
         
    }
	
	
/*	@RequestMapping(value = "/reportarEgresoExcel", method = RequestMethod.GET)
	public ModelAndView downloadEgresoExcel(
			@RequestParam(value = "fechaInicio", defaultValue = "01/07/2015") String fechaInicio,
			@RequestParam(value = "fechaTermino", defaultValue = "01/07/2015") String fechaTermino){
			
		ReporteEgreso reporte = facturacionBus.reportarEgreso(fechaInicio, fechaTermino);		
		List<Egreso> lista = reporte.getListaEgreso();		
		// return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelViewEgresos", "listaRegistrosEgresos", lista);
	}*/
	
	@RequestMapping(value = "/buscar-deuda-socio-concepto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<DeudaSocio> buscarDeudaSocioConcepto(DeudaSocio deuda){
		
		return facturacionBus.listarDeudasSocio(deuda);
	}
	
	@RequestMapping(value = "/generarFacturacionPdf", method = RequestMethod.GET)
    public ModelAndView generarFacturacionPdf(@RequestParam(value = "codigoEleccion", defaultValue = "1") Integer codigoEleccion, HttpServletResponse response, HttpServletRequest request) {
        // create some sample data
		//List<RegistrosApp> lista = procesosBus.listaRegistros(1, 1, 1);
		
		Facturacion facturacion = facturacionBus.buscarFacturacion(55);
		
		response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Impresion Facturacion.pdf");
        
        // return a view which will be resolved by an excel view resolver
        return new ModelAndView("pdfView", "facturacion", facturacion);
    }
	
	@RequestMapping(value = "/anular-egreso.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String anularEgreso(Egreso egreso){
		
		Gson gson = new Gson();
		
		Retorno retorno = facturacionBus.anularEgreso(egreso);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/reporte-facturacion.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<VistaFacturacion> reporteSocios(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "dni", defaultValue = "0") String dni,
			@RequestParam(value = "nombre", defaultValue = "") String nombre){
		
		ResponseListBean<VistaFacturacion> response = new ResponseListBean<VistaFacturacion>();
		
		ReporteFacturacion reporte = facturacionBus.reporteFacturacion(pagina, registros, dni, nombre, 0);
		
		Integer totalSocios = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalSocios);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalSocios, registros));
				
		response.setRows(reporte.getListaFacturacion());
		
		return response;
	}
	
	@RequestMapping(value = "/monto-total-diario.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String montoTotalDiario(){
		
		String resultado = "{\"monto\":\"" + facturacionBus.montoTotalDiario() + "\"}";
		return resultado;
		
	}
	
	@RequestMapping(value = "/cargar-banios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarBanios(){
		
		return facturacionBus.listarBanios();
	}
	
	@RequestMapping(value = "/grabar-servicio-otros.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarServicioOtros(ServicioOtrosCabecera servicio){
		
		Gson gson = new Gson();
		Type type = new TypeToken<List<ServicioOtrosDetalle>>(){}.getType();
		List<ServicioOtrosDetalle> lista = gson.fromJson(servicio.getServicioOtrosDetalle(), type);
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		Retorno retorno = facturacionBus.grabarServicioOtros(servicio, lista);
		
		//String resultado = "{\"idServicioOtros\":" + retorno.getCodigo() + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + retorno.getMensaje() + "\"}";
		String resultado = "{\"idServicioOtros\":" + retorno.getCodigo() + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + retorno.getMensaje() + "\",\"codigoRetorno\":\"" + retorno.getIndicador() + "\"}";
		
		return resultado;
		
	}
	
	@RequestMapping(value = "/reporte-servicios-otros.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ListaServiciosOtros> reporteServiciosOtros(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoServicio", defaultValue = "0") Integer codigoServicio){
		
		ResponseListBean<ListaServiciosOtros> response = new ResponseListBean<ListaServiciosOtros>();
		
		//ListaServiciosOtros reporteServicioOtros = facturacionBus.reporteEgreso(pagina, registros, codigoEgreso);
		ReporteServiciosOtros reporteServicioOtros = facturacionBus.listarServiciosOtros(pagina, registros, codigoServicio);
		
		Integer totalEgreso = reporteServicioOtros.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalEgreso);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalEgreso, registros));
				
		response.setRows(reporteServicioOtros.getListaServiciosOtros());
		
		return response;
	}
	
	@RequestMapping(value = "/reporte-servicios-otros-detalle.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ListaServiciosOtros> reporteServiciosOtrosDetalle(
			@RequestParam(value = "codigoServicioOtros", defaultValue = "0") Integer codigoServicioOtros){
		
		ResponseListBean<ListaServiciosOtros> response = new ResponseListBean<ListaServiciosOtros>();
		ReporteServiciosOtros reporteServicioOtros = facturacionBus.listarServiciosOtrosDetalle(codigoServicioOtros);
		
		Integer totalEgreso = reporteServicioOtros.getTotalRegistros(); 
		
		response.setPage(1);
		response.setRecords(totalEgreso);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalEgreso, 1));
				
		response.setRows(reporteServicioOtros.getListaServiciosOtros());
		
		return response;
	}
	
	@RequestMapping(value = "/buscar-servicioOtrosCabecera.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ServicioOtrosCabecera buscarServicioOtrosCabecera(
			@RequestParam(value = "codigoServicioOtros", defaultValue = "0") Integer codigoServicioOtros){
		
		return facturacionBus.ServiciosOtrosCabecera(codigoServicioOtros);
	}
	
	@RequestMapping(value = "/buscar-servicioOtrosDetalle.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<ServicioOtrosDetalle> buscarServicioOtrosDetalle(
			@RequestParam(value = "codigoServicioOtros", defaultValue = "0") Integer codigoServicioOtros){
		
		return facturacionBus.ServiciosOtrosDetalle(codigoServicioOtros);
	}
	
	@RequestMapping(value = "/eliminar-servicio-otros.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String eliminarServicioOtros(
			@RequestParam(value = "codigoServicioOtros", defaultValue = "0") Integer codigoServicioOtros){
		
		Retorno retorno = facturacionBus.eliminarOtrosServiciosCabeceraDetalle(codigoServicioOtros);
		
		String resultado = "{\"mensaje\":\"" + retorno.getMensaje() + "\",\"codigoRetorno\":\"" + retorno.getIndicador() + "\"}";
		
		return resultado;
		
	}
	
	@RequestMapping(value = "/buscar-facturacionCabecera.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody FacturacionCabecera buscarfacturacionCabecera(FacturacionCabecera facturacion){
		
		return facturacionBus.buscarFacturacionCabecera(facturacion);
	}
	
	@RequestMapping(value = "/buscar-facturacionDetalle.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<FacturacionDetalle> buscarfacturacionDetalle(FacturacionCabecera facturacion){
		
		return facturacionBus.buscarFacturacionDetalle(facturacion);
	}
	
	@RequestMapping(value = "/reporte-facturacion-detalle.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<VistaFacturacionDetalle> reporteFacturacionDetalle(
			@RequestParam(value = "codigoFacturacionCab", defaultValue = "0") Integer codigoFacturacionCab){
		
		ResponseListBean<VistaFacturacionDetalle> response = new ResponseListBean<VistaFacturacionDetalle>();
		ReporteFacturacionDetalle reporteServicioOtros = facturacionBus.reporteFacturacionDetalle(codigoFacturacionCab);
		
		Integer totalEgreso = reporteServicioOtros.getTotalRegistros(); 
		
		response.setPage(1);
		response.setRecords(totalEgreso);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalEgreso, 1));
				
		response.setRows(reporteServicioOtros.getListaFacturacion());
		
		return response;
	}
	
	@RequestMapping(value = "/iFacturacionDiario", method = RequestMethod.GET)
    public void reporterecibosLuzPdf(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		String rutaJRXML = ruta + "reporte_facturacion_diario.jrxml";
		String rutaJASPER = ruta + "reporte_facturacion_diario.jasper";
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ReportTitle", "Reporte de Facturación Diario");
		parameters.put("Author", "SIGAMM");
		//parameters.put("FECHA", fechaInicial.trim());
		
		Connection con = null;
		
		try {
			JasperCompileManager.compileReportToFile(rutaJRXML);
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(rutaJASPER);
			/*CONEXION JNDI*/
			/*INICIO*/
			Context initialContext = new InitialContext();
			DataSource datasource = (DataSource)initialContext.lookup(Constantes.SigammDS);
			con = datasource.getConnection();
			/*FIN*/
			JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, con);
			if (jasperPrint != null) {
				byte[] pdfReport = JasperExportManager.exportReportToPdf(jasperPrint);
				response.reset();
				response.setContentType("application/pdf");
				response.setHeader("Cache-Control", "no-store");
				response.setHeader("Cache-Control", "private");
				response.setHeader("Pragma", "no-store");
				response.setContentLength(pdfReport.length);
				response.getOutputStream().write(pdfReport);
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		} catch (JRException e) {
			LoggerCustom.errorApp(this, "", e);
		} catch (NamingException e) {
			LoggerCustom.errorApp(this, "", e);
		} catch (SQLException e) {
			LoggerCustom.errorApp(this, "", e);
		}
 
    }
	
	@RequestMapping(value = "/anular-facturacion.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String anularFacturacion(AnularFacturacion anular){
		
		Retorno retorno = facturacionBus.anularFacturacion(anular);
		
		String resultado = "{\"indicador\":\"" + retorno.getIndicador() + "\",\"mensaje\":\"" + retorno.getMensaje() + "\"}";
		
		return resultado;
		
	}
}
