package pe.com.sigamm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import pe.com.sigamm.bus.BalanceContableBus;
import pe.com.sigamm.modelo.BalanceContable;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;

@Controller
public class BalanceContableController {

	private static final Logger log = Logger.getLogger(ReciboAguaController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@Autowired
	private BalanceContableBus balanceContableBus;
	
	@RequestMapping(value = "/reporte_balance_contable", method = RequestMethod.GET)
	public String reporte_balance_contable(HttpServletRequest request) {

		return "reportes/reporte_balance_contable";

	}
	
	
	@RequestMapping(value = "/balanceContable", method = RequestMethod.GET)
    public void reporterecibosLuzUltimoPdf(
    		HttpServletRequest request, HttpServletResponse response) throws IOException {        
		
		String fechaIni = request.getParameter("fechaIni");
		String fechaFin = request.getParameter("fechaFin");
		BalanceContable balanceContable = new BalanceContable();
		balanceContable.setFechaIni(fechaIni);
		balanceContable.setFechaFin(fechaFin);			
		Retorno retorno = balanceContableBus.BuscarBalanceContable(balanceContable);
		int codigo = retorno.getCodigo();

		if (codigo > 0) {
	        String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
			       
	        
			String rutaJRXML = ruta + "Reporte_Balance_Contable.jrxml";
			String rutaJASPER = ruta + "Reporte_Balance_Contable.jasper";
			
			log.info("Ruta JRXML : " + rutaJRXML);
			log.info("Ruta JASPER : " + rutaJASPER);
			
			
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("FECHA_INI", fechaIni);
			parameters.put("FECHA_FIN", fechaFin);
			parameters.put("SUBREPORT_DIR", ruta);
			parameters.put(JRParameter.REPORT_LOCALE, Locale.US);
			
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
 
		} else {
			enviarMensaje(codigo);
		}
		
    }
	
	
	@RequestMapping(value = "/enviar-mensaje.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody
	String enviarMensaje(int valor) {

		Gson gson = new Gson();

		int codigo = valor;
		String mensaje = "Lo sentimos..., Este reporte no contiene datos...!";

		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";

		return resultado;
	}
	
}
