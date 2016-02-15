package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.dao.ReciboAguaSocioDao;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.Retorno;

@Service
public class ReciboAguaSocioBusImpl implements ReciboAguaSocioBus {
	
	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(ReciboLuzSocioBusImpl.class);
	
	@Resource
	private ReciboAguaSocioDao reciboAguaSocioDao;

	@Override
	public ReporteReciboAguaSocio reportePuestoAguaSocio(int pagina,	int registros, int codigoRecibo) {
		
		return reciboAguaSocioDao.reporteReciboAguaSocio(pagina, registros, codigoRecibo);
		
	}

	@Override
	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo) {

		return reciboAguaSocioDao.editarReciboAguaxSocio(pagina, registros, puestoSocio, codigoRecibo);
	}

	@Override
	public ReporteReciboAguaSocio reportePuestoxAgua(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal) {

		return reciboAguaSocioDao.reportePuestoxAgua(pagina, registros, codigoSector, nroPuesto, codigoReciboOriginal);
	}

	@Override
	public Retorno grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {
		
		return reciboAguaSocioDao.grabarReciboAguaxSocio(reciboAguaSocio);
		
	}
	
	@Override
	public ReporteReciboAguaSocio buscarReciboAguaSocio(int codigoReciboAguaSocio) {

		return reciboAguaSocioDao.buscarReciboAguaSocio(codigoReciboAguaSocio);
		
	}
	
	@Override
	public ReporteReciboAguaSocio reporteAguaSocioExcel(int pagina, int registros, int exportar, int codigoAguaOriginal) {
		
		return reciboAguaSocioDao.reporteAguaSocioExcel(pagina, registros, exportar, codigoAguaOriginal);
	}

	
	@Override
	public Retorno pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {
		
		return reciboAguaSocioDao.pagarReciboAguaxSocio(reciboAguaSocio);
		
	}
}
