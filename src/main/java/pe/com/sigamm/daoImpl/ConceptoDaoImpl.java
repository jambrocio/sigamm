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

import pe.com.sigamm.bean.ReporteConcepto;
import pe.com.sigamm.dao.ConceptoDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ConceptoDaoImpl implements ConceptoDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	

	/*@Override
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
	}*/


	@Override
	public ReporteConcepto reporteConcepto(int pagina, int registros, int codigoConcepto) {
		ReporteConcepto reporte = new ReporteConcepto();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_CONCEPTO");
			jdbcCall.withProcedureName("SP_REPORTE_CONCEPTOS").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_concepto", 	        Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Concepto.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_concepto", codigoConcepto);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Concepto> lista = (List<Concepto>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaConcepto(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

	

}
