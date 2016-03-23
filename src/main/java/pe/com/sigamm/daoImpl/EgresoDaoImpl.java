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

import pe.com.sigamm.bean.ReporteEgreso;
import pe.com.sigamm.dao.EgresoDao;
import pe.com.sigamm.modelo.Egreso;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class EgresoDaoImpl implements EgresoDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public ReporteEgreso reportarEgreso(String fechaInicial, String fechaFinal) {

		ReporteEgreso reporte = new ReporteEgreso();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_EGRESO");
			jdbcCall.withProcedureName("SP_REPORTAR_EGRESO_XLS").declareParameters(
					new SqlParameter("vi_fecha_inicio", 				Types.VARCHAR),
					new SqlParameter("vi_fecha_termino", 				Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(Egreso.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_fecha_inicio", 		fechaInicial);
			parametros.addValue("vi_fecha_termino", 	fechaFinal);
			
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
	
	

}
