package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.ArrayList;
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

import pe.com.sigamm.bean.ListaServiciosOtros;
import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.bean.ReporteFacturacion;
import pe.com.sigamm.bean.ReporteFacturacionDetalle;
import pe.com.sigamm.bean.ReporteServiciosOtros;
import pe.com.sigamm.bean.VistaFacturacion;
import pe.com.sigamm.bean.VistaFacturacionDetalle;
import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.Banio;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.DeudaSocio;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.modelo.Empresa;
import pe.com.sigamm.modelo.Facturacion;
import pe.com.sigamm.modelo.FacturacionCabecera;
import pe.com.sigamm.modelo.FacturacionDetalle;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.modelo.ServicioOtrosCabecera;
import pe.com.sigamm.modelo.ServicioOtrosDetalle;
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
				new SqlParameter("vi_codigo_socio",				Types.INTEGER),
				
				new SqlOutParameter("vo_facturacion_cabecera", 	Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_usuario", 			facturacion.getCodigoUsuario());
			parametros.addValue("vi_serie", 					facturacion.getSerie());
			parametros.addValue("vi_secuencia", 				facturacion.getSecuencia());
			parametros.addValue("vi_codigo_usuario_registro", 	datosSession.getCodigoUsuario());
			parametros.addValue("vi_codigo_socio",				facturacion.getCodigoSocio());
			
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
				new SqlParameter("vi_codigo_deuda_socio", 		Types.INTEGER),
				new SqlParameter("vi_monto", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_servicio", 			Types.INTEGER),
				
				new SqlOutParameter("vo_facturacion_detalle", 	Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_facturacion_cabecera", 		codigoFacturacion);
			parametros.addValue("vi_codigo_deuda_socio", 		facturacion.getCodigoDeudaSocio());
			parametros.addValue("vi_monto", 					facturacion.getMonto());
			parametros.addValue("vi_codigo_servicio", 			facturacion.getCodigoServicio());
			
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
				new SqlParameter("vi_codigo_empresa", 	Types.INTEGER),
				new SqlParameter("vi_ruc", 	Types.VARCHAR),
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Empresa.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_empresa", empresa.getCodigoEmpresa());
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
			parametros.addValue("vi_codigo_empresa", 			empresa.getCodigoEmpresa());
			parametros.addValue("vi_ruc", 						empresa.getRuc() == null ? empresa.getRucNuevo() : empresa.getRuc());
			parametros.addValue("vi_razon_social", 				empresa.getRazonSocial() == null ? empresa.getRazonSocialNueva() : empresa.getRazonSocial());
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

	@Override
	public Retorno grabarEgreso(Egreso egreso) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_EGRESO").declareParameters(
				new SqlParameter("vi_codigo_egreso", 			Types.INTEGER),
				new SqlParameter("vi_tipo_documento", 			Types.NUMERIC),
				new SqlParameter("vi_numero_documento", 		Types.VARCHAR),
				new SqlParameter("vi_fecha", 					Types.VARCHAR),
				new SqlParameter("vi_codigo_empresa", 			Types.INTEGER),
				new SqlParameter("vi_detalle", 					Types.VARCHAR),
				new SqlParameter("vi_tipo_categoria",			Types.NUMERIC),
				new SqlParameter("vi_total", 					Types.DOUBLE),
				new SqlParameter("vi_representante", 			Types.VARCHAR),
				new SqlParameter("vi_cobrado", 					Types.VARCHAR),
				new SqlParameter("vi_dni",			 			Types.VARCHAR),
				new SqlParameter("vi_area",			 			Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_codigo_egreso", 		Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_egreso", 			egreso.getCodigoEgreso());
			parametros.addValue("vi_tipo_documento", 			egreso.getTipoDocumento());
			parametros.addValue("vi_numero_documento", 			egreso.getNumeroDocumento());
			parametros.addValue("vi_fecha", 					egreso.getFecha());
			parametros.addValue("vi_codigo_empresa", 			egreso.getCodigoEmpresa());
			parametros.addValue("vi_detalle", 					egreso.getDetalle());
			parametros.addValue("vi_tipo_categoria", 			egreso.getTipoCategoria());
			parametros.addValue("vi_total", 					egreso.getTotal());
			parametros.addValue("vi_representante", 			egreso.getRepresentante() == null ? "" : egreso.getRepresentante());
			parametros.addValue("vi_cobrado", 					egreso.getCobrado() == null ? "" : egreso.getCobrado());
			parametros.addValue("vi_dni", 						egreso.getDni() == null ? "" : egreso.getDni());
			parametros.addValue("vi_area", 						egreso.getArea() == null ? "" : egreso.getArea());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoEgreso = (Integer) result.get("vo_codigo_egreso");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoEgreso);
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
	public ReporteEgreso reporteEgreso(int pagina, int registros, String codigoEgreso) {

		ReporteEgreso reporte = new ReporteEgreso();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_EGRESO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_egreso", 	        Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Egreso.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_egreso", codigoEgreso);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<Egreso> lista = (List<Egreso>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaEgreso(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

	@Override
	public Retorno eliminarEgreso(Egreso egreso) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_ELIMINAR_EGRESO").declareParameters(
				new SqlParameter("vi_codigo_egreso", 			Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_egreso", 			egreso.getCodigoEgreso());
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
	public ReporteEgreso reporteEgresoExcel(int pagina, int registros, int exportar) {

		ReporteEgreso reporte = new ReporteEgreso();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_EGRESO_EXCEL").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_exportar", 				Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Egreso.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 		pagina);
			parametros.addValue("vi_registros", 	registros);
			parametros.addValue("vi_exportar", 		exportar);
			
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
	public List<DeudaSocio> listarDeudasSocio(DeudaSocio deuda) {
		
		List<DeudaSocio> lista = new ArrayList<DeudaSocio>();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_DEUDA_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_socio", 			Types.INTEGER),
					new SqlParameter("vi_codigo_servicio_detalle", 	Types.INTEGER),
					
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(DeudaSocio.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_socio", 				deuda.getCodigoSocio());
			parametros.addValue("vi_codigo_servicio_detalle", 	deuda.getCodigoServicioDetalle());
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			lista = (List<DeudaSocio>) results.get("vo_result");
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return lista;
		
	}

	@Override
	public Facturacion buscarFacturacion(int codigoFacturacion) {
		
		Facturacion facturacion = new Facturacion();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_FACTURACION").declareParameters(
					new SqlParameter("vi_codigo_facturacion", 		Types.INTEGER),
										
					new SqlOutParameter("vo_codigo_usuario", 		Types.INTEGER),
					new SqlOutParameter("vo_serie", 				Types.VARCHAR),
					new SqlOutParameter("vo_secuencia", 			Types.VARCHAR),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(FacturacionDetalle.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_facturacion", 		codigoFacturacion);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int codigoUsuario = (Integer) results.get("vo_codigo_usuario");
			String serie = (String) results.get("vo_serie");
			String secuencia = (String) results.get("vo_secuencia");
			List<FacturacionDetalle> lista = (List<FacturacionDetalle>) results.get("vo_result");
			
			FacturacionCabecera cabecera = new FacturacionCabecera();
			cabecera.setCodigoUsuario(codigoUsuario);
			cabecera.setSerie(serie);
			cabecera.setSecuencia(secuencia);
			
			facturacion.setCabecera(cabecera);
			facturacion.setDetalle(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  facturacion;
		
	}

	
	@Override
	public Retorno anularEgreso(Egreso egreso) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_ANULAR_EGRESO").declareParameters(
				new SqlParameter("vi_codigo_egreso", 			Types.INTEGER),
				new SqlParameter("vi_motivo_anulacion", 		Types.VARCHAR),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_egreso", 			egreso.getCodigoEgreso());
			parametros.addValue("vi_motivo_anulacion", 			egreso.getObservaciones());
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
	public ReporteFacturacion reporteFacturacion(int pagina, int registros, String dni, String nombre, int exportar) {
		
		ReporteFacturacion reporte = new ReporteFacturacion();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_FACTURACION_DIARIO").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_dni", 						Types.VARCHAR),
					new SqlParameter("vi_nombre",					Types.VARCHAR),
					new SqlParameter("vi_exportar", 				Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(VistaFacturacion.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 		pagina);
			parametros.addValue("vi_registros", 	registros);
			parametros.addValue("vi_dni", 			dni);
			parametros.addValue("vi_nombre", 		nombre);
			parametros.addValue("vi_exportar", 		exportar);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<VistaFacturacion> lista = (List<VistaFacturacion>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaFacturacion(lista);
			
		}catch(Exception e){
			LoggerCustom.errorApp(this, "", e);
		}
		
		return  reporte;
		
	}

	@Override
	public String montoTotalDiario() {
		
		String importe = "0";
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_MONTO_TOTAL_DIARIO").declareParameters(
				new SqlOutParameter("vo_monto_total", 	Types.VARCHAR));
			
			Map<String,Object> result = jdbcCall.execute(); 
			
			importe = (String) result.get("vo_monto_total");
			
			
		}catch(Exception e){
			
			LoggerCustom.errorApp(this, "", e);
		}
		
		return importe;
	}

	@Override
	public List<Banio> listarBanios() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_LISTAR_BANIOS").declareParameters(
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Banio.class)));
		
		Map<String,Object> results = jdbcCall.execute();
		List<Banio> lista = (List<Banio>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public Retorno grabarServicioOtrosCabecera(ServicioOtrosCabecera servicio) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_SERVICIO_OTROS").declareParameters(
				new SqlParameter("vi_codigo_servicio_otros", 	Types.INTEGER),
				new SqlParameter("vi_codigo_usuario", 			Types.INTEGER),
				new SqlParameter("vi_codigo_servicio", 			Types.INTEGER),
				new SqlParameter("vi_codigo_socio", 			Types.INTEGER),
				new SqlParameter("vi_dni_responsable", 			Types.VARCHAR),
				new SqlParameter("vi_nombre_responsable",		Types.VARCHAR),
				new SqlParameter("vi_importe_sobrante", 		Types.VARCHAR),
				new SqlParameter("vi_observacion", 				Types.VARCHAR),
				new SqlParameter("vi_fecha", 					Types.VARCHAR),
				
				new SqlOutParameter("vo_codigo",				Types.INTEGER),
				new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));
				
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_servicio_otros", 	servicio.getCodigoServicioOtros());
			parametros.addValue("vi_codigo_usuario", 			datosSession.getCodigoUsuario());
			parametros.addValue("vi_codigo_servicio", 			servicio.getCodigoServicio());
			parametros.addValue("vi_codigo_socio", 				servicio.getCodigoSocio());
			parametros.addValue("vi_dni_responsable", 			servicio.getDniResponsable());
			parametros.addValue("vi_nombre_responsable",		servicio.getNombreResponsable());
			parametros.addValue("vi_importe_sobrante",			servicio.getImporteSobrante());
			parametros.addValue("vi_observacion",				servicio.getObservacion());
			parametros.addValue("vi_fecha",						servicio.getFecha());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoServicioOtros = (Integer) result.get("vo_codigo");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoServicioOtros);
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
	public Retorno grabarServicioOtrosDetalle(ServicioOtrosDetalle servicio, int codigoServicio) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_GRABAR_SERVICIO_OTROS_DETA").declareParameters(
				new SqlParameter("vi_codigo_servicio_otros", 		Types.INTEGER),
				new SqlParameter("vi_codigo_servicio_detalle", 		Types.INTEGER),
				new SqlParameter("vi_codigo_banio", 				Types.INTEGER),
				new SqlParameter("vi_rango_inicio", 				Types.INTEGER),
				new SqlParameter("vi_rango_fin",					Types.INTEGER),
				
				new SqlOutParameter("vo_codigo",					Types.INTEGER),
				new SqlOutParameter("vo_indicador", 				Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 					Types.VARCHAR));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_servicio_otros", 	codigoServicio);
			parametros.addValue("vi_codigo_servicio_detalle", 	servicio.getCodigoServicioDetalle());
			parametros.addValue("vi_codigo_banio", 				servicio.getCodigoBanio());
			parametros.addValue("vi_rango_inicio", 				servicio.getRangoInicio());
			parametros.addValue("vi_rango_fin",					servicio.getRangoFin());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoServicioOtros = (Integer) result.get("vo_codigo");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoServicioOtros);
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
	public ReporteServiciosOtros listarServiciosOtros(int pagina, int registros, int codigoServicio) {
		
		ReporteServiciosOtros reporte = new ReporteServiciosOtros();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_OTROS_SERVICIOS").declareParameters(
					new SqlParameter("vi_pagina", 				Types.INTEGER),
					new SqlParameter("vi_registros", 			Types.INTEGER),
					new SqlParameter("vi_codigo_servicio", 		Types.INTEGER),
					
					new SqlOutParameter("vo_total_registros",	Types.INTEGER),
					new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(ListaServiciosOtros.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 			pagina);
			parametros.addValue("vi_registros", 		registros);
			parametros.addValue("vi_codigo_servicio", 	codigoServicio);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ListaServiciosOtros> lista = (List<ListaServiciosOtros>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaServiciosOtros(lista);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

	@Override
	public ReporteServiciosOtros listarServiciosOtrosDetalle(int codigoServicioOtros) {
		
		ReporteServiciosOtros reporte = new ReporteServiciosOtros();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_LISTAR_OTROS_SERV_DET").declareParameters(
					new SqlParameter("vi_codigo_servicio_otros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(ListaServiciosOtros.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_servicio_otros", 	codigoServicioOtros);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			//int totalRegistros = (Integer) results.get("vo_total_registros");
			List<ListaServiciosOtros> lista = (List<ListaServiciosOtros>) results.get("vo_result");
			
			reporte.setTotalRegistros(1);
			reporte.setListaServiciosOtros(lista);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
		
	}

	@Override
	public ServicioOtrosCabecera ServiciosOtrosCabecera(int codigoServicioOtros) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_BUSCAR_OTROS_SERVICIOS_CAB");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(ServicioOtrosCabecera.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_servicio_otros", codigoServicioOtros);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<ServicioOtrosCabecera> lista = (List<ServicioOtrosCabecera>) results.get("vo_result");
		
		ServicioOtrosCabecera cabecera = lista.get(0);
		
		return cabecera;
		
	}

	@Override
	public List<ServicioOtrosDetalle> ServiciosOtrosDetalle(int codigoServicioOtros) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_BUSCAR_OTROS_SERVICIOS_DET");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(ServicioOtrosDetalle.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_servicio_otros", codigoServicioOtros);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<ServicioOtrosDetalle> lista = (List<ServicioOtrosDetalle>) results.get("vo_result");
		
		return lista;
		
	}

	@Override
	public Retorno eliminarOtrosServiciosCabeceraDetalle(int codigoServicioOtros) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_ELIMINAR_SERVICIO_OTROS").declareParameters(
				new SqlParameter("vi_codigo_servicio_otros", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 					Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 						Types.VARCHAR));
				
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_servicio_otros", 			codigoServicioOtros);
			
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
	public Retorno eliminarOtrosServiciosDetalle(int codigoServicioOtros) {
		
		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_ELIMINAR_SERV_OTROS_DETA").declareParameters(
				new SqlParameter("vi_codigo_servicio_otros", 			Types.INTEGER),
				
				new SqlOutParameter("vo_indicador", 					Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 						Types.VARCHAR));
				
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_servicio_otros", 			codigoServicioOtros);
			
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
	public FacturacionCabecera buscarFacturacionCabecera(FacturacionCabecera facturacion) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_BUSCAR_FACTURACION_CABECERA");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(FacturacionCabecera.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_facturacion_cabecera", facturacion.getCodigoFacturacionCab());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<FacturacionCabecera> lista = (List<FacturacionCabecera>) results.get("vo_result");
		
		FacturacionCabecera cabecera = lista.get(0);
		
		return cabecera;
		
	}

	@Override
	public List<FacturacionDetalle> buscarFacturacionDetalle(FacturacionCabecera facturacion) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_BUSCAR_FACTURACION_DETALLE");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(FacturacionDetalle.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_facturacion_cabecera", facturacion.getCodigoFacturacionCab());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<FacturacionDetalle> lista = (List<FacturacionDetalle>) results.get("vo_result");
		
		return lista;
		
	}

	@Override
	public ReporteFacturacionDetalle reporteFacturacionDetalle(int codigoFacturacionCab) {
		
		ReporteFacturacionDetalle reporte = new ReporteFacturacionDetalle();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_FACTURACION");
			jdbcCall.withProcedureName("SP_REPORTE_FACT_DIARIO_DETA").declareParameters(
					new SqlParameter("vi_codigo_facturacion_cab", 		Types.INTEGER),
					new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(VistaFacturacionDetalle.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_facturacion_cab", 	codigoFacturacionCab);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			//int totalRegistros = (Integer) results.get("vo_total_registros");
			List<VistaFacturacionDetalle> lista = (List<VistaFacturacionDetalle>) results.get("vo_result");
			
			reporte.setTotalRegistros(1);
			reporte.setListaFacturacion(lista);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;
	}

}