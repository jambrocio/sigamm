package pe.com.sigamm.modelo;

import java.util.List;

public class Menu {

	String tituloMenu;
	List<MenuNiveles> niveles;
	
	public String getTituloMenu() {
		return tituloMenu;
	}
	public void setTituloMenu(String tituloMenu) {
		this.tituloMenu = tituloMenu;
	}
	public List<MenuNiveles> getNiveles() {
		return niveles;
	}
	public void setNiveles(List<MenuNiveles> niveles) {
		this.niveles = niveles;
	}
	
}
