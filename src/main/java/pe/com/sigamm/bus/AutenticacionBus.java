package pe.com.sigamm.bus;

import pe.com.sigamm.bean.Retorno;
import pe.com.sigamm.bean.Usuario;

public interface AutenticacionBus {

	public Retorno autenticacion(Usuario usuario);
	
	public String opcionesMenu(int codigoUsuario);
	
}
