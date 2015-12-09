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
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.SocioBus;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Util;
import pe.com.sigamm.util.Validar;

import com.google.gson.Gson;

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
			@RequestParam(value = "dni", defaultValue = "0") String dni,
			@RequestParam(value = "nombre", defaultValue = "") String nombre){
		
		ResponseListBean<Socio> response = new ResponseListBean<Socio>();
		
		ReporteSocio reporte = socioBus.reporteSocio(pagina, registros, dni, nombre, 0);
		
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
		}else{
			if(!Validar.esNumero(socio.getDni())){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_DNI, Constantes.DNI_NUMERO));
			}
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
		}else{
			if(!Validar.esNumero(socio.getNroPuesto())){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PUESTO, Constantes.PUESTO_NUMERO));
			}
		}
		
		if(socio.getPadron() == null || socio.getPadron().equals("")){
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PADRON, Constantes.PADRON_OBLIGATORIO));
		}else{
			if(!Validar.esNumero(socio.getPadron())){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_PADRON, Constantes.PADRON_NUMERO));
			}
		}
		
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		String codigoRetorno = "";
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = socioBus.grabarSocio(socio);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
			codigoRetorno = retorno.getIndicador();
		}
		 
		//String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"codigoRetorno\":\"" + codigoRetorno + "\",\"mensaje\":\"" + mensaje + "\"}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/eliminar-socio.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String eliminarSocio(Socio socio){
		
		Retorno retorno = socioBus.eliminarSocio(socio);
		int codigo = retorno.getCodigo();
		String mensaje = retorno.getMensaje();
		String codigoRetorno = retorno.getIndicador();
		
		//String resultado = "{\"idUsuario\":" + codigo + ",\"mensaje\":\"" + mensaje + "\"}";
		String resultado = "{\"idUsuario\":" + codigo + ",\"codigoRetorno\":\"" + codigoRetorno + "\",\"mensaje\":\"" + mensaje + "\"}";
		
		return resultado;
	}
	
	@RequestMapping(value = "/cargar-servicios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarServicios(Socio socio){
		
		return socioBus.opcionesServicios(socio.getCodigoSocio());
	}
	
	@RequestMapping(value = "/reporteSociosExcel", method = RequestMethod.GET)
    public ModelAndView downloadExcel() {
        
		// create some sample data
		ReporteSocio reporte = socioBus.reporteSocio(1, 1, "0", "", 1);
		
		List<Socio> lista = reporte.getListaSocio(); 
		
		// return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelView", "listaRegistros", lista);
         
    }
	
	@RequestMapping(value = "/buscar-socio-puesto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody Socio buscarSocioPuesto(Socio socio){
		
		return socioBus.buscarSocioPuesto(socio);
	}
}
