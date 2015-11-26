package pe.com.sigamm.controller;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bus.FacturacionBus;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;

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
}
