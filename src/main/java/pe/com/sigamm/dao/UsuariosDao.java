package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.Imei;
import pe.com.sigamm.modelo.MenuPrincipal;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Rol;
import pe.com.sigamm.modelo.Unidad;
import pe.com.sigamm.modelo.Usuario;

public interface UsuariosDao {

	public List<Usuario> listaUsuarios(int pagina, int registros, int codigoInstitucion, int codigoUnidad);
	
	public int cantidadUsuarios(int codigoInstitucion);
	
	public List<Rol> listaRol(int codigoUt);
	
	public List<Unidad> listaUnidad();
	
	public int grabarUsuario(Usuario usuario, List<Imei> lista);
	
	public String resetearClave(int codigoUsuario, String clave);

	public Usuario buscarUsuario(String dni);
	
	public List<MenuPrincipal> buscarMenuUsuario(int codigoUsuario);
	
	public List<Usuario> listarUsuarios();
	
	public Retorno grabarMenuUsuario(int codigoUsuario, int isChecked, int codigoSubMenu);
	
}
