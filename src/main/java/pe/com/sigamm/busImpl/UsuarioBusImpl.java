package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.Imei;
import pe.com.sigamm.bus.UsuarioBus;
import pe.com.sigamm.dao.UsuariosDao;
import pe.com.sigamm.modelo.Rol;
import pe.com.sigamm.modelo.Unidad;
import pe.com.sigamm.modelo.Usuario;

import com.google.gson.Gson;

@Service
public class UsuarioBusImpl implements UsuarioBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(UsuarioBusImpl.class);
	
	@Resource
	private UsuariosDao usuarioDao;
	
	@Override
	public List<Usuario> listaUsuarios(int pagina, int registros, int codigoInstitucion, int codigoUt) {
		
		return usuarioDao.listaUsuarios(pagina, registros, codigoInstitucion, codigoUt);
	}

	@Override
	public int cantidadUsuarios(int codigoInstitucion) {
		
		return usuarioDao.cantidadUsuarios(codigoInstitucion);
	}

	@Override
	public List<Rol> listaRol(int codigoUt) {
		
		/*
		List<Rol> lista = usuarioDao.listaRol(); 
		return gson.toJson(lista);
		*/
		
		return usuarioDao.listaRol(codigoUt);
	}

	@Override
	public List<Unidad> listaUnidad() {
		/*
		List<UnidadTerritorial> lista = usuarioDao.listaUnidadTerritotial(); 
		return gson.toJson(lista);
		*/
		return usuarioDao.listaUnidad();
	}

	@Override
	public int grabarUsuario(Usuario usuario, List<Imei> lista) {
		
		int codigoUsuario = usuarioDao.grabarUsuario(usuario, lista);
		
		return codigoUsuario;
	}

	@Override
	public String resetearClave(int codigoUsuario, String clave) {
		
		return usuarioDao.resetearClave(codigoUsuario, clave);
	}

	@Override
	public Usuario buscarUsuario(String dni) {

		return usuarioDao.buscarUsuario(dni);
	}

}
