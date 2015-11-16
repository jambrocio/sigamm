package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

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
	public Retorno grabarReciboLuzSocio(ReciboLuzSocio reciboLuzSocio) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Grabando Recibo Luz Socio");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_SOCIO");
			jdbcCall.withProcedureName("SP_GRABAR_LUZ_X_SOCIO").declareParameters(
					new SqlParameter("vi_codigo_socio", 		Types.NUMERIC),
					new SqlParameter("vi_codigo_recibo", 		Types.NUMERIC),
					new SqlParameter("vi_correlativo", 			Types.NUMERIC),
					new SqlParameter("vi_lectura_inicial", 		Types.NUMERIC),
					new SqlParameter("vi_lectura_final", 		Types.NUMERIC),
					new SqlParameter("vi_consumo_mes", 			Types.NUMERIC),
					new SqlParameter("vi_cargo_fijo", 			Types.NUMERIC),
					new SqlParameter("vi_cargo_energia", 		Types.NUMERIC),
					new SqlParameter("vi_alumbrado_publico", 	Types.NUMERIC),
					new SqlParameter("vi_servicio_mantenimiento",Types.NUMERIC),
					new SqlParameter("vi_deuda_anterior", 		Types.NUMERIC),
					new SqlParameter("vi_reconexion", 			Types.NUMERIC),
					new SqlParameter("vi_subtotal_mes", 		Types.NUMERIC),
					new SqlParameter("vi_igv", 					Types.NUMERIC),
					new SqlParameter("vi_total_mes", 			Types.NUMERIC),
					new SqlParameter("vi_redondeo", 			Types.NUMERIC),
					new SqlParameter("vi_total", 				Types.NUMERIC),
					new SqlParameter("vi_estado", 				Types.NUMERIC),
					new SqlParameter("vi_fecha_carga", 			Types.DATE),
					new SqlParameter("vi_usuario_crea", 		Types.VARCHAR),
					new SqlParameter("vi_usuario_modifica", 	Types.VARCHAR),	
					
					new SqlOutParameter("vo_codigo_socio",  		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));	
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			parametros.addValue("vi_codigo_socio", 		reciboLuzSocio.getCodigoSocio());
			parametros.addValue("vi_codigo_recibo",		reciboLuzSocio.getCodigoRecibo());
			parametros.addValue("vi_correlativo",		reciboLuzSocio.getCorrelativo());
			parametros.addValue("vi_lectura_inicial", 	reciboLuzSocio.getLecturaInicial());
			parametros.addValue("vi_lectura_final", 	reciboLuzSocio.getLecturaFinal());
			parametros.addValue("vi_consumo_mes", 		reciboLuzSocio.getConsumoMes());
			parametros.addValue("vi_cargo_fijo", 		reciboLuzSocio.getCargoFijo());
			parametros.addValue("vi_cargo_energia",		reciboLuzSocio.getCargoEnergia());
			parametros.addValue("vi_alumbrado_publico",	reciboLuzSocio.getAlumbradoPublico());
			parametros.addValue("vi_servicio_mantenimiento",reciboLuzSocio.getServicioMantenimiento());
			parametros.addValue("vi_deuda_anterior",	reciboLuzSocio.getDeudaAnterior());
			parametros.addValue("vi_reconexion",		reciboLuzSocio.getReconexion());
			parametros.addValue("vi_subtotal_mes",		reciboLuzSocio.getSubtotalMes());
			parametros.addValue("vi_igv",				reciboLuzSocio.getIgv());
			parametros.addValue("vi_total_mes",			reciboLuzSocio.getTotalMes());
			parametros.addValue("vi_redondeo",			reciboLuzSocio.getRedondeo());
			parametros.addValue("vi_total",				reciboLuzSocio.getTotal());
			parametros.addValue("vi_estado",			reciboLuzSocio.getEstado());
			parametros.addValue("vi_fecha_carga",		reciboLuzSocio.getFechaCarga());
			parametros.addValue("vi_usuario_crea",		datosSession.getCodigoUsuario());
			parametros.addValue("vi_usuario_modifica",	null);
			
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