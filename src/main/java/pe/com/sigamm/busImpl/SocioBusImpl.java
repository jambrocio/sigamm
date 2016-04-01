package pe.com.sigamm.busImpl;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.DetalleServicio;
import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.bean.Servicio;
import pe.com.sigamm.bean.ServiciosDetalle;
import pe.com.sigamm.bus.SocioBus;
import pe.com.sigamm.dao.SocioDao;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Service
public class SocioBusImpl implements SocioBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(SocioBusImpl.class);
	
	@Resource
	private SocioDao socioDao;
	
	@Override
	public ReporteSocio reporteSocio(int pagina, int registros, String dni, String nombre, int exportar) {
		
		return socioDao.reporteSocio(pagina, registros, dni, nombre, exportar);
	}

	@Override
	public Socio buscarSocio(Socio socio) {
		
		return socioDao.buscarSocio(socio);
	}

	@Override
	public Retorno grabarSocio(Socio socio) {
		
		Type type = new TypeToken<List<DetalleServicio>>(){}.getType();
		List<DetalleServicio> lista = gson.fromJson(socio.getListaDetalle(), type);
		
		if(lista.size() > 0){
			socioDao.eliminarSocioServicio(socio.getCodigoSocio());
			for(DetalleServicio detalle : lista){
				socioDao.grabarSocioServicio(socio.getCodigoSocio(), detalle);
			}
		}
		
		return socioDao.grabarSocio(socio);
	}

	@Override
	public Retorno eliminarSocio(Socio socio) {
		
		return socioDao.eliminarSocio(socio);
	}

	@Override
	public String opcionesServicios(int codigoSocio) {
		
		List<ServiciosDetalle> opciones = socioDao.opcionesServicios(codigoSocio); 
		
		String tituloServicio = "";
		
		List<Servicio> listaServicio = new ArrayList<Servicio>();
		List<DetalleServicio> listaDetalleServicio = new ArrayList<DetalleServicio>();
		for(ServiciosDetalle servicios : opciones){
			
			String descServicio = servicios.getNombreServicio();
			if(!descServicio.equals(tituloServicio)){
				Servicio servicio = new Servicio();
				servicio.setNombreServicio(descServicio);
				servicio.setCodigoServicio(servicios.getCodigoServicio());
				servicio.setOrdenServicio(servicios.getOrdenServicio());
				
				listaDetalleServicio = new ArrayList<DetalleServicio>();
				
				DetalleServicio detalle = new DetalleServicio();
				detalle.setCodigoServicioDetalle(servicios.getCodigoServicioDetalle());
				detalle.setNombreDetalle(servicios.getNombreDetalle());
				detalle.setImporte(servicios.getImporte());
				detalle.setObligatorio(servicios.getObligatorio());
				detalle.setOrdenDetalle(servicios.getOrdenDetalle());
				detalle.setSeleccionado(servicios.getSeleccionado());
				detalle.setFlagOtros(servicios.getFlag_otros());
				
				listaDetalleServicio.add(detalle);
				
				servicio.setDetalle(listaDetalleServicio);
				
				listaServicio.add(servicio);
				
				tituloServicio = descServicio; 
			}else{
				DetalleServicio detalle = new DetalleServicio();
				detalle.setCodigoServicioDetalle(servicios.getCodigoServicioDetalle());
				detalle.setNombreDetalle(servicios.getNombreDetalle());
				detalle.setImporte(servicios.getImporte());
				detalle.setObligatorio(servicios.getObligatorio());
				detalle.setOrdenDetalle(servicios.getOrdenDetalle());
				detalle.setSeleccionado(servicios.getSeleccionado());
				detalle.setFlagOtros(servicios.getFlag_otros());
				
				listaDetalleServicio.add(detalle);
			}
			
		}
		
		return gson.toJson(listaServicio);
		
	}

	@Override
	public Socio buscarSocioPuesto(Socio socio) {
		
		return socioDao.buscarSocioPuesto(socio);
		
	}

}
