package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.dao.PuestoDao;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class PuestoDaoImpl implements PuestoDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public List<GiroComercial> listaGiroComercial() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PUESTO");
		jdbcCall.withProcedureName("SP_LISTAR_GIRO_COMERCIAL");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(GiroComercial.class)));
		
		Map<String,Object> results = jdbcCall.execute();
		List<GiroComercial> lista = (List<GiroComercial>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public Retorno grabarPuesto(Puesto puesto) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PUESTO");
			jdbcCall.withProcedureName("SP_GRABAR_PUESTO").declareParameters(
				new SqlParameter("vi_codigo_puesto", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				new SqlParameter("vi_codigo_giro", 				Types.INTEGER),
				new SqlParameter("vi_nro_puesto", 				Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario_registro", 	Types.INTEGER),
				
				new SqlOutParameter("vo_codigo_puesto", 		Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_puesto", 			puesto.getCodigoPuesto());
			parametros.addValue("vi_codigo_usuario", 			puesto.getCodigoUsuario());
			parametros.addValue("vi_codigo_giro", 				puesto.getCodigoGiro());
			parametros.addValue("vi_nro_puesto", 				puesto.getNroPuesto() != null ? puesto.getNroPuesto() : "");
			parametros.addValue("vi_codigo_usuario_registro", 	datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoPuesto = (Integer) result.get("vo_codigo_puesto");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoPuesto);
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
	public ReportePuesto reportePuesto(int pagina, int registros, String dni) {
		
		ReportePuesto reporte = new ReportePuesto();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PUESTO");
			
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_dni", 						Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Puesto.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_dni", 		dni);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Puesto> lista = (List<Puesto>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaPuesto(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}

	@Override
	public Retorno eliminarPuesto(Puesto puesto) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PUESTO");
			jdbcCall.withProcedureName("SP_ELIMINAR_PUESTO").declareParameters(
				new SqlParameter("vi_codigo_puesto", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_puesto", 			puesto.getCodigoPuesto());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
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
	public ReportePuesto reportePuestoLuz(int pagina, int registros, int codigoSocio, int codigoRecibo) {
		ReportePuesto reporte = new ReportePuesto();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_LUZ_SOCIO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_socio", 			Types.INTEGER),
					new SqlParameter("vi_codigo_luz_original", 		Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Puesto.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_socio",codigoSocio);
			parametros.addValue("vi_codigo_luz_original",codigoRecibo);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Puesto> lista = (List<Puesto>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaPuesto(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}


	@Override
	public ReportePuesto reportePuestoxPto(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal) {
		ReportePuesto reporte = new ReportePuesto();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_PUESTO");
			
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_X_PTO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_sector", 			Types.INTEGER),
					new SqlParameter("vi_nro_puesto", 				Types.VARCHAR),
					new SqlParameter("vi_codigo_luz_original", 		Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Puesto.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_puesto",codigoSector);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Puesto> lista = (List<Puesto>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaPuesto(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

}
