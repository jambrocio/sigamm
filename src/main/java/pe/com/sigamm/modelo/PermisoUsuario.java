package pe.com.sigamm.modelo;

import org.springframework.security.core.GrantedAuthority;

import pe.com.sigamm.bean.Usuario;

public class PermisoUsuario  implements GrantedAuthority {
	
	private String role;
	private Usuario usuario;
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	@Override
	public String getAuthority() {
		return role;
	}
	
}
