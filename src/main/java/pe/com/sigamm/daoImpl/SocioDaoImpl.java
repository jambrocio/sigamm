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

import pe.com.sigamm.bean.ReporteSocio;
import pe.com.sigamm.dao.SocioDao;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.Socio;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class SocioDaoImpl implements SocioDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public ReporteSocio reporteSocio(int pagina, int registros, String dni) {
		
		ReporteSocio reporte = new ReporteSocio();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_SOCIO");
			jdbcCall.withProcedureName("SP_REPORTE_SOCIO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_dni", 						Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Socio.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_dni", 		dni);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Socio> lista = (List<Socio>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaSocio(lista);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}

	@Override
	public Socio buscarSocio(Socio socio) {
		
		Socio reporte = new Socio();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_SOCIO");
			jdbcCall.withProcedureName("SP_BUSCAR_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_socio", 			Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Socio.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_socio", 	socio.getCodigoSocio());
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			List<Socio> lista = (List<Socio>) results.get("vo_result");
			
			reporte = lista.get(0);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

	@Override
	public Retorno grabarSocio(Socio socio) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_SOCIO");
			jdbcCall.withProcedureName("SP_GRABAR_SOCIO").declareParameters(
				new SqlParameter("vi_codigo_socio", 			Types.INTEGER),
				new SqlParameter("vi_dni", 						Types.VARCHAR),
				new SqlParameter("vi_apellido_paterno", 		Types.VARCHAR),
				new SqlParameter("vi_apellido_materno", 		Types.VARCHAR),
				new SqlParameter("vi_nombres", 					Types.VARCHAR),
				new SqlParameter("vi_fec_nac", 					Types.VARCHAR),
				new SqlParameter("vi_fec_ingreso", 				Types.VARCHAR),
				new SqlParameter("vi_correo", 					Types.VARCHAR),
				new SqlParameter("vi_telefono", 				Types.VARCHAR),
				new SqlParameter("vi_celular", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_giro", 				Types.INTEGER),
				new SqlParameter("vi_nro_puesto", 				Types.VARCHAR),
				new SqlParameter("vi_padron", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario_registro", 	Types.INTEGER),
				
				new SqlOutParameter("vo_codigo_socio", 			Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_socio", 				socio.getCodigoSocio());
			parametros.addValue("vi_dni", 						socio.getDni() != null ? socio.getDni() : "");
			parametros.addValue("vi_apellido_paterno", 			socio.getApellidoPaterno() != null ? socio.getApellidoPaterno() : "");
			parametros.addValue("vi_apellido_materno", 			socio.getApellidoMaterno() != null ? socio.getApellidoMaterno() : "");
			parametros.addValue("vi_nombres", 					socio.getNombres() != null ? socio.getNombres() : "");
			parametros.addValue("vi_fec_nac", 					socio.getFechaNacimiento() != null ? socio.getFechaNacimiento() : "");
			parametros.addValue("vi_fec_ingreso", 				socio.getFechaIngreso() != null ? socio.getFechaIngreso() : "");
			parametros.addValue("vi_correo", 					socio.getCorreo() != null ? socio.getCorreo() : "");
			parametros.addValue("vi_telefono", 					socio.getTelefono() != null ? socio.getTelefono() : "");
			parametros.addValue("vi_celular", 					socio.getCelular() != null ? socio.getCelular() : "");
			parametros.addValue("vi_codigo_giro", 				socio.getCodigoGiro());
			parametros.addValue("vi_nro_puesto", 				socio.getNroPuesto() != null ? socio.getNroPuesto() : "");
			parametros.addValue("vi_padron", 					socio.getPadron() != null ? socio.getPadron() : "");
			parametros.addValue("vi_codigo_usuario_registro", 	datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoPuesto = (Integer) result.get("vo_codigo_socio");
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

}
