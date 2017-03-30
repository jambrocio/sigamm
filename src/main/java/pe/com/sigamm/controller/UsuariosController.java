package pe.com.sigamm.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URLDecoder;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
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

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import pe.com.sigamm.bean.CamposObligatorios;
import pe.com.sigamm.bean.Imei;
import pe.com.sigamm.bean.MenuUsuarios;
import pe.com.sigamm.bean.ResponseListBean;
import pe.com.sigamm.bus.UsuarioBus;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Rol;
import pe.com.sigamm.modelo.Unidad;
import pe.com.sigamm.modelo.Usuario;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.OperadoresUtil;
import pe.com.sigamm.util.Seguridad;
import pe.com.sigamm.util.Util;
import pe.com.sigamm.util.Validar;

@Controller
public class UsuariosController {
	
	private static final Logger log = Logger.getLogger(ReporteRegistrosController.class);
	
	@Autowired
	private UsuarioBus usuarioBus;
	
	@Autowired
	private DatosSession datosSession;
	
	@Autowired
	private UsuarioBus mantenimientoBus;
	
	@RequestMapping(value = "/usuarios", method=RequestMethod.GET)
	public String mantenimientoUsuario(HttpServletRequest request) {
		
		return "mantenimiento/usuarios";
	
	}
	
	@RequestMapping(value = "/menuUsuario", method=RequestMethod.GET)
	public String menuUsuario(HttpServletRequest request) {
		
		return "mantenimiento/menuUsuario";
	
	}
	
	@RequestMapping(value = "/usuario", method=RequestMethod.GET)
	public String usuario(HttpServletRequest request) {
		
		return "usuario";
	
	}

	@RequestMapping(value = "/listar-usuarios.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Usuario> listarUsuarios(
			@RequestParam(value = "page", defaultValue = "1") Integer pagina,
			@RequestParam(value = "rows", defaultValue = "5") Integer registros,
			@RequestParam(value = "codigoUnidad", defaultValue = "0") Integer codigoUnidad){
		
		//System.out.println("usuario : " + datosSession.getUsuario());
		
		ResponseListBean<Usuario> response = new ResponseListBean<Usuario>();
		
		Integer totalUsuarios = usuarioBus.cantidadUsuarios(datosSession.getCodigoInstitucion()); 
		
		response.setPage(pagina);
		response.setRecords(totalUsuarios);
		
		//total de paginas a mostrar
		response.setTotal(OperadoresUtil.obtenerCociente(totalUsuarios, registros));
				
		response.setRows(usuarioBus.listaUsuarios(pagina, registros, datosSession.getCodigoInstitucion(), codigoUnidad));
		
		//log.info("Logout usuario Antes 1 : " + datosSession.getUsuario());
		
		return response;
	}
	
	@RequestMapping(value = "/listar-rol.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody ResponseListBean<Rol> listarRol(@RequestParam(value = "codigoUnidad", defaultValue = "0") Integer codigoUnidad){
		
		ResponseListBean<Rol> response = new ResponseListBean<Rol>();
		response.setRows(usuarioBus.listaRol(codigoUnidad));
		
		return response;
	}
	
	@RequestMapping(value = "/listar-unidad.json", method = RequestMethod.GET, produces="application/json")
	public @ResponseBody ResponseListBean<Unidad> listarUt(){
		
		ResponseListBean<Unidad> response = new ResponseListBean<Unidad>();
		response.setRows(usuarioBus.listaUnidad());
		
		return response;
	}
	
	@RequestMapping(value = "/grabar-usuario.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarUsuario(Usuario usuario){
		/*
		log.info("Usuario : " + usuario.getUserid());
		log.info("Paterno : " + usuario.getApePaterno());
		log.info("Materno : " + usuario.getApeMaterno());
		log.info("Nombres : " + usuario.getNombres());
		log.info("Codigo Unidad Territorial : " + usuario.getCodigoUt());
		log.info("Codigo Rol : " + usuario.getCodigoRol());
		log.info("Fecha Nacimiento : " + usuario.getFechaNacimiento());
		log.info("Codigo Usuario : " + usuario.getCodigoUsuario());
		log.info("Estado : " + usuario.getEstado());
		log.info("Lista Imei : " + usuario.getListaImei());
		*/
		Gson gson = new Gson();
		Type type = new TypeToken<List<Imei>>(){}.getType();
		List<Imei> lista = gson.fromJson(usuario.getListaImei(), type);
		
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		if(usuario.getCodigoUsuario() == 0){
			
			if(usuario.getUserid() == null || usuario.getUserid().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_USUARIO, Constantes.USUARIO_OBLIGATORIO));
			}
			
