package pe.com.sigamm.controller;

import java.io.File;
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

import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.modelo.OperacionesBancarias;

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
	/*
	@RequestMapping(value = "/operacionesBancarias", method = RequestMethod.GET)
    public String reporteOperacionesBancariasPdf(ModelMap modelMap, HttpServletResponse response) {
        log.info("exec reciboPdf() .:. RM= pdf/recibo");
        /*try {
            List<Recibo> lista = new ArrayList<Recibo>(1);
            Recibo recibo = new Recibo();
            recibo.setMonto("123.34");
            lista.add(recibo);
            JRBeanCollectionDataSource jrbean = new JRBeanCollectionDataSource(lista, false);
            modelMap.put("reciboKey", jrbean);
            return ("operacionesBancarias");
 
        } catch (Exception e) {
            log.info("Ocurrio un error al generar el PDF.", e);
        }*/
        /*List<OperacionesBancarias> lista = new ArrayList<OperacionesBancarias>(1);
        JRBeanCollectionDataSource jrbean = new JRBeanCollectionDataSource(lista);
        JasperReport reporte = null;
		try {
			reporte = (JasperReport) JRLoader.loadObject("jasperTemplates/Reporte_Operaciones_Bancarias.jasper");
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        JasperPrint jasperPrint = null;
		try {
			jasperPrint = JasperFillManager.fillReport(reporte, null, jrbean);
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}      

        JRExporter exporter = new JRPdfExporter();     
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);     
        exporter.setParameter(JRExporterParameter.OUTPUT_FILE, new File("reporte grafica.pdf"));      

        
        return ("operacionesBancarias");*/
        
        /*try {
        	 
            JasperReport report = JasperCompileManager.compileReport(archivo);
 
            JasperPrint print = JasperFillManager.fillReport(report, new HashMap(), coneccionSQL());
 
            JasperViewer.viewReport(print, false);
 
        } catch (JRException jRException) {
 
            System.out.println(jRException.getMessage());
 
        }
 
        return ("operacionesBancarias");
 
    }	*/
}
