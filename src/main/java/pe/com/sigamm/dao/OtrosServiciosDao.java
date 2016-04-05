package pe.com.sigamm.dao;

import java.util.List;

import pe.com.sigamm.bean.OtroServicio;
import pe.com.sigamm.bean.OtroServicioDetalle;

public interface OtrosServiciosDao {
	
	public List<OtroServicio> otrosServicios();
	
	public List<OtroServicioDetalle> otrosServiciosDetalle(OtroServicio otro);
	
}