package pe.com.sigamm.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteProcesamiento;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.ProcesosBus;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Procesamiento;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.OperadoresUtil;

@Controller
public class ProcesoController {

	private static final Logger log = Logger.getLogger(ProcesoController.class);
	
	@Autowired
	private ProcesosBus procesosBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/proceso", method = RequestMethod.GET)
	public String servicio(HttpServletRequest request) {

		return "servicios/proceso";

	}
	
	@RequestMapping(value = "/procesamiento", method=RequestMethod.GET)
	public String procesamiento(HttpServletRequest request) {
		
		return "servicios/procesamiento";
	
	}
	
	@RequestMapping(value = "/reporte-procesos.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Procesamiento> reporteServicios(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros){
		
		ResponseListBean<Procesamiento> response = new ResponseListBean<Procesamiento>();
		
		ReporteProcesamiento reporte = procesosBus.reporteProcesamiento(pagina, registros);
		
		Integer totalServicios = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalServicios);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalServicios, registros));
				
		response.setRows(reporte.getListaProcesamiento());
		
		return response;
	}
	
	@RequestMapping(value = "/procesar-cuota-administrativa.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String procesarCuotaAdministrativa(Procesamiento procesamiento){
		
		Gson gson = new Gson();
		
		Retorno retorno 	= procesosBus.procesarCuotaAdministrativa(procesamiento);
		int codigo 			= retorno.getCodigo();
		String mensaje 		= retorno.getMensaje();
		String indicador 	= retorno.getIndicador(); 
		
		String resultado = "{\"codigo\":" + codigo + ",\"mensaje\":\"" + mensaje + "\",\"indicador\":\"" + indicador + "\"}";
		
		return resultado;
	}
	
	@RequestMapping(value = "/procesar-vigilancia.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String procesarVigilancia(Procesamiento procesamiento){
		
		Gson gson = new Gson();
		
		Retorno retorno 	= procesosBus.procesarVigilancia(procesamiento);
		int codigo 			= retorno.getCodigo();
		String mensaje 		= retorno.getMensaje();
		String indicador	= retorno.getIndicador();
		 
		String resultado = "{\"codigo\":" + codigo + ",\"mensaje\":\"" + mensaje + "\",\"indicador\":\"" + indicador + "\"}";
		
		return resultado;
	}
}
