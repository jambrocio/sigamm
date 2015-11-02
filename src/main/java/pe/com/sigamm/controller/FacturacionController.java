package pe.com.sigamm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.bus.PuestoBus;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.session.DatosSession;

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
	
	@RequestMapping(value = "/listar-concepto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<Concepto> listarConcepto(){
		
		return facturacionBus.listaConcepto();
	}
}
