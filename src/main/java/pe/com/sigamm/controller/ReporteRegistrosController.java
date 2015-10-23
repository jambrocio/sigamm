package pe.com.sigamm.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.UsuarioBus;
import pe.com.sigamm.bus.ProcesosBus;
import pe.com.sigamm.modelo.EleccionesResumen;
import pe.com.sigamm.modelo.EleccionesUt;
import pe.com.sigamm.modelo.RegistrosApp;
import pe.com.sigamm.modelo.Usuario;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.OperadoresUtil;

@Controller
public class ReporteRegistrosController {
	
	private static final Logger log = Logger.getLogger(ReporteRegistrosController.class);
	
	@Autowired
	private ProcesosBus procesosBus;
	
	@Autowired
	private UsuarioBus mantenimientoBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping(value = "/reporteVisitas", method=RequestMethod.GET)
	public String reporteVisitas(HttpServletRequest request) {
		
		return "reportes/reporteVisitas";
	
	}
	
	@RequestMapping(value = "/reporteEleccionesResultado", method=RequestMethod.GET)
	public String reporteEleccionesResultado(HttpServletRequest request) {
		
		return "reportes/reporteEleccionesResultado";
	
	}
	
	@RequestMapping(value = "/reporteEleccionesResumen", method=RequestMethod.GET)
	public String reporteEleccionesResumen(HttpServletRequest request) {
		
		return "reportes/reporteEleccionesResumen";
	
	}
	
	@RequestMapping(value = "/reporteEleccionesUt", method=RequestMethod.GET)
	public String reporteEleccionesUt(HttpServletRequest request) {
		
		return "reportes/reporteEleccionesUt";
	
	}
	
