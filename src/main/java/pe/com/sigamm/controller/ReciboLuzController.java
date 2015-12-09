package pe.com.sigamm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;


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
			@RequestParam(value = "codigoPuesto", defaultValue = "0") Integer codigoPuesto,
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
	public @ResponseBody String eliminarPuesto(ReciboLuzSocio reciboLuzSocio){
		
		Gson gson = new Gson();
		
		Retorno retorno = reciboLuzSocioBus.editarReciboLuzxSocio(reciboLuzSocio);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
}
