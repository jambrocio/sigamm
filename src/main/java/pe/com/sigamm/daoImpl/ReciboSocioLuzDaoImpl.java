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

import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.dao.ReciboLuzSocioDao;
import pe.com.sigamm.modelo.ReciboLuzSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ReciboSocioLuzDaoImpl implements ReciboLuzSocioDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;

	@Autowired
	private DatosSession datosSession;
	
	@Override
	public Retorno grabarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Grabando Recibo Luz Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			jdbcCall.withProcedureName("SP_GRABAR_LUZ_X_SOCIO").declareParameters(
					new SqlParameter("vi_idRecibo", 			Types.NUMERIC),
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_recibo", 		Types.NUMERIC),
					new SqlParameter("vi_correlativo", 			Types.NUMERIC),
					new SqlParameter("vi_lectura_inicial", 		Types.NUMERIC),
					new SqlParameter("vi_lectura_final", 		Types.NUMERIC),
					new SqlParameter("vi_consumo_mes", 			Types.NUMERIC),
					new SqlParameter("vi_cargo_energia", 		Types.NUMERIC),
					new SqlParameter("vi_alumbrado_publico", 	Types.NUMERIC),
					new SqlParameter("vi_servicio_mantenimiento",Types.NUMERIC),
					new SqlParameter("vi_deuda_anterior", 		Types.NUMERIC),
					new SqlParameter("vi_reconexion", 			Types.NUMERIC),
					new SqlParameter("vi_total", 				Types.NUMERIC),
					new SqlParameter("vi_estado", 				Types.NUMERIC),
					new SqlParameter("vi_trabado", 				Types.NUMERIC),
					new SqlParameter("vi_usuario_carga", 		Types.VARCHAR),
					new SqlParameter("vi_fecha_carga", 			Types.DATE),					
					new SqlParameter("vi_usuario_modifica", 	Types.VARCHAR),	
					new SqlParameter("vi_fecha_modifica", 		Types.DATE),
					new SqlParameter("vi_codigo_servicio_detalle", Types.NUMERIC),
					new SqlParameter("vi_corte_luz", 			Types.NUMERIC),
					new SqlParameter("vi_suspendido", 			Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));	
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_idRecibo", 			reciboLuzSocio.getIdRecibo());
			parametros.addValue("vi_codigo_socio", 		reciboLuzSocio.getCodigoSocio());
			parametros.addValue("vi_codigo_recibo",		reciboLuzSocio.getCodigoRecibo());
			parametros.addValue("vi_correlativo",		reciboLuzSocio.getCorrelativo());
			parametros.addValue("vi_lectura_inicial", 	reciboLuzSocio.getLecturaInicial());
			parametros.addValue("vi_lectura_final", 	reciboLuzSocio.getLecturaFinal());
			parametros.addValue("vi_consumo_mes", 		reciboLuzSocio.getConsumoMes());
			parametros.addValue("vi_cargo_energia",		reciboLuzSocio.getCargoEnergia());
			parametros.addValue("vi_alumbrado_publico",	reciboLuzSocio.getAlumbradoPublico());
			parametros.addValue("vi_servicio_mantenimiento",reciboLuzSocio.getServicioMantenimiento());
			parametros.addValue("vi_deuda_anterior",	reciboLuzSocio.getDeudaAnterior());
			parametros.addValue("vi_reconexion",		reciboLuzSocio.getReconexion());
			parametros.addValue("vi_total",				reciboLuzSocio.getTotal());
			parametros.addValue("vi_estado",			reciboLuzSocio.getEstado());
			parametros.addValue("vi_trabado",			reciboLuzSocio.getTrabado());
			parametros.addValue("vi_usuario_carga",		datosSession.getCodigoUsuario());			
			parametros.addValue("vi_fecha_carga",		reciboLuzSocio.getFechaCarga());
			parametros.addValue("vi_usuario_modifica",	null);
			parametros.addValue("vi_fecha_modifica",	null);
			parametros.addValue("vi_codigo_servicio_detalle", null);
			parametros.addValue("vi_corte_luz", 		null);
			parametros.addValue("vi_suspendido", 		reciboLuzSocio.getSuspendido());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoSocio = (Integer) result.get("vo_codigo_socio");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoSocio);
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
	public ReporteReciboLuzSocio editarReciboLuzxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo) {
		
		ReporteReciboLuzSocio reporte = new ReporteReciboLuzSocio();
		try{
			System.out.println("Editando Recibo Luz Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			jdbcCall.withProcedureName("SP_EDITAR_LUZ_X_SOCIO").declareParameters(
				new SqlParameter("vi_pagina",		 			Types.INTEGER),
				new SqlParameter("vi_registros", 				Types.INTEGER),
				new SqlParameter("vi_puesto_socio", 			Types.VARCHAR),
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				/*new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR),*/
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboLuzSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 					pagina);
			parametros.addValue("vi_registros", 				registros);
			parametros.addValue("vi_puesto_socio", 				puestoSocio);
			parametros.addValue("vi_codigo_recibo", 			codigoRecibo);
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboLuzSocio> lista = (List<ReciboLuzSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboLuzSocio(lista);
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
	}

	@Override
	public ReporteReciboLuzSocio reporteReciboLuzSocio(
			Integer codigoReciboLuzSocio, String periodo) {

		ReporteReciboLuzSocio reporte = new ReporteReciboLuzSocio();
		try{
			System.out.println("Editando Recibo Luz Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_LUZ_SOCIO_P").declareParameters(
				new SqlParameter("vi_periodo", 			Types.VARCHAR),
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboLuzSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_periodo", 					periodo);
			parametros.addValue("vi_codigo_recibo", 				codigoReciboLuzSocio);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			List<ReciboLuzSocio> lista = (List<ReciboLuzSocio>) results.get("vo_result");
			
			reporte.setListaReciboLuzSocio(lista);
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
	}

	@Override
	public Retorno pagarReciboLuzxSocio(ReciboLuzSocio reciboLuzSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Pagando Recibo Luz Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			jdbcCall.withProcedureName("SP_PAGAR_LUZ_X_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_recibo", 		Types.NUMERIC),
					new SqlParameter("vi_correlativo", 			Types.NUMERIC),
					new SqlParameter("vi_numero_puesto", 		Types.VARCHAR),
					new SqlParameter("vi_usuario_carga", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_codigo_recibo",		reciboLuzSocio.getCodigoRecibo());
			parametros.addValue("vi_correlativo",		reciboLuzSocio.getCorrelativo());
			parametros.addValue("vi_numero_puesto", 	reciboLuzSocio.getPuestoSocio());
			parametros.addValue("vi_usuario_carga",		datosSession.getCodigoUsuario());
			parametros.addValue("vi_codigo_socio",		reciboLuzSocio.getCodigoSocio());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoSocio = (Integer) result.get("vo_codigo_socio");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoSocio);
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
