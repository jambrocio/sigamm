package pe.com.sigamm.controller;

import java.io.File;
import java.io.InputStream;
import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.view.JasperViewer;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.session.DatosSession;

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
    public String reporteOperacionesBancariasPdf(ModelMap modelMap, HttpServletResponse response) {
        log.info("exec reciboPdf() .:. RM= pdf/recibo");      
        
        try {
        	log.info(getClass());
        	System.setProperty("java.awt.headless", "true");
        	//String ruta =  getClass().getResource("reportes/Reporte_Operaciones_Bancarias.jrxml").getPath();
            JasperReport report = JasperCompileManager.compileReport("D://Proyectos//MMH//reportes//Reporte_Operaciones_Bancarias.jrxml");
            JasperPrint print = JasperFillManager.fillReport(report, new HashMap(), coneccionSQL());
            JasperViewer.viewReport(print, false);
        } catch (JRException jRException) {
            System.out.println(jRException.getMessage());
        }
        return ("operacionesBancarias");
 
    }
	

	private Connection coneccionSQL() {
			Connection con = null;
            try {
                    String cadena;
                    cadena="jdbc:oracle:thin:@192.168.32.6:7980:p65dbprd";
                    Class.forName("oracle.jdbc.OracleDriver");
                    con = DriverManager.getConnection(cadena, "contraloria","contraloria");
            } catch(Exception e) {
                   System.out.println(e.getMessage());
            }
            
			return con;
    }
 

}
