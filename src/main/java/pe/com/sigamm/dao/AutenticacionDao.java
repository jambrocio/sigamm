package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.Retorno;
import pe.com.sigamm.bean.Usuario;
import pe.com.sigamm.modelo.MenuPrincipal;

public interface AutenticacionDao {

	public Retorno autenticacion(Usuario usuario);
	
	public List<MenuPrincipal> opcionesMenu(int codigoUsuario);
	
}
