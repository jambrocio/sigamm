package pe.com.sigamm.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.OperadoresUtil;

@Controller
public class ReciboAguaController {

	private static final Logger log = Logger.getLogger(ReciboAguaController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@Autowired
	private ReciboAguaSocioBus reciboAguaSocioBus;
	
	
	@RequestMapping(value = "/recibo_agua", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "servicios/recibo_agua";
	
	}	
	
//reporte-recibo-agua.json
	@RequestMapping(value = "/reporte-recibo-agua.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<ReciboAguaSocio> reporteReciboAguaPuesto(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoPuesto", defaultValue = "0") Integer codigoPuesto,
			@RequestParam(value = "codigoRecibo", defaultValue = "0") Integer codigoRecibo){
		
		ResponseListBean<ReciboAguaSocio> response = new ResponseListBean<ReciboAguaSocio>();
		
		ReporteReciboAguaSocio reporte = reciboAguaSocioBus.reportePuestoAgua(pagina, registros, codigoPuesto, codigoRecibo);
		
		Integer totalReciboPuestoAgua = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalReciboPuestoAgua);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalReciboPuestoAgua, registros));
				
		response.setRows(reporte.getListaReciboAguaSocio());
		
		return response;
	}



}
