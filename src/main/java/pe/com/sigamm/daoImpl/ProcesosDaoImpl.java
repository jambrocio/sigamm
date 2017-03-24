package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import oracle.jdbc.OracleTypes;
import pe.com.sigamm.bean.ReporteProcesamiento;
import pe.com.sigamm.dao.ProcesosDao;
import pe.com.sigamm.modelo.EleccionesResumen;
import pe.com.sigamm.modelo.EleccionesUt;
import pe.com.sigamm.modelo.Procesamiento;
import pe.com.sigamm.modelo.RegistrosApp;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Usuario;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ProcesosDaoImpl implements ProcesosDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public List<RegistrosApp> listaRegistros(int pagina, int registros, int todos){
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_REPORTE_REGISTROS");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(RegistrosApp.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_pagina", pagina);
		parametros.addValue("vi_registros", registros);
		parametros.addValue("vi_codigo_usuario", datosSession.getCodigoUsuario());
		parametros.addValue("vi_usuario", datosSession.getUsuario());
		parametros.addValue("vi_codigo_rol", datosSession.getCodigoRol());
		parametros.addValue("vi_codigo_ut", datosSession.getCodigoUt());
		parametros.addValue("vi_codigo_institucion", datosSession.getCodigoInstitucion());
		parametros.addValue("vi_todos", todos);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<RegistrosApp> lista = (List<RegistrosApp>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public int cantidadRegistros() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_CANTIDAD_REGISTROS").declareParameters(
				new SqlParameter("vi_codigo_usuario",		Types.INTEGER),
				new SqlParameter("vi_usuario",				Types.VARCHAR),
				new SqlParameter("vi_codigo_rol",			Types.INTEGER),
				new SqlParameter("vi_codigo_ut",			Types.INTEGER),
				new SqlParameter("vi_codigo_institucion",	Types.INTEGER),
				new SqlOutParameter("vo_cantidad", 			Types.INTEGER));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_usuario", datosSession.getCodigoUsuario());
		parametros.addValue("vi_usuario", datosSession.getUsuario());
		parametros.addValue("vi_codigo_rol", datosSession.getCodigoRol());
		parametros.addValue("vi_codigo_ut", datosSession.getCodigoUt());
		parametros.addValue("vi_codigo_institucion", datosSession.getCodigoInstitucion());
		
		Map<String,Object> result = jdbcCall.execute(parametros); 
		
		int cantidadRegistros = (Integer) result.get("vo_cantidad");
			
		return cantidadRegistros;
		
	}

	@Override
	public List<Usuario> listaResultadoElecciones(int codigoEleccion) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_RESULTADO_ELECCIONES");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Usuario.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", 	datosSession.getCodigoInstitucion());
		parametros.addValue("vi_codigo_eleccion", 		codigoEleccion);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Usuario> lista = (List<Usuario>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public List<EleccionesResumen> listaResumenElecciones(int codigoEleccion) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_RESUMEN_ELECCIONES");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(EleccionesResumen.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", 	datosSession.getCodigoInstitucion());
		parametros.addValue("vi_codigo_eleccion", 		codigoEleccion);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<EleccionesResumen> lista = (List<EleccionesResumen>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public List<EleccionesUt> listaEleccionesXUt(int pagina, int registros, int codigoEleccion, int codigoUt) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_LISTA_ELECCIONES_UT");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(EleccionesUt.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_pagina", pagina);
		parametros.addValue("vi_registros", registros);
		parametros.addValue("vi_codigo_institucion", 	datosSession.getCodigoInstitucion());
		parametros.addValue("vi_codigo_eleccion", 		codigoEleccion);
		parametros.addValue("vi_codigo_ut", 			codigoUt);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<EleccionesUt> lista = (List<EleccionesUt>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public int cantidadRegistrosEleccionesUt(int codigoEleccion, int codigoUt) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PROCESOS");
		jdbcCall.withProcedureName("SP_CANT_REG_ELECCIONES_UT").declareParameters(
				new SqlParameter("vi_codigo_institucion",	Types.INTEGER),
				new SqlParameter("vi_codigo_eleccion",		Types.INTEGER),
				new SqlParameter("vi_codigo_ut",			Types.INTEGER),
				new SqlOutParameter("vo_cantidad", 			Types.INTEGER));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", 	datosSession.getCodigoInstitucion());
		parametros.addValue("vi_codigo_eleccion", 		codigoEleccion);
		parametros.addValue("vi_codigo_ut", 			codigoUt);
		
		Map<String,Object> result = jdbcCall.execute(parametros); 
		
		int cantidadRegistros = (Integer) result.get("vo_cantidad");
			
		return cantidadRegistros;
		
	}

	@Override
	public ReporteProcesamiento reporteProcesamiento(int pagina, int registros) {
		
		ReporteProcesamiento reporte = new ReporteProcesamiento();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PROCESAMIENTO");
			jdbcCall.withProcedureName("SP_REPORTE_PROCESAMIENTO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Procesamiento.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 			pagina);
			parametros.addValue("vi_registros", 		registros);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Procesamiento> lista = (List<Procesamiento>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaProcesamiento(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  reporte;
		
	}

	@Override
	public Retorno procesarCuotaAdministrativa(Procesamiento procesamiento) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PROCESAMIENTO");
			jdbcCall.withProcedureName("SP_PROCESAR_CUOTA_ADM").declareParameters(
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_periodo", 			procesamiento.getPeriodo());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(0);
			retorno.setIndicador(indicador);
			retorno.setMensaje(mensaje);
			
		}catch(Exception e){
			
			retorno.setCodigo(0);
			retorno.setIndicador("");
			retorno.setMensaje("");
			LoggerCustom.errorApp(this, "", e);
		}
		
		return retorno;
	}

	@Override
	public Retorno procesarVigilancia(Procesamiento procesamiento) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PROCESAMIENTO");
			jdbcCall.withProcedureName("SP_PROCESAR_VIGILANCIA").declareParameters(
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_periodo", 			procesamiento.getPeriodo());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(0);
			retorno.setIndicador(indicador);
			retorno.setMensaje(mensaje);
			
		}catch(Exception e){
			
			retorno.setCodigo(0);
			retorno.setIndicador("");
			retorno.setMensaje("");
			LoggerCustom.errorApp(this, "", e);
		}
		
		return retorno;
	}

	@Override
	public Retorno grabarProceso(String periodo, String fechaVencimiento) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PROCESAMIENTO");
			jdbcCall.withProcedureName("SP_GRABAR_PROCESAMIENTO").declareParameters(
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				new SqlParameter("vi_fecha_vencimiento", 		Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_periodo", 			periodo != null ? periodo.toString().toUpperCase() : "");
			parametros.addValue("vi_fecha_vencimiento", fechaVencimiento != null ? fechaVencimiento.toString() : "");
			parametros.addValue("vi_codigo_usuario", 	datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(0);
			retorno.setIndicador(indicador);
			retorno.setMensaje(mensaje);
			
		}catch(Exception e){
			
			retorno.setCodigo(0);
			retorno.setIndicador("");
			retorno.setMensaje("");
			LoggerCustom.errorApp(this, "", e);
		}
		
		return retorno;
	}

}
