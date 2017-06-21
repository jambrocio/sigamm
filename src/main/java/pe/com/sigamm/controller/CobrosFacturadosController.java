package pe.com.sigamm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
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

import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;

@Controller
public class CobrosFacturadosController {

	private static final Logger log = Logger.getLogger(CobrosFacturadosController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/reporte_cobros_facturados", method = RequestMethod.GET)
	public String cobrosFacturados(HttpServletRequest request) {

		return "reportes/reporte_cobros_facturados";

	}
	
	@RequestMapping(value = "/reportarCobrosFacturados", method = RequestMethod.GET)
    public void reportecobrosFacturadosPdf(
    		HttpServletRequest request, HttpServletResponse response) throws IOException {        
		
		String fechaIni = request.getParameter("fechaInicial");
		String fechaFin = request.getParameter("fechaFinal");

		String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		String rutaJRXML = ruta + "Reporte_Facturacion_por_Fechas" + ".jrxml";
		String rutaJASPER = ruta + "Reporte_Facturacion_por_Fechas" + ".jasper";
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		//parameters.put("ReportTitle", Constantes.IREPORT_TITULO_FACTURACION_DIARIO);
		//parameters.put("Author", Constantes.IREPORT_AUTOR);
		parameters.put("SUBREPORT_DIR", ruta);
		//parameters.put("P_CODIGO_USUARIO", datosSession.getCodigoUsuario());
		parameters.put("FECHA_INICIAL", fechaIni);
		parameters.put("FECHA_FINAL", fechaFin);
		
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
