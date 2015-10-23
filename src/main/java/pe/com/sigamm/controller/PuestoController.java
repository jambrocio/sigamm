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

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.PuestoBus;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;

import com.google.gson.Gson;

@Controller
public class PuestoController {
	
private static final Logger log = Logger.getLogger(PuestoController.class);
	
	@Autowired
	private PuestoBus puestoBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/puesto", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "mantenimiento/puesto";
	
	}
	
	@RequestMapping(value = "/listar-giro-comercial.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody List<GiroComercial> listarGiroComercial(){
		
		return puestoBus.listaGiroComercial();
	}
	
	@RequestMapping(value = "/grabar-puesto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarPuesto(Puesto puesto){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(puesto.getCodigoPuesto() == 0){
			
			if(puesto.getCodigoUsuario() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_USUARIO, Constantes.DNI_OBLIGATORIO));
			}
			
			if(puesto.getCodigoGiro() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_GIRO_COMERCIAL, Constantes.GIRO_COMERCIAL_OBLIGATORIO));
			}
			
			if(puesto.getNroPuesto() == null || puesto.getNroPuesto().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PUESTO, Constantes.PUESTO_OBLIGATORIO));
			}
			
		}else{
			
			if(puesto.getCodigoGiro() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_GIRO_COMERCIAL, Constantes.GIRO_COMERCIAL_OBLIGATORIO));
			}
			
			if(puesto.getNroPuesto() == null || puesto.getNroPuesto().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PUESTO, Constantes.PUESTO_OBLIGATORIO));
			}
		}
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = puestoBus.grabarPuesto(puesto);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/reporte-puestos.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Puesto> reportePuestos(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros,
			@RequestParam(value = "dni", defaultValue = "0") String dni){
		
		ResponseListBean<Puesto> response = new ResponseListBean<Puesto>();
		
		ReportePuesto reporte = puestoBus.reportePuesto(pagina, registros, dni);
		
		Integer totalPuestos = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalPuestos);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalPuestos, registros));
				
		response.setRows(reporte.getListaPuesto());
		
		//log.info("Logout usuario Antes 1 : " + datosSession.getUsuario());
		
		return response;
	}
	
	@RequestMapping(value = "/eliminar-puesto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String eliminarPuesto(Puesto puesto){
		
		Gson gson = new Gson();
		
		Retorno retorno = puestoBus.eliminarPuesto(puesto);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
}
