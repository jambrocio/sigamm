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

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteOperacionesBancarias;
import pe.com.sigamm.dao.EgresoDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Cuenta;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.OperacionesBancarias;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class EgresoDaoImpl implements EgresoDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal) {

		ReporteEgreso reporte = new ReporteEgreso();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_EGRESO");
			jdbcCall.withProcedureName("SP_REPORTAR_EGRESO_XLS").declareParameters(
					new SqlParameter("vi_fecha_inicio", 				Types.VARCHAR),
					new SqlParameter("vi_fecha_termino", 				Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Egreso.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_fecha_inicio", 		fechaInicial);
			parametros.addValue("vi_fecha_termino", 	fechaFinal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Egreso> lista = (List<Egreso>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaEgreso(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  reporte;
		
	}

	@Override
	public ReporteOperacionesBancarias reporteOperacionesBancarias(int pagina, int registros, String codigoOperacionesBancarias) {

		ReporteOperacionesBancarias reporte = new ReporteOperacionesBancarias();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_EGRESO");
			jdbcCall.withProcedureName("SP_REPORTE_OPEBAN").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_opeban", 	        Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(OperacionesBancarias.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_opeban", codigoOperacionesBancarias);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<OperacionesBancarias> lista = (List<OperacionesBancarias>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaOperacionesBancarias(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}

	@Override
	public List<Cuenta> opcionesCuentas(Cuenta cuenta) {
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_EGRESO");
		jdbcCall.withProcedureName("SP_LISTAR_CUENTAS").declareParameters(
				//new SqlParameter("vi_rubro", 	Types.VARCHAR),				
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Cuenta.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		//parametros.addValue("vi_rubro", "");
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Cuenta> lista = (List<Cuenta>) results.get("vo_result");
		return  lista;
	}

	@Override
	public Retorno grabarOperacionesBancarias(OperacionesBancarias operacionesBancarias) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_EGRESO");
			jdbcCall.withProcedureName("SP_GRABAR_OPEBAN").declareParameters(
			//jdbcCall.withProcedureName("SP_GRABAR_EGRESO").declareParameters(
					
				new SqlParameter("vi_codigo_opeban", 			Types.INTEGER),
				new SqlParameter("vi_tipo_operacion", 			Types.VARCHAR),
				new SqlParameter("vi_numero_cuenta", 			Types.VARCHAR),
				new SqlParameter("vi_monto",			 		Types.DOUBLE),
				new SqlParameter("vi_fecha", 					Types.VARCHAR),
				new SqlParameter("vi_hora", 					Types.VARCHAR),
				new SqlParameter("vi_responsable",	 			Types.VARCHAR),
				new SqlParameter("vi_observaciones", 			Types.VARCHAR),
				new SqlParameter("vi_voucher", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.NUMERIC),
				
				new SqlOutParameter("vo_codigo_opeban", 		Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_opeban", 			operacionesBancarias.getId());
			parametros.addValue("vi_tipo_operacion", 			operacionesBancarias.getOperacion());
			parametros.addValue("vi_numero_cuenta", 			operacionesBancarias.getNumeroCuenta());
			parametros.addValue("vi_monto", 					operacionesBancarias.getMonto());
			parametros.addValue("vi_fecha", 					operacionesBancarias.getFecha());
			parametros.addValue("vi_hora", 						operacionesBancarias.getHora());
			parametros.addValue("vi_responsable", 				operacionesBancarias.getResponsable() == null ? "" : operacionesBancarias.getResponsable());
			parametros.addValue("vi_observaciones", 			operacionesBancarias.getObservaciones() == null ? "" : operacionesBancarias.getObservaciones());
			parametros.addValue("vi_voucher", 					operacionesBancarias.getVoucher());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoOpeban = (Integer) result.get("vo_codigo_opeban");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoOpeban);
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
	public ReporteOperacionesBancarias reportarOperacionesBancarias(String fechaInicial, String fechaFinal) {

		ReporteOperacionesBancarias reporte = new ReporteOperacionesBancarias();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_EGRESO");
			jdbcCall.withProcedureName("SP_REPORTAR_OPEBAN_XLS").declareParameters(
					new SqlParameter("vi_fecha_inicio", 				Types.VARCHAR),
					new SqlParameter("vi_fecha_termino", 				Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(OperacionesBancarias.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_fecha_inicio", 		fechaInicial);
			parametros.addValue("vi_fecha_termino", 	fechaFinal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<OperacionesBancarias> lista = (List<OperacionesBancarias>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaOperacionesBancarias(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  reporte;
		
	}
	
	

}
