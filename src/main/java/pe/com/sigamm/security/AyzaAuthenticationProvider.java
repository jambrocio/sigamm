package pe.com.sigamm.security;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import pe.com.sigamm.bean.Retorno;
import pe.com.sigamm.bean.Usuario;
import pe.com.sigamm.bus.AutenticacionBus;
import pe.com.sigamm.bus.UsuarioBus;
import pe.com.sigamm.modelo.PermisoUsuario;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.Seguridad;

public class AyzaAuthenticationProvider implements AuthenticationProvider
{
	@Autowired
    private HttpServletRequest request;
	
	@Autowired
	private UsuarioBus mantenimientoBus;
	
	@Autowired
	private AutenticacionBus autenticacionBus;
	
	@Autowired
	private DatosSession datosSession;
	
	public Authentication authenticate(Authentication auth)
			throws AuthenticationException {
		
		String ipAddress = request.getRemoteAddr();
		UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) auth;
		String username = token.getName();
		String clave = token.getCredentials() != null ? token.getCredentials().toString() : null;
		
		Usuario usuario = new Usuario();
		usuario.setUsuario(username);
		usuario.setClave(clave);
		usuario.setIpRemote(ipAddress);
		
		//Solo por cambio de clave
		//Inicio
		try {
			String claveDefault = Seguridad.fn_sEncrypting("PASSWORD", Constantes.CLAVE_DEFAULT);
			String claveUsuario = datosSession.getClave();
			
			if(claveDefault.equals(claveUsuario)){
				
				usuario.setUsuario(datosSession.getUsuario());
				usuario.setClave(Constantes.CLAVE_DEFAULT);//Esto falta en la app JUNTOS
				Retorno retorno = autenticacionBus.autenticacion(usuario);
				String respuesta = mantenimientoBus.resetearClave(retorno.getCodigoUsuario(), clave.toUpperCase());
				//Esto falta en la app JUNTOS
				if(respuesta.equals("00"))
					usuario.setClave(clave.toUpperCase());
				
			}
		} catch (NoSuchAlgorithmException e1) {
			
			e1.printStackTrace();
		}
		//Fin
		
		Retorno retorno = autenticacionBus.autenticacion(usuario);
		
		if(retorno.getCodigoRetorno().equals("00")){
			
			datosSession.setUsuario(usuario.getUsuario().toUpperCase());
			datosSession.setCodigoRol(retorno.getCodigoRol());
			datosSession.setCodigoUsuario(retorno.getCodigoUsuario());
			datosSession.setNombreRol(retorno.getDescripcionRol());
			datosSession.setNombresFull(retorno.getNombresFull());
			datosSession.setCodigoInstitucion(retorno.getCodigoInstitucion());
			datosSession.setNombreInstitucion(retorno.getNombreInstitucion());
			datosSession.setCodigoUt(retorno.getCodigoUt());
			datosSession.setNombreUt(retorno.getNombreUt());
			try{
				datosSession.setClave(Seguridad.fn_sEncrypting("PASSWORD", clave.toUpperCase()));
			}catch (NoSuchAlgorithmException e){
				datosSession.setClave("");
				LoggerCustom.errorApp(this, "", e);
			}
			
			String listaMenu = autenticacionBus.opcionesMenu(retorno.getCodigoUsuario());
			
			datosSession.setListaMenu(listaMenu);
			
			List<PermisoUsuario> permissoes = new ArrayList<PermisoUsuario>();//getDaoPermissao().getPermisoUsuario(usuario);
			PermisoUsuario permisos = new PermisoUsuario();
			permisos.setRole("ROLE_MEMBER");
			permisos.setUsuario(usuario);
			
			PermisoUsuario permisos1 = new PermisoUsuario();
			permisos1.setRole("ROLE_ADMIN");
			permisos1.setUsuario(usuario);
			
			AyzaAuthentication resultado = new AyzaAuthentication(usuario, permissoes);
			resultado.setAuthenticated(usuario != null);
			
			return resultado;
		}else{
			return null;
		}
		
	}
	
	public boolean supports(Class<?> authentication) {
		return (UsernamePasswordAuthenticationToken.class
				.isAssignableFrom(authentication));
	}
}
