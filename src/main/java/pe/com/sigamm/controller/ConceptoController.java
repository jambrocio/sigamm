package pe.com.sigamm.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.ConceptoBus;
import pe.com.sigamm.modelo.Concepto;
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
}
