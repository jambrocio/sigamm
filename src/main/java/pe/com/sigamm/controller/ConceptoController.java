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
import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.ConceptoBus;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.OperadoresUtil;

@Controller
public class ConceptoController {

	private static final Logger log = Logger.getLogger(ConceptoController.class);
	
	@Autowired
	private ConceptoBus conceptoBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/concepto", method = RequestMethod.GET)
	public String concepto(HttpServletRequest request) {

		return "mantenimiento/concepto";

	}

	@RequestMapping(value = "/reporte-conceptos.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Concepto> reporteConceptos(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoConcepto", defaultValue = "0") Integer codigoConcepto){
		
		ResponseListBean<Concepto> response = new ResponseListBean<Concepto>();
		
		ReporteConcepto reporteConcepto = conceptoBus.reporteConcepto(pagina, registros, codigoConcepto);
		
		Integer totalConcepto = reporteConcepto.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalConcepto);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalConcepto, registros));
				
		response.setRows(reporteConcepto.getListaConcepto());
		
		return response;
	}
	
	@RequestMapping(value = "/grabar-concepto.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarConcepto(Concepto concepto){
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
				
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = conceptoBus.grabarConcepto(concepto);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
	 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		return resultado;
	}
}
