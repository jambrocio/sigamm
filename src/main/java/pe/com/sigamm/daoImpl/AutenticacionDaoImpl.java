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

import pe.com.sigamm.bean.Retorno;
import pe.com.sigamm.bean.Usuario;
import pe.com.sigamm.dao.AutenticacionDao;
import pe.com.sigamm.modelo.MenuPrincipal;

@Repository
public class AutenticacionDaoImpl implements AutenticacionDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Override
	public Retorno autenticacion(Usuario usuario) {
		
		Retorno retorno = new Retorno(); 
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_AUTENTICACION");
		jdbcCall.withProcedureName("SP_AUTENTICACION_USUARIO").declareParameters(
				new SqlParameter("vi_usuario",				Types.VARCHAR),
				new SqlParameter("vi_clave",				Types.VARCHAR),
				new SqlParameter("vi_ip_address",			Types.VARCHAR),
				new SqlOutParameter("vo_codigo_usuario", 	Types.INTEGER),
				new SqlOutParameter("vo_codigo_rol", 		Types.INTEGER),
				new SqlOutParameter("vo_codigo_institucion",Types.INTEGER),
				new SqlOutParameter("vo_descripcion_rol", 	Types.VARCHAR),
				new SqlOutParameter("vo_nombres_full", 		Types.VARCHAR),
				new SqlOutParameter("vo_nombre_institucion",Types.VARCHAR),
				new SqlOutParameter("vo_codigo_ut",			Types.INTEGER),
				new SqlOutParameter("vo_nombre_ut",			Types.VARCHAR),
				new SqlOutParameter("vo_codigo", 			Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 			Types.VARCHAR));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_usuario", 				usuario.getUsuario());
		parametros.addValue("vi_clave", 				usuario.getClave());
		parametros.addValue("vi_ip_address", 			usuario.getIpRemote());
		
		Map<String,Object> result = jdbcCall.execute(parametros); 
		
		retorno.setCodigoRetorno((String) result.get("vo_codigo"));
		retorno.setMensajeRetorno((String) result.get("vo_mensaje"));
		retorno.setCodigoRol((Integer) result.get("vo_codigo_rol"));
		retorno.setCodigoUsuario((Integer) result.get("vo_codigo_usuario"));
		retorno.setDescripcionRol((String) result.get("vo_descripcion_rol"));
		retorno.setCodigoInstitucion((Integer) result.get("vo_codigo_institucion"));
		retorno.setNombreInstitucion((String) result.get("vo_nombre_institucion"));
		retorno.setCodigoUt((Integer) result.get("vo_codigo_ut"));
		retorno.setNombreUt((String) result.get("vo_nombre_ut"));
		retorno.setNombresFull((String) result.get("vo_nombres_full"));
		
		return retorno;
		
	}

	@Override
	public List<MenuPrincipal> opcionesMenu(int codigoUsuario) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_AUTENTICACION");
		jdbcCall.withProcedureName("SP_LISTA_OPCIONES_MENU");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(MenuPrincipal.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_usuario", codigoUsuario);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<MenuPrincipal> lista = (List<MenuPrincipal>) results.get("vo_result");
		return  lista;
		
	}

}
