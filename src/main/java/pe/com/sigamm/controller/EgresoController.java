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

import com.google.gson.Gson;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.EgresoBus;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Cuenta;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.OperadoresUtil;

@Controller
public class EgresoController {

	private static final Logger log = Logger.getLogger(EgresoController.class);
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
	
	@RequestMapping(value = "/egreso_cuenta", method = RequestMethod.GET)
	public String egreso_cuenta(HttpServletRequest request) {

		return "facturacion/egreso_cuenta";

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
        return new ModelAndView("excelViewReporteEgresos", "listaRegistrosEgresos", lista);
	}
	
	
	@RequestMapping(value = "/reporte-operaciones-bancarias.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<OperacionesBancarias> reporteOperacionesBancarias(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "20") Integer registros,
			@RequestParam(value = "codigoOperacionesBancarias", defaultValue = "0") String codigoOperacionesBancarias){
		
		ResponseListBean<OperacionesBancarias> response = new ResponseListBean<OperacionesBancarias>();
		
		ReporteOperacionesBancarias reporteOperacionesBancarias = egresoBus.reporteOperacionesBancarias(pagina, registros, codigoOperacionesBancarias);
		
		Integer totalEgreso = reporteOperacionesBancarias.getTotalRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalEgreso);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalEgreso, registros));
				
		response.setRows(reporteOperacionesBancarias.getListaOperacionesBancarias());
		
		return response;
	}
	
	@RequestMapping(value = "/cargar-cuentas-bancarias.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cargarCuentas(Cuenta cuenta){
		
		return egresoBus.opcionesCuentas(cuenta);
	}
	
	
	@RequestMapping(value = "/grabar-operacion-bancaria.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarOperacionesBancarias(OperacionesBancarias operacionesBancarias){
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(operacionesBancarias.getId() == 0){
			
			
		}
		
		int codigo = 0;
		String mensaje = "";
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
			
			Retorno retorno = egresoBus.grabarOperacionesBancarias(operacionesBancarias);
			codigo = retorno.getCodigo();
			mensaje = retorno.getMensaje();
		}
	 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
		
		return resultado;
	}
}
