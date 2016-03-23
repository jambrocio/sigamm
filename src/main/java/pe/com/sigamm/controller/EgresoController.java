package pe.com.sigamm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.bouncycastle.asn1.ocsp.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bus.EgresoBus;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.session.DatosSession;

@Controller
public class EgresoController {

	private static final Logger log = Logger.getLogger(ReciboAguaController.class);
	public String fechaIni = "01/07/2015";
	public String fechaFin = "01/07/2015";
	
	@Autowired
	private EgresoBus egresoBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/reporte_egreso", method = RequestMethod.GET)
	public String reporte_egreso(HttpServletRequest request) {

		return "reportes/reporte_egreso";

	}
	
	
	@RequestMapping(value = "/reportarEgresoExcel", method = RequestMethod.GET)
	public ModelAndView downloadEgresoExcel(HttpServletRequest request,
			@RequestParam(value = "fechaInicial", defaultValue = "01/07/2015") String fechaInicial,
			@RequestParam(value = "fechaFinal", defaultValue = "01/07/2015") String fechaFinal){
			

		fechaIni = request.getParameter("fechaInicial");
		fechaFin = request.getParameter("fechaFinal");
		
		ReporteEgreso reporte = egresoBus.reportarEgreso(fechaInicial, fechaFinal);		
		List<Egreso> lista = reporte.getListaEgreso();		
		// return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelViewEgresos", "listaRegistrosEgresos", lista);
	}
	
}
