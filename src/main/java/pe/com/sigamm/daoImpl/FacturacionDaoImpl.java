package pe.com.sigamm.daoImpl;

import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import pe.com.sigamm.dao.FacturacionDao;
import pe.com.sigamm.modelo.Concepto;
import pe.com.sigamm.modelo.GiroComercial;
import pe.com.sigamm.session.DatosSession;

@Repository
public class FacturacionDaoImpl implements FacturacionDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public List<Concepto> listaConcepto() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_PUESTO");
		jdbcCall.withProcedureName("SP_LISTAR_CONCEPTO");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Concepto.class)));
		
		Map<String,Object> results = jdbcCall.execute();
		List<Concepto> lista = (List<Concepto>) results.get("vo_result");
		return  lista;
		
	}

}
