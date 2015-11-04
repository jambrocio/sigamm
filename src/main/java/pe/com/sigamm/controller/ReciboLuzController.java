package pe.com.sigamm.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pe.com.sigamm.session.DatosSession;

@Controller
public class ReciboLuzController {

	private static final Logger log = Logger.getLogger(ReciboLuzController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/recibo_luz", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "servicios/recibo_luz";
	
	}
}
