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
import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.ReciboAguaBus;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.ReciboAguaSocio;
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
	
	
	@RequestMapping(value = "/reporte-recibo-agua-x-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAguaSocio> reporteReciboAguaPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoSocio", defaultValue = "0") Integer codigoSocio,
			@RequestParam(value = "codigoServicio", defaultValue = "0") Integer codigoServicio){
		
		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		
		/*ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoAguaSocio(pagina, registros, codigoSocio, codigoServicio);
		
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
				
		response.setRows(reporte.getListaReciboAguaSocio());*/
		
		return response;
	}



}
