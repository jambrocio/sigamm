package pe.com.sigamm.controller;

import java.io.File;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
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

	
	@RequestMapping(value = "/reportar-egreso.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String reportarEgreso(Egreso egreso){
		Gson gson = new Gson();
		
		try{
			String fileName = System.getProperty("user.dir") +"/src/main/resources/reportes/Reporte_General_Egresos.jasper";
            
            if (fileName == null) 
            {                
                System.out.println("No encuentro el archivo del reporte.");
                System.exit(2);
            }
            
            /*JasperReport masterReport = (JasperReport) JRLoader.loadObject(fileName);
            JasperPrint jasperPrint = JasperFillManager.fillReport(masterReport, null, (Connection) null);
            JasperExportManager.exportReportToPdf(jasperPrint);*/
            
            String fileJasper = "D:\\tools\\workspaces\\Reportes\\Reporte_General_Egresos.jasper";
            //JasperPrint print = JasperFillManager.fillReport(fileJasper,null,new JREmptyDataSource());
            JasperPrint jasperPrint = JasperFillManager.fillReport(fileJasper, null, (Connection) null);
            JasperViewer jviewer = new JasperViewer(jasperPrint,false);
            jviewer.setVisible(true);
            
	        /*File theFile = new File(fileName);
	        JRDesignQuery newQuery = new JRDesignQuery();
	        JasperDesign jasperDesign = JRXmlLoader.load(theFile);
	        newQuery.setText(theQuery);
	        jasperDesign.setQuery(newQuery);
	        
	         JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
	         JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, Connection);
	         JasperViewer jviewer = new JasperViewer(jasperPrint,false);
	         jviewer.setTitle("Sistema de gestión de Cartera");
	         jviewer.setVisible(true);*/
		}
		catch (Exception e){
			System.out.println("Mensaje de Error:"+e.getMessage());
		}
	 
		String resultado = ""; //"{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
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
	
}
