package pe.com.sigamm.daoImpl;

import java.io.Console;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import pe.com.sigamm.bean.ReporteReciboLuzOriginal;
import pe.com.sigamm.dao.ReciboLuzOriginalDao;
import pe.com.sigamm.modelo.LuzOriginal;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ReciboLuzOriginalDaoImpl implements ReciboLuzOriginalDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public Retorno grabarReciboLuzOriginal(LuzOriginal luzoriginal) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Grabando Recibo Luz Original");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			jdbcCall.withProcedureName("SP_INS_RECIBOORILUZ").declareParameters(
					new SqlParameter("p_ALUMBRADOPUBLICO",		Types.NUMERIC),
					new SqlParameter("p_CABLEADOPRINCIPAL",		Types.NUMERIC),
					new SqlParameter("p_CODIGO_RECIBO_ORIG", 	Types.NUMERIC),
					new SqlParameter("p_NUM_COSTO_WATS",		Types.NUMERIC),
					new SqlParameter("p_DEUDAANTERIOR",			Types.NUMERIC),
					new SqlParameter("p_FECEMISION",			Types.VARCHAR),
					new SqlParameter("p_FECVENCIMIENTO",		Types.VARCHAR),
					new SqlParameter("p_MANTENIMIENTO",			Types.NUMERIC),
					new SqlParameter("p_FEC_PERIODO", 			Types.VARCHAR),
					new SqlParameter("p_TOTALMESACT",			Types.NUMERIC),
					new SqlOutParameter("vo_codigo_recibo", 		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));	
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("p_ALUMBRADOPUBLICO",			luzoriginal.getAlumbradoPublico());
			parametros.addValue("p_CABLEADOPRINCIPAL",			luzoriginal.getCableadoPrincipal());			
			parametros.addValue("p_CODIGO_RECIBO_ORIG",			luzoriginal.getCodigoReciboLuzOriginal());
			parametros.addValue("p_NUM_COSTO_WATS",				luzoriginal.getCostoWats());			
			parametros.addValue("p_DEUDAANTERIOR",				luzoriginal.getDeudaAnterior());			
			parametros.addValue("p_FECEMISION",					luzoriginal.getFecEmision());			
			parametros.addValue("p_FECVENCIMIENTO",				luzoriginal.getFecVencimiento());
			parametros.addValue("p_MANTENIMIENTO",				luzoriginal.getMantenimiento());			
			parametros.addValue("p_FEC_PERIODO", 				luzoriginal.getPeriodo());
			parametros.addValue("p_TOTALMESACT",				luzoriginal.getTotalMesAct());
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoRecibo = (Integer) result.get("vo_codigo_recibo");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoRecibo);
			retorno.setIndicador(indicador);
			retorno.setMensaje(mensaje);
			
		}catch(Exception e){
			e.printStackTrace();
			retorno.setCodigo(0);
			retorno.setIndicador("");
			retorno.setMensaje("");
			LoggerCustom.errorApp(this, "", e);
		}
		
		return retorno;
	}

	@Override
	public ReporteReciboLuzOriginal reporteReciboLuzOriginal(int pagina,int registros, String codigoReciboLuzOriginal) {

		ReporteReciboLuzOriginal reporte = new ReporteReciboLuzOriginal();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			
			jdbcCall.withProcedureName("SP_REPORTE_LUZ_ORIG").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_recibo_luz_orig", 	Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(LuzOriginal.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_recibo_luz_orig", codigoReciboLuzOriginal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<LuzOriginal> lista = (List<LuzOriginal>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboLuzOriginal(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;

	}

	@Override
	public Retorno cerrarReciboLuzOriginal(LuzOriginal reciboLuzOriginal) {
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			
			jdbcCall.withProcedureName("SP_REPORTE_CERRAR_LUZ_ORIG").declareParameters(
					new SqlParameter("vi_codigo_recibo_luz_orig", 	Types.VARCHAR),
					
					new SqlOutParameter("vo_codigo_recibo", 		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_recibo_luz_orig",		reciboLuzOriginal.getCodigoReciboLuzOriginal());
			
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

	@Override
	public Retorno eliminarReciboLuz(LuzOriginal reciboLuzOriginal) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			jdbcCall.withProcedureName("SP_ELIMINAR_RECIBO_LUZ").declareParameters(
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_recibo", 			reciboLuzOriginal.getCodigoReciboLuzOriginal());
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

}
