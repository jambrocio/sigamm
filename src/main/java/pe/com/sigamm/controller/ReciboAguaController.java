package pe.com.sigamm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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

import com.google.gson.Gson;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.PuestoBus;
import pe.com.sigamm.bus.ReciboAguaBus;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;

@Controller
public class ReciboAguaController {

	private static final Logger log = Logger
			.getLogger(ReciboAguaController.class);

	@Autowired
	private DatosSession datosSession;

	@Autowired
	private PuestoBus puestoBus;

	@Autowired
	private ReciboAguaBus reciboAguaBus;

	@Autowired
	private ReciboAguaSocioBus reciboAguaSocioBus;

	@RequestMapping(value = "/recibo_agua", method = RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {

		return "servicios/recibo_agua";

	}

	@RequestMapping(value = "/reporte_recibo_agua", method = RequestMethod.GET)
	public String reporte_estado_cuenta(HttpServletRequest request) {

		return "reportes/reporte_recibo_agua";

	}
	
	@RequestMapping(value = "/reporte-recibo-agua.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	ResponseListBean<ReciboAgua> reporteReciboAgua(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo) {

		ResponseListBean<ReciboAgua> response = new ResponseListBean<ReciboAgua>();

		ReporteReciboAgua reporte = reciboAguaBus.reporteReciboAgua(pagina,
				registros, codigoRecibo);

		Integer totalReciboPuestoAgua = reporte.getTotalRegistros();

		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);

		// total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua,
				registros));

		response.setRows(reporte.getListaReciboAgua());

		return response;
	}

	@RequestMapping(value = "/grabar-recibo-agua.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String grabarReciboAgua(ReciboAgua reciboAgua) {

		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();

		if (reciboAgua.getPeriodo().trim() == "") {
			camposObligatorios.add(Util
					.retornarObjeto(Constantes.ETIQUETA_PERIODO,
							Constantes.PERIODO_OBLIGATORIO));
		}

		if (reciboAgua.getLecturaInicial() == 0) {
			camposObligatorios.add(Util.retornarObjeto(
					Constantes.ETIQUETA_LECTURA_INICIAL,
					Constantes.LECTURA_INICIAL_OBLIGATORIO));
		}

		if (reciboAgua.getLecturaFinal() == 0) {
			camposObligatorios.add(Util.retornarObjeto(
					Constantes.ETIQUETA_LECTURA_FINAL,
					Constantes.LECTURA_FINAL_OBLIGATORIO));
		}

		if (reciboAgua.getMonto() == 0.0) {
			camposObligatorios.add(Util.retornarObjeto(
					Constantes.ETIQUETA_MONTO, Constantes.MONTO_OBLIGATORIO));
		}
		
		if (reciboAgua.getFechaCorte() == "") {
			camposObligatorios.add(Util.retornarObjeto(
					Constantes.ETIQUETA_FECHA_CORTE, Constantes.FECHA_CORTE_OBLIGATORIO));
		}
		
		if (reciboAgua.getFechaVencimiento() == "") {
			camposObligatorios.add(Util.retornarObjeto(
					Constantes.ETIQUETA_FECHA_VENCIMIENTO, Constantes.FECHA_VENCIMIENTO_OBLIGATORIO));
		}

		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);

		if (camposObligatorios.size() > 0) {

			codigo = 0;

		} else {

			Retorno retorno = reciboAguaBus.grabarReciboAgua(reciboAgua);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}

		String resultado = "{\"idUsuario\":" + codigo
				+ ",\"camposObligatorios\":" + listaObligatorios
				+ ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}

	@RequestMapping(value = "/eliminar-recibo-agua.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String eliminarReciboAgua(ReciboAgua reciboAgua) {

		Gson gson = new Gson();

		Retorno retorno = reciboAguaBus.eliminarReciboAgua(reciboAgua);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();

		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\""
				+ mensaje + "\"}";

		return resultado;
	}

	@RequestMapping(value = "/reporte-recibo-agua-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	ResponseListBean<ReciboAguaSocio> reporteReciboAguaSocio(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo) {

		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoAguaSocio(pagina, registros, puestoSocio, codigoRecibo);
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros();

		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);

		// total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
		response.setRows(reporte.getListaReciboAguaSocio());

		return response;
	}

	@RequestMapping(value = "/editar-agua-x-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	ResponseListBean<ReciboAguaSocio> editarReciboAguaxSocio(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo) {

		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();

		ReporteReciboAguaSocio reporte = reciboAguaSocioBus
				.editarReciboAguaxSocio(pagina, registros, puestoSocio,
						codigoRecibo);
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros();

		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);

		// total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua,
				registros));

		response.setRows(reporte.getListaReciboAguaSocio());

		return response;
	}

	@RequestMapping(value = "/buscar-usuario-puesto-giro-agua.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	ResponseListBean<ReciboAguaSocio> reporteUsuarioPuestoGiroAgua(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoSector", defaultValue = "0") Integer codigoSector,
			@RequestParam(value = "nroPuesto", defaultValue = "0") String nroPuesto,
			@RequestParam(value = "codigoReciboOriginal", defaultValue = "0") Integer codigoReciboOriginal) {

		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();

		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoxAgua(
				pagina, registros, codigoSector, nroPuesto,
				codigoReciboOriginal);

		Integer totalReciboPuestoxAgua = reporte.getTotalRegistros();

		response.setPage(pagina);
		response.setRecords(totalReciboPuestoxAgua);

		// total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(
				totalReciboPuestoxAgua, registros));

		response.setRows(reporte.getListaReciboAguaSocio());

		return response;
	}

	@RequestMapping(value = "/grabar-agua-x-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();

		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);

		if (camposObligatorios.size() > 0) {

			codigo = 0;

		} else {

			Retorno retorno = reciboAguaSocioBus.grabarReciboAguaxSocio(reciboAguaSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}

		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}

	@RequestMapping(value = "/pagar-agua-x-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();

		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);

		if (camposObligatorios.size() > 0) {

			codigo = 0;

		} else {

			Retorno retorno = reciboAguaSocioBus
					.pagarReciboAguaxSocio(reciboAguaSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}

		String resultado = "{\"idUsuario\":" + codigo
				+ ",\"camposObligatorios\":" + listaObligatorios
				+ ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}
	
	
	@RequestMapping(value = "/eliminar-agua-x-socio.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String eliminarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();

		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);

		if (camposObligatorios.size() > 0) {

			codigo = 0;

		} else {

			Retorno retorno = reciboAguaSocioBus.eliminarReciboAguaxSocio(reciboAguaSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}

		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}
	

	@RequestMapping(value = "/reporte-recibo-agua-puesto.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	ResponseListBean<Puesto> reporteReciboAguaPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "nroPuesto", defaultValue = "0") String nroPuesto,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo) {

		ResponseListBean<Puesto> response = new ResponseListBean<Puesto>();

		ReportePuesto reporte = puestoBus.reportePuestoAgua(pagina, registros,
				nroPuesto, codigoRecibo);

		Integer totalReciboPuestoLuz = reporte.getTotalRegistros();

		response.setPage(pagina);
		response.setRecords(totalReciboPuestoLuz);

		// total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoLuz,
				registros));

		response.setRows(reporte.getListaPuesto());

		return response;
	}

	@RequestMapping(value = "/generarImpresionAguaPDF", method = RequestMethod.GET)
	public void generarImpresionAguaPdf(
			@RequestParam(value = "periodo", defaultValue = "") String periodo,
			@RequestParam(value = "codigoRecibo", defaultValue = "") Integer codigoReciboAguaSocio,
			HttpServletResponse response, HttpServletRequest request) {
		
		periodo = periodo.replace("_", " ");
		File file = reciboAguaSocioBus.generarFacturacionAguaPDF(codigoReciboAguaSocio, periodo);
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

	
	@RequestMapping(value = "/generarImpresionVigilanciaPDF", method = RequestMethod.GET)
	public void generarImpresionVigilanciaPdf(
			@RequestParam(value = "periodo", defaultValue = "ABRIL 2016") String periodo,
			HttpServletResponse response, HttpServletRequest request) {
		
		periodo = periodo.replace("_", " ");
		File file = reciboAguaSocioBus.generarFacturacionVigilanciaPDF(periodo);
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

	
	
	@RequestMapping(value = "/reporteAguaSocioExcel", method = RequestMethod.GET)
	public ModelAndView downloadExcel(
			@RequestParam(value = "codigoAguaOriginal", defaultValue = "0") Integer codigoAguaOriginal) {

		// create some sample data
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reporteAguaSocioExcel(1, 1, 1, codigoAguaOriginal);
		List<ReciboAguaSocio> lista = reporte.getListaReciboAguaSocio();

		// return a view which will be resolved by an excel view resolver
		return new ModelAndView("excelViewAguaSocio", "listaRegistrosEgresos",lista);

	}
	
	
	@RequestMapping(value = "/generarFacturacionPrueba", method = RequestMethod.GET)
	public void generargenerarFacturacionPrueba(
			@RequestParam(value = "periodo", defaultValue = "") String periodo,
			@RequestParam(value = "codigoRecibo", defaultValue = "") Integer codigoReciboAguaSocio,
			HttpServletResponse response, HttpServletRequest request) {
		
		periodo = periodo.replace("_", " ");
		reciboAguaSocioBus.imprimirFactura();
		
		
		
	}

	
	@RequestMapping(value = "/recibosAgua", method = RequestMethod.GET)
    public void reporterecibosAguaPdf(
    		@RequestParam(value = "fechaInicial", defaultValue = "") String fechaInicial,
    		@RequestParam(value = "estado", defaultValue = "T") String estado,
    		HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        
		//String rutaJRXML = this.getClass().getClassLoader().getResource("/reportes/Reporte_Operaciones_Bancarias.jrxml").getPath();
		//String rutaJASPER = this.getClass().getClassLoader().getResource("/reportes/Reporte_Operaciones_Bancarias.jasper").getPath();
		String suspendido = "%";
		String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		String rutaJRXML = ruta + "Reporte_Recibos_Agua.jrxml";
		String rutaJASPER = ruta + "Reporte_Recibos_Agua.jasper";
		
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
		parameters.put("ReportTitle", "Reporte de Recibos de Agua de los Asociados");
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
}
