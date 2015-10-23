package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;

public interface PuestoDao {

	public List<GiroComercial> listaGiroComercial();
	
	public Retorno grabarPuesto(Puesto puesto);
	
	public ReportePuesto reportePuesto(int pagina, int registros, String dni);
	
	public Retorno eliminarPuesto(Puesto puesto);
	
}
