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

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.dao.ReciboAguaSocioDao;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ReciboSocioAguaDaoImpl implements ReciboAguaSocioDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;

	@Autowired
	private DatosSession datosSession;
	
	@Override
	public ReporteReciboAguaSocio reporteReciboAguaSocio(int pagina, int registros, String numeroPuesto, int codigoRecibo) {

		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Listando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_AGUA_SOCIO").declareParameters(
				new SqlParameter("vi_pagina",		 			Types.INTEGER),
				new SqlParameter("vi_registros", 				Types.INTEGER),
				new SqlParameter("vi_codigo_puesto", 			Types.VARCHAR),
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 					pagina);
			parametros.addValue("vi_registros", 				registros);
			parametros.addValue("vi_codigo_puesto",				numeroPuesto);
			parametros.addValue("vi_codigo_recibo", 			codigoRecibo);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAguaSocio((lista));
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
		
	}

	@Override
	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina, int registros, String puestoSocio, int codigoRecibo) {
		// TODO Auto-generated method stub
		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Editando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_EDITAR_AGUA_X_SOCIO").declareParameters(
				new SqlParameter("vi_pagina",		 			Types.INTEGER),
				new SqlParameter("vi_registros", 				Types.INTEGER),
				new SqlParameter("vi_puesto_socio", 			Types.VARCHAR),
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				/*new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR),*/
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 					pagina);
			parametros.addValue("vi_registros", 				registros);
			parametros.addValue("vi_puesto_socio", 				puestoSocio);
			parametros.addValue("vi_codigo_recibo", 			codigoRecibo);
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAguaSocio(lista);
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;

	}

	@Override
	public ReporteReciboAguaSocio reportePuestoxAgua(int pagina, int registros, int codigoSector, String nroPuesto, int codigoReciboOriginal) {

		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");		
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_X_AGUASOCIO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_sector", 			Types.INTEGER),
					new SqlParameter("vi_nro_puesto", 				Types.VARCHAR),
					new SqlParameter("vi_codigo_agua_original", 	Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	          pagina);
			parametros.addValue("vi_registros",           registros);
			parametros.addValue("vi_codigo_sector",       codigoSector);
			parametros.addValue("vi_nro_puesto",          nroPuesto);
			parametros.addValue("vi_codigo_agua_original", codigoReciboOriginal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAguaSocio(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

	@Override
	public Retorno grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Grabando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_GRABAR_AGUA_X_SOCIO").declareParameters(
					new SqlParameter("vi_idRecibo", 			Types.NUMERIC),
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_recibo", 		Types.NUMERIC),
					new SqlParameter("vi_correlativo", 			Types.NUMERIC),
					new SqlParameter("vi_lectura_inicial", 		Types.NUMERIC),
					new SqlParameter("vi_lectura_final", 		Types.NUMERIC),
					new SqlParameter("vi_consumo_mes", 			Types.NUMERIC),
					new SqlParameter("vi_servicio_mantenimiento",Types.NUMERIC),
					new SqlParameter("vi_deuda_anterior", 		Types.NUMERIC),
					new SqlParameter("vi_reconexion", 			Types.NUMERIC),
					new SqlParameter("vi_alcantarillado",		Types.NUMERIC),
					new SqlParameter("vi_total", 				Types.NUMERIC),
					new SqlParameter("vi_estado", 				Types.NUMERIC),
					new SqlParameter("vi_trabado", 				Types.NUMERIC),					
					new SqlParameter("vi_usuario_carga", 		Types.VARCHAR),
					new SqlParameter("vi_fecha_carga", 			Types.DATE),					
					new SqlParameter("vi_usuario_modifica", 	Types.VARCHAR),	
					new SqlParameter("vi_fecha_modifica", 		Types.DATE),
					new SqlParameter("vi_codigo_servicio_detalle", Types.NUMERIC),
					new SqlParameter("vi_corte_agua", 			Types.NUMERIC),
					new SqlParameter("vi_suspendido", 			Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));	
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_idRecibo", 			reciboAguaSocio.getIdRecibo());
			parametros.addValue("vi_codigo_socio", 		reciboAguaSocio.getCodigoSocio());
			parametros.addValue("vi_codigo_recibo",		reciboAguaSocio.getCodigoReciboAgua());
			parametros.addValue("vi_correlativo",		reciboAguaSocio.getCorrelativo());
			parametros.addValue("vi_lectura_inicial", 	reciboAguaSocio.getLecturaInicial());
			parametros.addValue("vi_lectura_final", 	reciboAguaSocio.getLecturaFinal());
			parametros.addValue("vi_consumo_mes", 		reciboAguaSocio.getConsumoMes());
			parametros.addValue("vi_servicio_mantenimiento",reciboAguaSocio.getServicioMantenimiento());
			parametros.addValue("vi_deuda_anterior",	reciboAguaSocio.getDeudaAnterior());
			parametros.addValue("vi_reconexion",		reciboAguaSocio.getReconexion());
			parametros.addValue("vi_alcantarillado",	reciboAguaSocio.getAlcantarillado());
			parametros.addValue("vi_total",				reciboAguaSocio.getTotal());
			parametros.addValue("vi_estado",			reciboAguaSocio.getEstado());
			parametros.addValue("vi_trabado",			reciboAguaSocio.getTrabado());
			parametros.addValue("vi_usuario_carga",		datosSession.getCodigoUsuario());			
			parametros.addValue("vi_fecha_carga",		null);
			parametros.addValue("vi_usuario_modifica",	null);
			parametros.addValue("vi_fecha_modifica",	null);
			parametros.addValue("vi_codigo_servicio_detalle", reciboAguaSocio.getCodigoServicioDetalle());
			parametros.addValue("vi_corte_agua", 		reciboAguaSocio.getCorteAgua());
			parametros.addValue("vi_suspendido", 		reciboAguaSocio.getSuspendido());
			
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
	public ReporteReciboAguaSocio buscarReciboAguaSocio(int codigoReciboAguaSocio) {
		
		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Listando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_PTO_AGUA_SOCIO_PDF").declareParameters(
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_recibo", 			codigoReciboAguaSocio);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAguaSocio((lista));
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
		
	}
	
	@Override
	public Retorno pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Pagando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_PAGAR_AGUA_X_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_recibo", 		Types.NUMERIC),
					new SqlParameter("vi_correlativo", 			Types.NUMERIC),
					new SqlParameter("vi_numero_puesto", 		Types.VARCHAR),
					new SqlParameter("vi_usuario_carga", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_codigo_recibo",		reciboAguaSocio.getCodigoReciboAgua());
			parametros.addValue("vi_correlativo",		reciboAguaSocio.getCorrelativo());
			parametros.addValue("vi_numero_puesto", 	reciboAguaSocio.getNroPuesto());
			parametros.addValue("vi_usuario_carga",		datosSession.getCodigoUsuario());
			parametros.addValue("vi_codigo_socio",		reciboAguaSocio.getCodigoSocio());
			
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
	public ReporteReciboAguaSocio reporteAguaSocioExcel(int pagina, int registros, int exportar, int codigoAguaOriginal) {

		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_AGUA_SOCIO_EXCEL").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_exportar", 				Types.INTEGER),
					new SqlParameter("vi_codigo_agua_original", 	Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 		pagina);
			parametros.addValue("vi_registros", 	registros);
			parametros.addValue("vi_exportar", 		exportar);
			parametros.addValue("vi_codigo_agua_original",codigoAguaOriginal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAguaSocio(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  reporte;
		
	}

	@Override
	public ReporteReciboAguaSocio reporteReciboAguaSocio(Integer codigoRecibo, String periodo) {
		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Listando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_AGUA_SOCIO_P").declareParameters(
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_recibo", 			codigoRecibo);
			parametros.addValue("vi_periodo", 					periodo);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setListaReciboAguaSocio((lista));
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
	}
	
	
	@Override
	public Retorno eliminarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Eliminando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_ELIMINAR_AGUA_X_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_recibo",		Types.NUMERIC),
					new SqlParameter("vi_codigo_usuario", 		Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_codigo_socio",		reciboAguaSocio.getCodigoSocio());
			parametros.addValue("vi_codigo_recibo",		reciboAguaSocio.getCodigoReciboAgua());
			parametros.addValue("vi_codigo_usuario", 	datosSession.getCodigoUsuario());			
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
	public ReporteReciboAguaSocio generacionPdfVigilancia(String periodo) {
		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Listando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GENERACION_PDF_VIGILANCIA").declareParameters(
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_periodo", 					periodo);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			List<ReciboAguaSocio> lista = (List<ReciboAguaSocio>) results.get("vo_result");
			
			reporte.setListaReciboAguaSocio((lista));
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return reporte;
	}
}
