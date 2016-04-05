package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import oracle.jdbc.OracleTypes;
import pe.com.sigamm.bean.OtroServicio;
import pe.com.sigamm.bean.OtroServicioDetalle;
import pe.com.sigamm.dao.OtrosServiciosDao;
import pe.com.sigamm.session.DatosSession;

@Repository
public class OtroServicioDaoImpl implements OtrosServiciosDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;

	@Override
	public List<OtroServicio> otrosServicios() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_LISTAR_OTROS_SERVICIOS").declareParameters(
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(OtroServicio.class)));
		
		Map<String,Object> results = jdbcCall.execute();
		List<OtroServicio> lista = (List<OtroServicio>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public List<OtroServicioDetalle> otrosServiciosDetalle(OtroServicio otro) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_FACTURACION");
		jdbcCall.withProcedureName("SP_LISTAR_OTROS_SERVICIOS_DETA").declareParameters(
				new SqlParameter("vi_codigo_servicio",				Types.INTEGER),
				new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(OtroServicioDetalle.class)));
	
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_servicio", 			otro.getCodigoServicio());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<OtroServicioDetalle> lista = (List<OtroServicioDetalle>) results.get("vo_result");
		return  lista;
	}
	
}