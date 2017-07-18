package pe.com.sigamm.busImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import pe.com.sigamm.bean.ReporteProcesamiento;
import pe.com.sigamm.bus.ProcesosBus;
import pe.com.sigamm.dao.ProcesosDao;
import pe.com.sigamm.modelo.EleccionesResumen;
import pe.com.sigamm.modelo.EleccionesUt;
import pe.com.sigamm.modelo.Procesamiento;
import pe.com.sigamm.modelo.RegistrosApp;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Usuario;

@Service
public class ProcesosBusImpl implements ProcesosBus {
	
	@Resource
	private ProcesosDao procesosDao;
	
	@Override
	public List<RegistrosApp> listaRegistros(int pagina, int registros, int todos){
		
		return procesosDao.listaRegistros(pagina, registros, todos);
	}

	@Override
	public int cantidadRegistros() {
		
		return procesosDao.cantidadRegistros();
	}

	@Override
	public List<Usuario> listaResultadoElecciones(int codigoEleccion) {
		
		return procesosDao.listaResultadoElecciones(codigoEleccion);
	}

	@Override
	public List<EleccionesResumen> listaResumenElecciones(int codigoEleccion) {
		
		return procesosDao.listaResumenElecciones(codigoEleccion);
	}

	@Override
	public List<EleccionesUt> listaEleccionesXUt(int pagina, int registros, int codigoEleccion, int codigoUt) {
		
		return procesosDao.listaEleccionesXUt(pagina, registros, codigoEleccion, codigoUt);
	}

	@Override
	public int cantidadRegistrosEleccionesUt(int codigoEleccion, int codigoUt) {
		
		return procesosDao.cantidadRegistrosEleccionesUt(codigoEleccion, codigoUt);
	}

	@Override
	public ReporteProcesamiento reporteProcesamiento(int pagina, int registros) {
		
		return procesosDao.reporteProcesamiento(pagina, registros);
	}

	@Override
	public Retorno procesarCuotaAdministrativa(Procesamiento procesamiento) {
		
		return procesosDao.procesarCuotaAdministrativa(procesamiento);
	}

	@Override
	public Retorno procesarVigilancia(Procesamiento procesamiento) {
		
		return procesosDao.procesarVigilancia(procesamiento);
	}

	@Override
	public Retorno grabarProceso(String periodo, String fechaVencimiento) {
		
		return procesosDao.grabarProceso(periodo, fechaVencimiento);
	}

	@Override
	public Retorno eliminarProcesamiento(Procesamiento procesamiento) {

		return procesosDao.eliminarProcesamiento(procesamiento);
	}

}
