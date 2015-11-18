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
import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.SocioBus;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;

@Controller
public class SocioController {
	
private static final Logger log = Logger.getLogger(SocioController.class);
	
	@Autowired
	private SocioBus socioBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/socio", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "mantenimiento/socio";
	
	}
	
	@RequestMapping(value = "/reporte-socios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Socio> reporteSocios(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "dni", defaultValue = "0") String dni){
		
		ResponseListBean<Socio> response = new ResponseListBean<Socio>();
		
		ReporteSocio reporte = socioBus.reporteSocio(pagina, registros, dni);
		
		Integer totalSocios = reporte.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalSocios);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalSocios, registros));
				
		response.setRows(reporte.getListaSocio());
		
		return response;
	}
	
	@RequestMapping(value = "/buscar-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody Socio buscarSocio(Socio socio){
		
		return socioBus.buscarSocio(socio);
	}
	
	@RequestMapping(value = "/grabar-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarSocio(Socio socio){
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(socio.getDni() == null || socio.getDni().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_DNI, Constantes.DNI_OBLIGATORIO));
		}
		
		if(socio.getApellidoPaterno() == null || socio.getApellidoPaterno().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEPAT, Constantes.APEPAT_OBLIGATORIO));
		}
		
		if(socio.getApellidoMaterno() == null || socio.getApellidoMaterno().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEMAT, Constantes.APEMAT_OBLIGATORIO));
		}
		
		if(socio.getNombres() == null || socio.getNombres().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_NOMBRES, Constantes.NOMBRES_OBLIGATORIO));
		}
		
		if(socio.getFechaNacimiento() == null || socio.getFechaNacimiento().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_FECNAC, Constantes.FECNAC_OBLIGATORIO));
		}
		
		if(socio.getFechaIngreso() == null || socio.getFechaIngreso().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_FECING, Constantes.FECING_OBLIGATORIO));
		}
		
		if(socio.getCodigoGiro() == 0){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_GIRO_COMERCIAL, Constantes.GIRO_COMERCIAL_OBLIGATORIO));
		}
		
		if(socio.getNroPuesto() == null || socio.getNroPuesto().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PUESTO, Constantes.PUESTO_OBLIGATORIO));
		}
		
		if(socio.getPadron() == null || socio.getPadron().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PADRON, Constantes.PADRON_OBLIGATORIO));
		}
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = socioBus.grabarSocio(socio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
}
