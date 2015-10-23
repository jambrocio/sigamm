package pe.com.sigamm.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.Seguridad;

@Controller
public class LoginController {
	
	private static final Logger log = Logger.getLogger(LoginController.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@RequestMapping("/form")
	public String initFormulario() {
		return "login";
	}
	
	public String login(HttpServletRequest request, HttpServletResponse response) {
		return "/login";
	}
	
	@RequestMapping(value = "/error", method=RequestMethod.GET)
	public String error(HttpServletRequest request, HttpServletResponse response) {
		//return "error";
		return "inicio";
	}
	
	@RequestMapping(value = "/", method=RequestMethod.GET)
	public String loginRaiz(HttpServletRequest request, HttpServletResponse response) {
		return "login";
	}
	
	@RequestMapping(value = "/login", method=RequestMethod.GET)
	public String loginInicioGet(ServletRequest request, ServletResponse response) {
		return "login";
	}
	
	@RequestMapping(value = "/login", method=RequestMethod.POST)
	public String loginInicioPost(ServletRequest request, ServletResponse response) {
		return "login";
	}
	
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		//log.info("Logout usuario Despues : " + datosSession.getUsuario());
		
		return "login";
	}
	
	@RequestMapping(value = "/autentica", method=RequestMethod.GET)
	public String autenticar(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		session.setAttribute("datosSession", datosSession);
		
		String claveDefault;
		try {
			claveDefault = Seguridad.fn_sEncrypting("PASSWORD", Constantes.CLAVE_DEFAULT);
			String claveUsuario = datosSession.getClave();
			if(claveDefault.equals(claveUsuario)){
				return "resetear";
			}else{
				return "redirect:inicio";
			}
		}catch (NoSuchAlgorithmException e){
			LoggerCustom.errorApp(this, "", e);
			return "redirect:inicio";
		}
			
	}
	
	@RequestMapping(value = "/inicio", method=RequestMethod.GET)
	public String inicio(HttpServletRequest request, HttpServletResponse response) {
		
		/*
		HttpSession session = request.getSession();
		session.setAttribute("usuario", "jorge ambrocio");
		*/
		return "inicio";
	}
	
	@RequestMapping(value = "/obtener-datos-session.json", method = RequestMethod.POST,produces="application/json")
	public @ResponseBody DatosSession obtenerDatosSession(){
		
		DatosSession datos = datosSession;
		
		return datos;
	}
	
	@RequestMapping("/muestra")
	public String muestra(HttpServletRequest request, HttpServletResponse response) {
		
		return "muestra";
	}
	
}
