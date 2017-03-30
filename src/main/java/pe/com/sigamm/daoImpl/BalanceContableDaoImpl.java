package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import pe.com.sigamm.dao.BalanceContableDao;
import pe.com.sigamm.modelo.BalanceContable;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class BalanceContableDaoImpl implements BalanceContableDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public Retorno BuscarBalanceContable(BalanceContable balanceContable) {

		Retorno retorno = new Retorno();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_BALANCE_CONTABLE");
			jdbcCall.withProcedureName("SP_REPORTE_BALANCE_CONTABLE").declareParameters(
					
				new SqlParameter("vi_fechaIni",   			    Types.VARCHAR),
				new SqlParameter("vi_fechaFin", 				Types.VARCHAR),
				new SqlOutParameter("vo_total_registros", 		Types.INTEGER));
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_fechaIni", 			balanceContable.getFechaIni());
			parametros.addValue("vi_fechaFin", 			balanceContable.getFechaFin());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int totalRegistros = (Integer) result.get("vo_total_registros");
			
			retorno.setCodigo(totalRegistros);
			
		}catch(Exception e){
			
			retorno.setCodigo(0);
			retorno.setIndicador("");
			retorno.setMensaje("");
			LoggerCustom.errorApp(this, "", e);
		}
		
		return retorno;
		
	}


}
