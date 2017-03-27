package pe.com.sigamm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.google.gson.Gson;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ReporteReciboLuzOriginal;
import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.PuestoBus;
import pe.com.sigamm.bus.ReciboLuzOriginalBus;
import pe.com.sigamm.bus.ReciboLuzSocioBus;
import pe.com.sigamm.modelo.LuzOriginal;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.OperadoresUtil;


@Controller
public class ReciboLuzController {

	private static final Logger log = Logger.getLogger(ReciboLuzController.class);
	
	@Autowired
	private ReciboLuzOriginalBus reciboLuzOriginalBus;
	
	@Autowired
	private PuestoBus puestoBus;
	
	@Autowired
	private ReciboLuzSocioBus reciboLuzSocioBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/recibo_luz", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "servicios/recibo_luz";
	
	}
	
	@RequestMapping(value = "/reporte_recibo_luz", method = RequestMethod.GET)
	public String reporte_estado_cuenta(HttpServletRequest request) {

		return "reportes/reporte_recibo_luz";

	}
	
	@RequestMapping(value = "/grabar-luz-original.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarReciboLuzOriginal(LuzOriginal luzoriginal){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = reciboLuzOriginalBus.grabarReciboLuzOriginal(luzoriginal);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/eliminar-recibo-luz.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String eliminarReciboLuz(LuzOriginal reciboLuz) {

		Gson gson = new Gson();

		Retorno retorno = reciboLuzOriginalBus.eliminarReciboLuz(reciboLuz);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();

		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\""
				+ mensaje + "\"}";

		return resultado;
	}
	
	
	@RequestMapping(value = "/reporte-recibo-luz-original.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<LuzOriginal> reporteReciboLuzOriginal(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoReciboLuzOriginal", defaultValue = "0") String codigoReciboLuzOriginal){
		
		ResponseListBean<LuzOriginal> response = new ResponseListBean<LuzOriginal>();
		
		ReporteReciboLuzOriginal reporte = reciboLuzOriginalBus.reporteReciboLuzOriginal(pagina, registros, codigoReciboLuzOriginal);
		
		Integer totalReciboLuzOriginal = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboLuzOriginal);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboLuzOriginal, registros));
				
		response.setRows(reporte.getListaReciboLuzOriginal());
		
		return response;
	}
	
	@RequestMapping(value = "/reporte-recibo-luz-puesto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Puesto> reporteReciboLuzPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoPuesto", defaultValue = "0") String codigoPuesto,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<Puesto> response = new ResponseListBean<Puesto>();
		
		ReportePuesto reporte = puestoBus.reportePuestoLuz(pagina, registros, codigoPuesto, codigoRecibo);
		
		Integer totalReciboPuestoLuz = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoLuz);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoLuz, registros));
				
		response.setRows(reporte.getListaPuesto());
		
		return response;
	}


	
	@RequestMapping(value = "/buscar-usuario-puesto-giro.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Puesto> reporteUsuarioPuestoGiro(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoSector", defaultValue = "0") Integer codigoSector,
			@RequestParam(value = "nroPuesto", defaultValue = "0") String nroPuesto,
			@RequestParam(value = "codigoReciboOriginal", defaultValue = "0") Integer codigoReciboOriginal){
		
		ResponseListBean<Puesto> response = new ResponseListBean<Puesto>();
		
		ReportePuesto reporte = puestoBus.reportePuestoxPto(pagina, registros, codigoSector, nroPuesto, codigoReciboOriginal);
		
		Integer totalReciboPuestoxPto = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoxPto);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoxPto, registros));
				
		response.setRows(reporte.getListaPuesto());
		
		return response;
	}
	
	@RequestMapping(value = "/grabar-luz-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = reciboLuzSocioBus.grabarReciboLuzxSocio(reciboLuzSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/editar-luz-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboLuzSocio> editarReciboLuzxSocio(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<ReciboLuzSocio> response = new ResponseListBean<ReciboLuzSocio>();
		
		ReporteReciboLuzSocio reporte = reciboLuzSocioBus.editarReciboLuzxSocio(pagina, registros, puestoSocio, codigoRecibo);
		Integer totalSocios = reporte.getTotalRegistros();
		
		response.setPage(pagina);
		response.setRecords(totalSocios);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalSocios, registros));
				
		response.setRows(reporte.getListaReciboLuzSocio());
			
		return response;
	}
		
		
	@RequestMapping(value = "/cerrar-luz-original.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cerrarReciboLuzOriginal(LuzOriginal reciboLuzOriginal){
			
			Gson gson = new Gson();
			List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
			
			int codigo = 0;
			String mensaje = "";
			String listaObligatorios = gson.toJson(camposObligatorios);
				
			Retorno retorno = reciboLuzOriginalBus.cerrarReciboLuzOriginal(reciboLuzOriginal);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
			 
			String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";			
			
			return resultado;
		}
	
	
	@RequestMapping(value = "/buscar-recibo-luz-puesto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Puesto> reporteLuzPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<Puesto> response = new ResponseListBean<Puesto>();
		
		//ReporteReciboLuzSocio reporte = reciboLuzSocioBus.buscarPuestoxSocio(pagina, registros, puestoSocio);
		//ReportePuesto reporte = reciboLuzSocioBus.buscarPuestoxSocio(pagina, registros, puestoSocio);
		/*ReportePuesto reporte = reciboLuzSocioBus.buscarPuestoxSocio(pagina, registros, puestoSocio)*/
		
		//Integer totalRecibo = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		//response.setRecords(totalRecibo);
		
		//total de paginas a mostrar
		//response.setTotal(OperadoresUtil.obtenerCociente(totalRecibo, registros));
				
		//response.setRows(reporte.getListaReciboLuzSocio());
		
		return response;
	}

	@RequestMapping(value = "/generarImpresionLuzPDF", method = RequestMethod.GET)
	public void generarImpresionLuzPdf(
			@RequestParam(value = "periodo", defaultValue = "") String periodo,
			@RequestParam(value = "codigoRecibo", defaultValue = "") Integer codigoReciboLuzSocio,
			HttpServletResponse response, HttpServletRequest request) {
		
		periodo = periodo.replace("_", " ");
		File file = reciboLuzSocioBus.generarFacturacionLuzPDF(codigoReciboLuzSocio, periodo);
		response.setContentType("application/x-download");
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ file.getName() + "\"");
		InputStream is = null;
		try {
			is = new FileInputStream(file);
			OutputStream os = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int len;
			while ((len = is.read(buffer)) != -1) {
				os.write(buffer, 0, len);
			}
			os.flush();
			os.close();
			is.close();
		}

		catch (Exception e) {
			LoggerCustom.errorApp(this, "", e);
		}
		
	}

	
	@RequestMapping(value = "/pagar-luz-x-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String pagarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {

		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();

		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);

		if (camposObligatorios.size() > 0) {

			codigo = 0;

		} else {

			Retorno retorno = reciboLuzSocioBus.pagarReciboLuzxSocio(reciboLuzSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}

		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}

	
	@RequestMapping(value = "/recibosLuz", method = RequestMethod.GET)
    public void reporterecibosLuzPdf(
    		@RequestParam(value = "fechaInicial", defaultValue = "") String fechaInicial,
    		@RequestParam(value = "estado", defaultValue = "T") String estado,
    		HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        
		String suspendido = "%";
		String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		String rutaJRXML = ruta + "Reporte_Recibos_Luz.jrxml";
		String rutaJASPER = ruta + "Reporte_Recibos_Luz.jasper";
		
		log.info("Ruta JRXML : " + rutaJRXML);
		log.info("Ruta JASPER : " + rutaJASPER);
		
		if (estado.equals("T") ){
			estado = "%";
			suspendido = "%"; 
		} else if (estado.equals("E") ){
			estado = "0%";
			suspendido = "0%";
		} else if (estado.equals("P") ){
			estado = "1%";
			suspendido = "0%";
		} else if (estado.equals("S") ){
			estado = "0%";
			suspendido = "1%";
		}
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ReportTitle", "Reporte de Recibos de Luz de los Asociados");
		parameters.put("Author", "SIGAMM");
		parameters.put("FECHA", fechaInicial.trim());
		parameters.put("ESTADO", estado.trim());
		parameters.put("SUSPENDIDO", suspendido.trim());
		
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
	
	
	@RequestMapping(value = "/recibosLuzUltimo", method = RequestMethod.GET)
    public void reporterecibosLuzUltimoPdf(
    		HttpServletRequest request, HttpServletResponse response) throws IOException {        
		
		String periodoReciboLuz = request.getParameter("periodo1");
		String periodoReciboLuzActual = "";
		
        String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		Calendar c = Calendar.getInstance();
		
		int dia = c.get(Calendar.DATE);
		int mes = c.get(Calendar.MONTH);
		int annio = c.get(Calendar.YEAR);
		
		switch (mes) {
			case 0:
				periodoReciboLuzActual = periodoReciboLuz + " - ENERO " + annio;
				break;
			case 1:
				periodoReciboLuzActual = periodoReciboLuz + " - FEBRERO " + annio;
				break;
			case 2:
				periodoReciboLuzActual = periodoReciboLuz + " - MARZO " + annio;
				break;
			case 3:
				periodoReciboLuzActual = periodoReciboLuz + " - ABRIL " + annio;
				break;
			case 4:
				periodoReciboLuzActual = periodoReciboLuz + " - MAYO " + annio;
				break;
			case 5:
				periodoReciboLuzActual = periodoReciboLuz + " - JUNIO " + annio;
				break;
			case 6:
				periodoReciboLuzActual = periodoReciboLuz + " - JULIO " + annio;
				break;
			case 7:
				periodoReciboLuzActual = periodoReciboLuz + " - AGOSTO " + annio;
				break;
			case 8:
				periodoReciboLuzActual = periodoReciboLuz + " - SETIEMBRE " + annio;
				break;
			case 9:
				periodoReciboLuzActual = periodoReciboLuz + " - OCTUBRE " + annio;
				break;
			case 10:
				periodoReciboLuzActual = periodoReciboLuz + " - NOVIEMBRE " + annio;
				break;
			case 11:
				periodoReciboLuzActual = periodoReciboLuz + " - DICIEMBRE " + annio;
				break;
			default:
				periodoReciboLuzActual = " PERIODO POR DEFECTO ";
				break;
		}
        
        
		String rutaJRXML = ruta + "Reporte_Recibos_Luz_Medicion.jrxml";
		String rutaJASPER = ruta + "Reporte_Recibos_Luz_Medicion.jasper";
		
		log.info("Ruta JRXML : " + rutaJRXML);
		log.info("Ruta JASPER : " + rutaJASPER);
		
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ReportTitle", "Reporte de Recibos de Luz de los Asociados");
		parameters.put("Author", "SIGAMM");
		parameters.put("FECHA", periodoReciboLuzActual);
		parameters.put("PeriodoReciboLuz", periodoReciboLuz);
		
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
	
	
	@RequestMapping(value = "/eliminar-recibo-luz-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String eliminarReciboLuzSocio(ReciboLuzSocio reciboLuzSocio) {

		Gson gson = new Gson();

		Retorno retorno = reciboLuzSocioBus.eliminarReciboLuzSocio(reciboLuzSocio);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();

		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}

	
}
