package pe.com.sigamm.security;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

import pe.com.sigamm.bean.Usuario;
import pe.com.sigamm.modelo.PermisoUsuario;

public class AyzaAuthentication implements Authentication {
	
	private final Usuario usuario;
	private boolean autenticado;

	public AyzaAuthentication(Usuario usuario, List<PermisoUsuario> permissoes) {
		this.usuario = usuario;
		this.permissoes = permissoes;
	}

	public String getName() {
		return usuario != null ? usuario.getUsuario() : null;
	}

	private List<PermisoUsuario> permissoes;

	public Collection<? extends GrantedAuthority> getAuthorities() {

		return permissoes;
	}

	public Object getCredentials() {
		return usuario != null ? usuario.getClave() : null;
	}

	public Object getDetails() {
		return usuario;
	}

	public Object getPrincipal() {
		return usuario != null ? usuario.getUsuario() : null;
	}

	public boolean isAuthenticated() {
		return this.autenticado;
	}

	public void setAuthenticated(boolean isAuthenticated)
			throws IllegalArgumentException {
		this.autenticado = isAuthenticated;

	}
}
