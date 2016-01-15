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
import pe.com.sigamm.bean.ReporteReciboLuzSocio;
import pe.com.sigamm.dao.ReciboAguaSocioDao;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.ReciboLuzSocio;
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
	public ReporteReciboAguaSocio reporteReciboAguaSocio(int pagina, int registros, int codigoRecibo) {

		ReporteReciboAguaSocio reporte = new ReporteReciboAguaSocio();
		try{
			System.out.println("Listando Recibo Agua Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_AGUA_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_PUESTO_AGUA_SOCIO").declareParameters(
				new SqlParameter("vi_pagina",		 			Types.INTEGER),
				new SqlParameter("vi_registros", 				Types.INTEGER),
				new SqlParameter("vi_codigo_recibo", 			Types.INTEGER),
				
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboAguaSocio.class)));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 					pagina);
			parametros.addValue("vi_registros", 				registros);
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
				new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(ReciboLuzSocio.class)));
				
            
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

}
