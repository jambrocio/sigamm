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

import pe.com.sigamm.bean.ReporteReciboAgua;
import pe.com.sigamm.dao.ReciboAguaDao;
import pe.com.sigamm.modelo.ReciboAgua;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ReciboAguaDaoImpl implements ReciboAguaDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public ReporteReciboAgua reporteReciboAgua(int pagina, int registros, int codigoRecibo) {
				
		ReporteReciboAgua reporte = new ReporteReciboAgua();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA");
			
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_AGUA").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_recibo", 	        Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAgua.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_recibo", codigoRecibo);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ReciboAgua> lista = (List<ReciboAgua>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboAgua(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}

	@Override
	public Retorno grabarReciboAgua(ReciboAgua reciboAgua) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA");
			jdbcCall.withProcedureName("SP_GRABAR_RECIBO_AGUA").declareParameters(
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlParameter("vi_lectura_inicial", 			Types.INTEGER),
				new SqlParameter("vi_lectura_final",			Types.INTEGER),
				new SqlParameter("vi_monto", 					Types.INTEGER),
				new SqlParameter("vi_periodo", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_codigo_recibo", 		Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_recibo", 			reciboAgua.getCodigoRecibo());
			parametros.addValue("vi_lectura_inicial", 			reciboAgua.getLecturaInicial());
			parametros.addValue("vi_lectura_final", 			reciboAgua.getLecturaFinal());
			parametros.addValue("vi_monto", 					reciboAgua.getMonto());
			parametros.addValue("vi_periodo", 					reciboAgua.getPeriodo());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoRecibo = (Integer) result.get("vo_codigo_recibo");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoRecibo);
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