			if(usuario.getDni() == null || usuario.getDni().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_DNI, Constantes.DNI_OBLIGATORIO));
			}
			
			if(usuario.getApellidoPaterno() == null || usuario.getApellidoPaterno().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEPAT, Constantes.APEPAT_OBLIGATORIO));
			}
			
			if(usuario.getApellidoMaterno() == null || usuario.getApellidoMaterno().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEMAT, Constantes.APEMAT_OBLIGATORIO));
			}
			
			if(usuario.getNombres() == null || usuario.getNombres().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_NOMBRES, Constantes.NOMBRES_OBLIGATORIO));
			}
			
			if(usuario.getFechaNacimiento() == null || usuario.getFechaNacimiento().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_FECNAC, Constantes.FECNAC_OBLIGATORIO));
			}
			
			if(usuario.getCorreo() == null || usuario.getCorreo().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CORREO, Constantes.CORREO_OBLIGATORIO));
			}else{
				if(!Validar.validarEmail(usuario.getCorreo())){
					camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CORREO, Constantes.CORREO_INVALIDO));
				}
			}
			
			if(usuario.getTelefono() == null || usuario.getTelefono().equals("")){
				
			}else{
				if(!Validar.esNumero(usuario.getTelefono())){
					camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_TELEFONO, Constantes.TELEFONO_INVALIDO));
				}
			}
							
			if(usuario.getCodigoUnidad() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_UT, Constantes.UT_OBLIGATORIO));
			}
			
			if(usuario.getCodigoRol() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_ROL, Constantes.ROL_OBLIGATORIO));
			}
			
		}else{
			
			if(usuario.getDni() == null || usuario.getDni().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_DNI, Constantes.DNI_OBLIGATORIO));
			}
			
			if(usuario.getApellidoPaterno() == null || usuario.getApellidoPaterno().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEPAT, Constantes.APEPAT_OBLIGATORIO));
			}
			
			if(usuario.getApellidoMaterno() == null || usuario.getApellidoMaterno().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_APEMAT, Constantes.APEMAT_OBLIGATORIO));
			}
			
			if(usuario.getNombres() == null || usuario.getNombres().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_NOMBRES, Constantes.NOMBRES_OBLIGATORIO));
			}
			
			if(usuario.getFechaNacimiento() == null || usuario.getFechaNacimiento().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_FECNAC, Constantes.FECNAC_OBLIGATORIO));
			}
			
			if(usuario.getCorreo() == null || usuario.getCorreo().equals("")){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CORREO, Constantes.CORREO_OBLIGATORIO));
			}else{
				if(!Validar.validarEmail(usuario.getCorreo())){
					camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CORREO, Constantes.CORREO_INVALIDO));
				}
			}
			
			if(usuario.getTelefono() == null || usuario.getTelefono().equals("")){
				
			}else{
				if(!Validar.esNumero(usuario.getTelefono())){
					camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_TELEFONO, Constantes.TELEFONO_INVALIDO));
				}
			}

			if(usuario.getCodigoUnidad() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_UT, Constantes.UT_OBLIGATORIO));
			}
			
			if(usuario.getCodigoRol() == 0){
				camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_ROL, Constantes.ROL_OBLIGATORIO));
			}
		}
		
		int codigo = 0;
		String listaObligatorios = gson.toJson(camposObligatorios);
		
		if(camposObligatorios.size() > 0){
			
			codigo = 0;
			
		}else{
		
			codigo = usuarioBus.grabarUsuario(usuario, lista);
			
		}
		 
		String resultado = "{\"idUsuario\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + "}";
		
		
		return resultado;
	}
	
	@RequestMapping(value = "/resetear-clave.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String resetearClave(@RequestParam(value = "codigoUsuario", defaultValue = "0") Integer codigoUsuario){
		
		String resultado = "{\"codigo\":\"" + usuarioBus.resetearClave(codigoUsuario, "") + "\"}";
		
		return resultado;
	}
	
	@RequestMapping(value="/mostrarImagenPersonal/{dni}")
	public void mostrarImagenPersonal(HttpServletResponse response, HttpServletRequest request, @PathVariable("dni") String dni) {
		
		response.setContentType("image/jpeg");
		
		String sSistemaOperativo = System.getProperty("os.name") != null ? System.getProperty("os.name") :"";
		
		//log.info("Sistema Operativo : " + sSistemaOperativo);
		
		File file;
		FileInputStream fis;
		ByteArrayOutputStream bos = null;
		try {
			if(sSistemaOperativo.equals(Constantes.WINDOWS_OS)){
				file = new File(Constantes.RUTA_FOTOS_WINDOWS + dni + ".JPG");		//Windows
			}else{
				file = new File(Constantes.RUTA_FOTOS_LINUX + dni + ".JPG");		//Linux
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
					file = new File(fullPath.substring(0, fullPath.length() - 16) + "\\recursos\\images\\nodisponible_100x100.gif");	//Windows
				}else{
					file = new File("/home/no borrar/nodisponible_100x100.gif");														//Linux
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
	
	@RequestMapping(value = "/buscar-usuario.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody Usuario buscarUsuario(
			@RequestParam(value = "dni", defaultValue = "0") String dni){
		
		return usuarioBus.buscarUsuario(dni);
	}
	
	@RequestMapping(value = "/buscar-menu-usuario.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String buscarMenuUsuario(
			@RequestParam(value = "codigoUsuario", defaultValue = "0") int codigoUsuario){
		
		return usuarioBus.buscarMenuUsuario(codigoUsuario);
	}
	
	@RequestMapping(value = "/listar-usuarios.json", method = RequestMethod.GET, produces="application/json")
	public @ResponseBody String listarUsuariosAll(){
		
		return usuarioBus.listarUsuarios();
	}
	
	@RequestMapping(value = "/grabar-menu-usuario.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarMenuUsuarios(@RequestParam(value = "menuDetalle", defaultValue = "") String menuDetalle){
		
		Gson gson = new Gson();
		Type type = new TypeToken<List<MenuUsuarios>>(){}.getType();
		List<MenuUsuarios> lista = gson.fromJson(menuDetalle, type);
		
		usuarioBus.grabarMenuUsuario(lista);
		
		String resultado = "{\"retorno\":\"" + "00" + "\", \"mensaje\":\"" + "Se realizo el registro satisfactoriamente." + "\"}";
		return resultado;
	}
	
	@RequestMapping(value = "/grabar-cambiar-clave.json", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String grabarCambiarClave(
			@RequestParam(value = "claveActual", defaultValue = "") String claveActual,
			@RequestParam(value = "nuevaClave", defaultValue = "") String nuevaClave,
			@RequestParam(value = "nuevaClaveRepetir", defaultValue = "") String nuevaClaveRepetir) throws NoSuchAlgorithmException{
		
		Gson gson = new Gson();
		List<CamposObligatorios> camposObligatorios = new ArrayList<CamposObligatorios>();
		
		int lclaveActual 		= claveActual.trim().length();
		int lnuevaClave 		= nuevaClave.trim().length();
		int lnuevaClaveRepetir 	= nuevaClaveRepetir.trim().length(); 
		
		if(lclaveActual == 0)
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CLAVE_ACTUAL, Constantes.CLAVE_ACTUAL_OBLIGATORIO));
		
		if(lnuevaClave == 0)
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CLAVE_NUEVA, Constantes.CLAVE_NUEVA_OBLIGATORIO));
		
		if(lnuevaClaveRepetir == 0)
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CLAVE_NUEVA_REPETIR, Constantes.CLAVE_NUEVA_REPETIR_OBLIGATORIO));
		
		if(!nuevaClave.equals(nuevaClaveRepetir))
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CLAVE_NUEVA_REPETIR, Constantes.CLAVE_NUEVA_REPETIR_NO_IGUAL));
		
		String claveEncriptada = Seguridad.fn_sEncrypting("PASSWORD", claveActual.toUpperCase());
		
		if(!datosSession.getClave().equals(claveEncriptada))
			camposObligatorios.add(Util.retornarObjeto(Constantes.ETIQUETA_CLAVE_ACTUAL, Constantes.CLAVE_ACTUAL_NO_IGUAL));
		
		String listaObligatorios = gson.toJson(camposObligatorios);
		String resultado = "";
		if(camposObligatorios.size() > 0){
			
			resultado = "{\"idFacturacion\":" + 0 + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + "Error" + "\"}";
			
		}else{
			
			String respuesta = mantenimientoBus.resetearClave(datosSession.getCodigoUsuario(), nuevaClave.toUpperCase());
			String mensaje = "";
			int codigo = 0;
			if(respuesta.equals("00")){
				mensaje = "El cambio de clave se realizo satisfactoriamente.";
				codigo = 1;
			}else{
				mensaje = "El cambio de clave tuvo problemas, vuelva a intertar.";
				codigo = 0;
			}
			
			resultado = "{\"codigo\":" + codigo + ",\"camposObligatorios\":" + listaObligatorios + ",\"mensaje\":\"" + mensaje + "\"}";
			
		}
		
		return resultado;
		
	}
}
