package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;

public interface SocioBus {

	public ReporteSocio reporteSocio(int pagina, int registros, String dni, String nombre, int exportar);
	
	public Socio buscarSocio(Socio socio);

	public Retorno grabarSocio(Socio socio);
	
	public Retorno eliminarSocio(Socio socio);
	
	public String opcionesServicios(int codigoSocio);
	
	public Socio buscarSocioPuesto(Socio socio);

	public List<Socio> listaSocios();
	
}
