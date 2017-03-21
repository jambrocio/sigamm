package pe.com.sigamm.bus;

import java.util.List;

import pe.com.sigamm.bean.ReporteProcesamiento;
import pe.com.sigamm.modelo.EleccionesResumen;
import pe.com.sigamm.modelo.EleccionesUt;
import pe.com.sigamm.modelo.Procesamiento;
import pe.com.sigamm.modelo.RegistrosApp;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Usuario;

public interface ProcesosBus {

	public List<RegistrosApp> listaRegistros(int pagina, int registros, int todos);

	public int cantidadRegistros();
	
	public List<Usuario> listaResultadoElecciones(int codigoEleccion);
	
	public List<EleccionesResumen> listaResumenElecciones(int codigoEleccion);
	
	public List<EleccionesUt> listaEleccionesXUt(int pagina, int registros, int codigoEleccion, int codigoUt);
	
	public int cantidadRegistrosEleccionesUt(int codigoEleccion, int codigoUt);
	
	public ReporteProcesamiento reporteProcesamiento(int pagina, int registros);
	
	public Retorno procesarCuotaAdministrativa(Procesamiento procesamiento);
	
	public Retorno procesarVigilancia(Procesamiento procesamiento);
	
}
