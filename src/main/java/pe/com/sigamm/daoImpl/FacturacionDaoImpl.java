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

import pe.com.sigamm.bean.ServiciosDetalle;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class FacturacionDaoImpl implements FacturacionDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public Retorno grabarFacturacionCabecera(FacturacionCabecera facturacion) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_FACTURACION_CABECERA").declareParameters(
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				new SqlParameter("vi_serie", 					Types.VARCHAR),
				new SqlParameter("vi_secuencia", 				Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario_registro", 	Types.INTEGER),
				
				new SqlOutParameter("vo_facturacion_cabecera", 	Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_usuario", 			facturacion.getCodigoUsuario());
			parametros.addValue("vi_serie", 					facturacion.getSerie());
			parametros.addValue("vi_secuencia", 				facturacion.getSecuencia());
			parametros.addValue("vi_codigo_usuario_registro", 	datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoPuesto = (Integer) result.get("vo_facturacion_cabecera");
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
	public Retorno grabarFacturacionDetalle(FacturacionDetalle facturacion, int codigoFacturacion) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_FACTURACION_DETALLE").declareParameters(
				new SqlParameter("vi_facturacion_cabecera", 	Types.INTEGER),
				new SqlParameter("vi_codigo_puesto", 			Types.INTEGER),
				new SqlParameter("vi_codigo_concepto", 			Types.INTEGER),
				new SqlParameter("vi_monto", 					Types.INTEGER),
				
				new SqlOutParameter("vo_facturacion_detalle", 	Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_facturacion_cabecera", 		codigoFacturacion);
			parametros.addValue("vi_codigo_puesto", 			facturacion.getCodigoPuesto());
			parametros.addValue("vi_codigo_concepto", 			facturacion.getCodigoConcepto());
			parametros.addValue("vi_monto", 					facturacion.getMonto());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoPuesto = (Integer) result.get("vo_facturacion_detalle");
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
	public List<Concepto> opcionesConceptos(Concepto concepto) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_LISTAR_CONCEPTO").declareParameters(
				new SqlParameter("vi_rubro", 	Types.VARCHAR),				
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Concepto.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_rubro", concepto.getRubro());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Concepto> lista = (List<Concepto>) results.get("vo_result");
		return  lista;
		
	}

	
	@Override
	public List<Empresa> razonSocialEmpresa(Empresa empresa) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_LISTAR_EMPRESA").declareParameters(
				new SqlParameter("vi_ruc", 	Types.VARCHAR),				
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Empresa.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_ruc", empresa.getRuc());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Empresa> lista = (List<Empresa>) results.get("vo_result");
		return  lista;
		
	}
	
	
	@Override
	public Retorno grabarEmpresa(Empresa empresa) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_EMPRESA").declareParameters(
				new SqlParameter("vi_codigo_empresa", 			Types.INTEGER),
				new SqlParameter("vi_ruc", 						Types.VARCHAR),
				new SqlParameter("vi_razon_social", 			Types.VARCHAR),
				new SqlParameter("vi_condicion", 				Types.VARCHAR),
				new SqlParameter("vi_estado", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_codigo_empresa", 		Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_empresa", 			empresa.getCodigo_empresa());
			parametros.addValue("vi_ruc", 						empresa.getRuc());
			parametros.addValue("vi_razon_social", 				empresa.getRazonSocial());
			parametros.addValue("vi_condicion", 				empresa.getCondicion());
			parametros.addValue("vi_estado", 					empresa.getEstado());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoEmpresa = (Integer) result.get("vo_codigo_empresa");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoEmpresa);
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




