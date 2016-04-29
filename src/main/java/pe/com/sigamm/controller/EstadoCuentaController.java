package pe.com.sigamm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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

import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;

@Controller
public class EstadoCuentaController {

	private static final Logger log = Logger.getLogger(ReciboAguaController.class);
	public String fechaIni = "01/07/2015";
	public String fechaFin = "01/07/2015";
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/reporte_estado_cuenta", method = RequestMethod.GET)
	public String reporte_estado_cuenta(HttpServletRequest request) {

		return "reportes/reporte_estado_cuenta";

	}
	
	@RequestMapping(value = "/operacionesBancarias", method = RequestMethod.GET)
    public void reporteOperacionesBancariasPdf(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        
		String rutaJRXML = this.getClass().getClassLoader().getResource("/reportes/Reporte_Operaciones_Bancarias.jrxml").getPath();
		String rutaJASPER = this.getClass().getClassLoader().getResource("/reportes/Reporte_Operaciones_Bancarias.jasper").getPath();
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ReportTitle", "Reporte de Operaciones Bancarias");
		parameters.put("Author", "SIGAMM");
		
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
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
 
    }
	

	private Connection coneccionSQL() {
			Connection con = null;
            try {
                    String cadena;
                    cadena="jdbc:oracle:thin:@192.168.32.6:7980:p65dbprd";
                    Class.forName("oracle.jdbc.OracleDriver");
                    con = DriverManager.getConnection(cadena, "contraloria","contraloria1");
            } catch(Exception e) {
                   System.out.println(e.getMessage());
            }
            
			return con;
    }
 

}
