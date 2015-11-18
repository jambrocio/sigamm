package pe.com.sigamm.dao;

import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;

public interface SocioDao {
	
	public ReporteSocio reporteSocio(int pagina, int registros, String dni);
	
	public Socio buscarSocio(Socio socio);
	
	public Retorno grabarSocio(Socio socio);
	
}
