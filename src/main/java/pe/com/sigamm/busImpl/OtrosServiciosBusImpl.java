package pe.com.sigamm.busImpl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.OtroServicio;
import pe.com.sigamm.bus.OtrosServiciosBus;
import pe.com.sigamm.dao.OtrosServiciosDao;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;

import com.google.gson.Gson;

@Service
public class OtrosServiciosBusImpl implements OtrosServiciosBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(OtrosServiciosBusImpl.class);
	public String fechaIni = "01/07/2015";
	public String fechaFin = "01/07/2015";
	
	@Resource
	private OtrosServiciosDao otrosServiciosDao;
	
	@Override
	public String otrosServicios() {
		
		return gson.toJson(otrosServiciosDao.otrosServicios());
		
	}

	@Override
	public String otrosServiciosDetalle(OtroServicio otro) {
		
		return gson.toJson(otrosServiciosDao.otrosServiciosDetalle(otro));
		
	}
	
	@RequestMapping(value = "/iOtrosServiciosFiltro", method = RequestMethod.GET)
    public void reporteOtrosServiciosFiltro(HttpServletRequest request, HttpServletResponse response,
				@RequestParam(value = "fechaInicial", defaultValue = "01/07/2015") String fechaInicial,
				@RequestParam(value = "fechaFinal", defaultValue = "01/07/2015") String fechaFinal){	
		
		fechaIni = request.getParameter("fechaInicial");
		fechaFin = request.getParameter("fechaFinal");
        
        String ruta = System.getProperty("ruta_ireport") != null ? System.getProperty("ruta_ireport") : ""; 
		
		String rutaJRXML = ruta + "Reporte_Otros_Servicios" + ".jrxml";
		String rutaJASPER = ruta + "Reporte_Otros_Servicios" + ".jasper";
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ReportTitle", 	Constantes.IREPORT_TITULO_SERVICIOS_OTROS);
		parameters.put("Author", 		Constantes.IREPORT_AUTOR);
		parameters.put("SUBREPORT_DIR", ruta);
		parameters.put("FECHA_INICIO", fechaIni);
		parameters.put("FECHA_FIN", fechaFin);
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
		} catch (IOException e) {
			LoggerCustom.errorApp(this, "", e);
		}
 
    }
}