	@RequestMapping(value = "/listar-registros.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<RegistrosApp> listarRegistros(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros){
		
		//System.out.println("usuario : " + datosSession.getUsuario());
		
		ResponseListBean<RegistrosApp> response = new ResponseListBean<RegistrosApp>();
		
		Integer totalRegistros = procesosBus.cantidadRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalRegistros);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalRegistros, registros));
				
		response.setRows(procesosBus.listaRegistros(pagina, registros, 0));
		
		log.info("Logout usuario Antes 1 : " + datosSession.getUsuario());
		
		return response;
	}
	
	@RequestMapping(value = "/listar-resultado-elecciones", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Usuario> listarResultadoElecciones(
			@RequestParam(value = "codigoEleccion", defaultValue = "1") Integer codigoEleccion,
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros){
		
		ResponseListBean<Usuario> response = new ResponseListBean<Usuario>();
		
		Integer totalRegistros = procesosBus.cantidadRegistros(); 
		
		response.setPage(pagina);
		response.setRecords(totalRegistros);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalRegistros, registros));
				
		response.setRows(procesosBus.listaResultadoElecciones(codigoEleccion));
		
		return response;
	}
	
	@RequestMapping(value = "/reporteVisitasExcel", method = RequestMethod.GET)
    public ModelAndView downloadExcel() {
        // create some sample data
		List<RegistrosApp> lista = procesosBus.listaRegistros(1, 1, 1);
		
        // return a view which will be resolved by an excel view resolver
        return new ModelAndView("excelView", "listaRegistros", lista);
    }
	
	@RequestMapping(value = "/generarPdf", method = RequestMethod.GET)
    public ModelAndView downloadPdf(@RequestParam(value = "codigoEleccion", defaultValue = "1") Integer codigoEleccion, HttpServletResponse response, HttpServletRequest request) {
        // create some sample data
		//List<RegistrosApp> lista = procesosBus.listaRegistros(1, 1, 1);
		
		List<Usuario> lista = procesosBus.listaResultadoElecciones(codigoEleccion);
		
		response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Reporte Resultado Elecciones.pdf");
        
        // return a view which will be resolved by an excel view resolver
        return new ModelAndView("pdfView", "listaResultadoCandidatos", lista);
    }
	
	@RequestMapping(value="/mostrarImagen/{id}/{nombre}")
	public void mostrarImagen(HttpServletResponse response, HttpServletRequest request,@PathVariable("id") int numero, @PathVariable("nombre") String nombre) {
		
		response.setContentType("image/jpeg");
		
		String sSistemaOperativo = System.getProperty("os.name") != null ? System.getProperty("os.name") :"";
		
		//log.info("Sistema Operativo : " + sSistemaOperativo);
		
		File file;
		FileInputStream fis;
		ByteArrayOutputStream bos = null;
		try {
			if(sSistemaOperativo.equals(Constantes.WINDOWS_OS)){
				file = new File("D:\\AYZA\\" + nombre + "__" + numero + ".JPG");		//Windows
			}else{
				file = new File("/home/AYZA/" + nombre + "__" + numero + ".JPG");		//Linux
			}
			fis = new FileInputStream(file);
			bos = new ByteArrayOutputStream();
	        byte[] buf = new byte[1024];
	        
	        for (int readNum; (readNum = fis.read(buf)) != -1;) {
                bos.write(buf, 0, readNum); 
            }
	        
	        byte[] buffer = bos.toByteArray();
	        
			InputStream in1 = new ByteArrayInputStream(buffer);
			IOUtils.copy(in1, response.getOutputStream());
			
		}catch (FileNotFoundException e) {
			
			String path = this.getClass().getClassLoader().getResource("").getPath();
			try {
				String fullPath = URLDecoder.decode(path, "UTF-8");
				
				/*
				System.out.println("FullPath : " + fullPath);
				System.out.println("Valor : " + fullPath.substring(0, fullPath.length() - 16));
				System.out.println("Valor : " + request.getContextPath());
				*/
				
				if(sSistemaOperativo.equals(Constantes.WINDOWS_OS)){
					file = new File(fullPath.substring(0, fullPath.length() - 16) + "\\recursos\\images\\nodisponible_500x500.gif");	//Windows
				}else{
					file = new File("/home/no borrar/nodisponible_500x500.gif");														//Linux
				}
				
				fis = new FileInputStream(file);
				bos = new ByteArrayOutputStream();
		        byte[] buf = new byte[1024];
		        
	        	for (int readNum; (readNum = fis.read(buf)) != -1;) {
				    bos.write(buf, 0, readNum); 
				}
			    
		        byte[] buffer = bos.toByteArray();
		        
				InputStream in1 = new ByteArrayInputStream(buffer);
				IOUtils.copy(in1, response.getOutputStream());
				
			} catch (UnsupportedEncodingException e1) {
				LoggerCustom.errorApp(this, "", e1);
			}catch (FileNotFoundException e1) {
				LoggerCustom.errorApp(this, "", e1);
			}catch (IOException e1) {
				LoggerCustom.errorApp(this, "", e1);
			}
			
		}catch (IOException ex) {
         	
			LoggerCustom.errorApp(this, "", ex);
        	
        }
 
	}
	
	@RequestMapping(value = "/listar-resumen-elecciones", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<EleccionesResumen> listarResumenElecciones(
			@RequestParam(value = "codigoEleccion", defaultValue = "1") Integer codigoEleccion,
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros){
		
		ResponseListBean<EleccionesResumen> response = new ResponseListBean<EleccionesResumen>();
		
		Integer totalRegistros = 1; 
		
		response.setPage(pagina);
		response.setRecords(totalRegistros);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalRegistros, registros));
				
		response.setRows(procesosBus.listaResumenElecciones(codigoEleccion));
		
		return response;
	}
	
	@RequestMapping(value = "/listar-elecciones-ut", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<EleccionesUt> listarEleccionesUt(
			@RequestParam(value = "codigoEleccion", defaultValue = "1") Integer codigoEleccion,
			@RequestParam(value = "codigoUt", defaultValue = "1") Integer codigoUt,
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros){
		
		ResponseListBean<EleccionesUt> response = new ResponseListBean<EleccionesUt>();
		
		Integer totalRegistros = procesosBus.cantidadRegistrosEleccionesUt(codigoEleccion, codigoUt);
		
		response.setPage(pagina);
		response.setRecords(totalRegistros);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalRegistros, registros));
				
		response.setRows(procesosBus.listaEleccionesXUt(pagina, registros, codigoEleccion, codigoUt));
		
		return response;
	}
	
}
