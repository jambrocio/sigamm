package pe.com.sigamm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;

@Controller
public class ReciboAguaController {

	private static final Logger log = Logger.getLogger(ReciboAguaController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@Autowired
	private ReciboAguaBus reciboAguaBus;
	
	@Autowired
	private ReciboAguaSocioBus reciboAguaSocioBus;
	
	@RequestMapping(value = "/recibo_agua", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "servicios/recibo_agua";
	
	}	
	
	@RequestMapping(value = "/reporte-recibo-agua.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAgua> reporteReciboAgua(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<ReciboAgua> response = new ResponseListBean<ReciboAgua>();
		
		ReporteReciboAgua reporte = reciboAguaBus.reporteReciboAgua(pagina, registros, codigoRecibo);
		
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
				
		response.setRows(reporte.getListaReciboAgua());
		
		return response;
	}
	
	@RequestMapping(value = "/grabar-recibo-agua.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarReciboAgua(ReciboAgua reciboAgua){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		
		if(reciboAgua.getPeriodo().trim() == ""){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PERIODO, Constantes.PERIODO_OBLIGATORIO));
		}
		
		if(reciboAgua.getLecturaInicial() == 0){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_LECTURA_INICIAL, Constantes.LECTURA_INICIAL_OBLIGATORIO));
		}
		
		if(reciboAgua.getLecturaFinal() == 0){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_LECTURA_FINAL, Constantes.LECTURA_FINAL_OBLIGATORIO));
		}
		
		if(reciboAgua.getMonto() == 0.0){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_MONTO, Constantes.MONTO_OBLIGATORIO));
		}

		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = reciboAguaBus.grabarReciboAgua(reciboAgua);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/eliminar-recibo-agua.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String eliminarReciboAgua(ReciboAgua reciboAgua){
		
		Gson gson = new Gson();
		
		Retorno retorno = reciboAguaBus.eliminarReciboAgua(reciboAgua);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	
	@RequestMapping(value = "/reporte-recibo-agua-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAguaSocio> reporteReciboAguaPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoAguaSocio(pagina, registros, codigoRecibo);
		
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
				
		response.setRows(reporte.getListaReciboAguaSocio());
		
		return response;
	}


	@RequestMapping(value = "/editar-agua-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAguaSocio> editarReciboAguaxSocio(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "puestoSocio", defaultValue = "0") String puestoSocio,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.editarReciboAguaxSocio(pagina, registros, puestoSocio, codigoRecibo);
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros();
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
				
		response.setRows(reporte.getListaReciboAguaSocio());
			
		return response;
	}
	
	
	@RequestMapping(value = "/buscar-usuario-puesto-giro-agua.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAguaSocio> reporteUsuarioPuestoGiroAgua(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoSector", defaultValue = "0") Integer codigoSector,
			@RequestParam(value = "nroPuesto", defaultValue = "0") String nroPuesto,
			@RequestParam(value = "codigoReciboOriginal", defaultValue = "0") Integer codigoReciboOriginal){
		
		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoxAgua(pagina, registros, codigoSector, nroPuesto, codigoReciboOriginal);
		
		Integer totalReciboPuestoxAgua = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoxAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoxAgua, registros));
				
		response.setRows(reporte.getListaReciboAguaSocio());
		
		return response;
	}
	
	
	@RequestMapping(value = "/grabar-agua-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = reciboAguaSocioBus.grabarReciboAguaxSocio(reciboAguaSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/pagar-agua-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = reciboAguaSocioBus.pagarReciboAguaxSocio(reciboAguaSocio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/generarImpresionPDF", method = RequestMethod.GET)
    public ModelAndView generarFacturacionPdf(
    		@RequestParam(value = "codigoReciboAguaSocio", defaultValue = "1") Integer codigoReciboAguaSocio, HttpServletResponse response, HttpServletRequest request) {
		
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.buscarReciboAguaSocio(codigoReciboAguaSocio);
		Integer totalReciboPuestoxAgua = reporte.getTotalRegistros(); 
		
		response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Impresion ReciboAguaSocio.pdf");
        
        // return a view which will be resolved by an excel view resolver
        return new ModelAndView("pdfView", "reciboAguaSocio", reporte);
    }
	
	
	@RequestMapping(value = "/reporteAguaSocioExcel", method = RequestMethod.GET)
    public ModelAndView downloadExcel(
    		@RequestParam(value = "codigoAguaOriginal", defaultValue = "0") Integer codigoAguaOriginal) {
        
		// create some sample data
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reporteAguaSocioExcel(1, 1, 1, codigoAguaOriginal);
		
		List<ReciboAguaSocio> lista = reporte.getListaReciboAguaSocio();
		
		// return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelViewAguaSocio", "listaRegistrosEgresos", lista);
         
    }
}
