package pe.com.sigamm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bus.SocioBus;
import pe.com.sigamm.modelo.Socio;
import pe.com.sigamm.session.DatosSession;

@Controller
public class ProcesoController {

	private static final Logger log = Logger.getLogger(ProcesoController.class);
	
	@Autowired
	private SocioBus socioBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/proceso", method = RequestMethod.GET)
	public String servicio(HttpServletRequest request) {

		return "servicios/proceso";

	}
	/*
	@RequestMapping(value = "/listar-socios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<Socio> listarSocios(){
		
		return socioBus.listaSocios();
	}
	*/
	/*@RequestMapping(value = "/reporte-conceptos.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Concepto> reporteConceptos(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoConcepto", defaultValue = "0") Integer codigoConcepto){
		
		ResponseListBean<Concepto> response = new ResponseListBean<Concepto>();
		
		return response;
	}*/
}
