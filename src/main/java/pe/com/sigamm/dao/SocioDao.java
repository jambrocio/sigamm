package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.DetalleServicio;
import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.bean.ServiciosDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;

public interface SocioDao {
	
	public ReporteSocio reporteSocio(int pagina, int registros, String dni, String nombre, int exportar);
	
	public Socio buscarSocio(Socio socio);
	
	public Retorno grabarSocio(Socio socio);
	
	public Retorno eliminarSocio(Socio socio);

	public List<ServiciosDetalle> opcionesServicios(int codigoSocio);
	
	public void grabarSocioServicio(int codigoSocio, DetalleServicio detalle);
	
	public void eliminarSocioServicio(int codigoSocio);
	
	public Socio buscarSocioPuesto(Socio socio);
	
	public List<Socio> listaSocios();
	
}
