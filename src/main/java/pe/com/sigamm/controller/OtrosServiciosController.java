package pe.com.sigamm.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bean.OtroServicio;
import pe.com.sigamm.bus.OtrosServiciosBus;
import pe.com.sigamm.session.DatosSession;

@Controller
public class OtrosServiciosController {
	
private static final Logger log = Logger.getLogger(OtrosServiciosController.class);
	
	@Autowired
	private OtrosServiciosBus otrosServiciosBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/otros", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "servicios/otros";
	
	}
	
	@RequestMapping(value = "/cargar-otros-servicios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarOtrosServicios(){
		
		return otrosServiciosBus.otrosServicios();
	}
	
	@RequestMapping(value = "/cargar-otros-servicios-detalle.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarOtrosServiciosDetalle(OtroServicio otro){
		
		return otrosServiciosBus.otrosServiciosDetalle(otro);
	}
}
