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

import pe.com.sigamm.bean.Imei;
import pe.com.sigamm.dao.UsuariosDao;
import pe.com.sigamm.modelo.Rol;
import pe.com.sigamm.modelo.Unidad;
import pe.com.sigamm.modelo.Usuario;
import pe.com.sigamm.session.DatosSession;
import pe.com.sigamm.util.Constantes;
import pe.com.sigamm.util.LoggerCustom;
import pe.com.sigamm.util.Seguridad;

@Repository
public class UsuariosDaoImpl implements UsuariosDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
	public List<Usuario> listaUsuarios(int pagina, int registros, int codigoInstitucion, int codigoUnidad) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_USUARIOS");
		jdbcCall.withProcedureName("SP_REPORTE_USUARIOS");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Usuario.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", codigoInstitucion);
		parametros.addValue("vi_pagina", pagina);
		parametros.addValue("vi_registros", registros);
		parametros.addValue("vi_codigo_unidad", codigoUnidad);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Usuario> lista = (List<Usuario>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public int cantidadUsuarios(int codigoInstitucion) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_USUARIOS");
		jdbcCall.withProcedureName("SP_CANTIDAD_USUARIOS").declareParameters(
				new SqlParameter("vi_codigo_institucion",	Types.INTEGER),
				new SqlOutParameter("vo_cantidad", 			Types.INTEGER));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", codigoInstitucion);
		
		Map<String,Object> result = jdbcCall.execute(parametros); 
		
		int cantidadRegistros = (Integer) result.get("vo_cantidad");
			
		return cantidadRegistros;
		
	}

	@Override
	public List<Rol> listaRol(int codigoUnidad) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_USUARIOS");
		jdbcCall.withProcedureName("SP_LISTA_ROL");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Rol.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", datosSession.getCodigoInstitucion());
		parametros.addValue("vi_codigo_unidad", codigoUnidad);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Rol> lista = (List<Rol>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public List<Unidad> listaUnidad() {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_USUARIOS");
		jdbcCall.withProcedureName("SP_LISTA_UNIDAD");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Unidad.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_codigo_institucion", datosSession.getCodigoInstitucion());
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Unidad> lista = (List<Unidad>) results.get("vo_result");
		return  lista;
		
	}

	@Override
	public int grabarUsuario(Usuario usuario, List<Imei> lista) {
		
		int codigo = 0;
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_USUARIOS");
			jdbcCall.withProcedureName("SP_GRABAR_USUARIO").declareParameters(
				new SqlParameter("vi_codigo_usuario", 		Types.INTEGER),
				new SqlParameter("vi_userid", 				Types.VARCHAR),
				new SqlParameter("vi_ape_paterno", 			Types.VARCHAR),
				new SqlParameter("vi_ape_materno", 			Types.VARCHAR),
				new SqlParameter("vi_nombres", 				Types.VARCHAR),
				new SqlParameter("vi_fecha_nacimiento", 	Types.VARCHAR),
				new SqlParameter("vi_correo", 				Types.VARCHAR),
				new SqlParameter("vi_telefono", 			Types.VARCHAR),
				new SqlParameter("vi_codigo_rol", 			Types.INTEGER),
				new SqlParameter("vi_codigo_unidad", 		Types.INTEGER),
				new SqlParameter("vi_codigo_institucion", 	Types.INTEGER),
				new SqlParameter("vi_estado", 				Types.VARCHAR),
				new SqlParameter("vi_usuario_registro",		Types.VARCHAR),
				new SqlParameter("vi_clave",				Types.VARCHAR),
				new SqlParameter("vi_dni",					Types.VARCHAR),
				
				new SqlOutParameter("vo_codigo_usuario", 	Types.INTEGER),
				new SqlOutParameter("vo_indicador", 		Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 			Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_usuario", 		usuario.getCodigoUsuario());
			parametros.addValue("vi_userid", 				usuario.getUserid() != null ? usuario.getUserid().toUpperCase() : "");
			parametros.addValue("vi_ape_paterno", 			usuario.getApellidoPaterno() != null ? usuario.getApellidoPaterno().toUpperCase() : "");
			parametros.addValue("vi_ape_materno", 			usuario.getApellidoMaterno() != null ? usuario.getApellidoMaterno().toUpperCase() : "");
			parametros.addValue("vi_nombres", 				usuario.getNombres() != null ? usuario.getNombres().toUpperCase() : "");
			parametros.addValue("vi_fecha_nacimiento", 		usuario.getFechaNacimiento());
			parametros.addValue("vi_correo", 				usuario.getCorreo() != null ? usuario.getCorreo().toUpperCase() : "");
			parametros.addValue("vi_telefono", 				usuario.getTelefono() != null ? usuario.getTelefono() : "");
			parametros.addValue("vi_codigo_rol", 			usuario.getCodigoRol());
			parametros.addValue("vi_codigo_unidad", 		usuario.getCodigoUnidad());
			parametros.addValue("vi_codigo_institucion", 	datosSession.getCodigoInstitucion());
			parametros.addValue("vi_estado", 				usuario.getEstado());
			parametros.addValue("vi_usuario_registro",		datosSession.getUsuario());
			parametros.addValue("vi_clave",					Seguridad.fn_sEncrypting("PASSWORD", Constantes.CLAVE_DEFAULT));
			parametros.addValue("vi_dni",					usuario.getDni());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoUsuario = (Integer) result.get("vo_codigo_usuario");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			codigo = codigoUsuario;
			
		}catch(Exception e){
			
			codigo = 0;
			LoggerCustom.errorApp(this, "", e);
		}
		
		return codigo;
		
	}
	
	@Override
	public String resetearClave(int codigoUsuario, String clave) {
		
		String codigo = "01";
		String pwd = "";
		try{
			if(clave == null || clave.equals(""))
			{
				pwd = Seguridad.fn_sEncrypting("PASSWORD", Constantes.CLAVE_DEFAULT);
			}else{
				pwd = Seguridad.fn_sEncrypting("PASSWORD", clave);
			}	
			
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_AUTENTICACION");
			jdbcCall.withProcedureName("SP_RESETEAR_CLAVE").declareParameters(
				new SqlParameter("vi_codigo_usuario", 		Types.INTEGER),
				new SqlParameter("vi_clave", 				Types.VARCHAR),
				new SqlOutParameter("vo_indicador", 		Types.VARCHAR),
				new SqlOutParameter("vo_mensaje", 			Types.VARCHAR));
				
            
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_codigo_usuario", 		codigoUsuario);
			parametros.addValue("vi_clave", 				pwd);
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			codigo = indicador;
			
		}catch(Exception e){
			
			codigo = "01";
			LoggerCustom.errorApp(this, "", e);
		}
		
		return codigo;
	}

	@Override
	public Usuario buscarUsuario(String dni) {
		
		jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
		jdbcCall.withCatalogName("PKG_USUARIOS");
		jdbcCall.withProcedureName("SP_BUSCAR_USUARIO");
		jdbcCall.addDeclaredParameter(new SqlOutParameter("vo_result", OracleTypes.CURSOR,new BeanPropertyRowMapper(Usuario.class)));
		
		MapSqlParameterSource parametros = new MapSqlParameterSource();
		parametros.addValue("vi_dni", dni);
		
		Map<String,Object> results = jdbcCall.execute(parametros);
		List<Usuario> lista = (List<Usuario>) results.get("vo_result");
		
		Usuario usuario = lista.get(0);
		
		return  usuario;
		
	}

}
