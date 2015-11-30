package pe.com.sigamm.daoImpl;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import pe.com.sigamm.bean.ReportePuesto;
import pe.com.sigamm.bean.ReporteReciboLuzOriginal;
import pe.com.sigamm.dao.ReciboLuzOriginalDao;
import pe.com.sigamm.modelo.LuzOriginal;
import pe.com.sigamm.modelo.Puesto;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.util.LoggerCustom;

@Repository
public class ReciboLuzOriginalDaoImpl implements ReciboLuzOriginalDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private SimpleJdbcCall jdbcCall;
	
	@Override
	public Retorno grabarReciboLuzOriginal(LuzOriginal luzoriginal) {
		Retorno retorno = new Retorno();
		try{
			System.out.println("Grabando Recibo Luz Original");
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			jdbcCall.withProcedureName("SP_INS_RECIBOORILUZ").declareParameters(
					new SqlParameter("p_FEC_PERIODO", 			Types.VARCHAR),
					new SqlParameter("p_FECVENCIMIENTO",		Types.VARCHAR),
					new SqlParameter("p_FECEMISION",			Types.VARCHAR),
					new SqlParameter("p_NUM_COSTO_WATS",		Types.NUMERIC),
					new SqlParameter("p_NUM_ESTADO",			Types.NUMERIC),
					new SqlParameter("p_REPOMANCNX",			Types.NUMERIC),
					new SqlParameter("p_CARGOFIJO",				Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTAACTUAL",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTAANTERI",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTADIFER",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTAFACTOR",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTACONSU",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTACONFA",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTAPREUNI",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTFRAPTATOTAL",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTAACTU",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTAANT",		Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTADIF",		Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTAFAC",		Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTACONS",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTACONFAC",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTAPREUNI",	Types.NUMERIC),
					new SqlParameter("p_ENERGACTHORPTATOTAL",	Types.NUMERIC),
					new SqlParameter("p_ENERGREACINICIAL",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACANTERI",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACDIFERE",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACFACTOR",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACCONSU",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACFACCONS",   	Types.NUMERIC),
					new SqlParameter("p_ENERGREACPREUNI",		Types.NUMERIC),
					new SqlParameter("p_ENERGREACTOTAL",		Types.NUMERIC),
					new SqlParameter("p_INTERESCOMPENSATORIO",	Types.NUMERIC),
					new SqlParameter("p_POTENCIAFPINI",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAFPANTE",		Types.NUMERIC),
					new SqlParameter("p_POTENCIAFPDIF",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAFPFAC",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAFPCONS",		Types.NUMERIC),
					new SqlParameter("p_POTENCIAHPACT",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAHPANT",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAHPDIF",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAHPFAC",			Types.NUMERIC),
					new SqlParameter("p_POTENCIAHPCONS",		Types.NUMERIC),
					new SqlParameter("p_POTUSOREDDISTCONFAC",	Types.NUMERIC),
					new SqlParameter("p_POTUSOREDDISTPREUNI",	Types.NUMERIC),
					new SqlParameter("p_POTUSOREDDISTTOTAL",	Types.NUMERIC),
					new SqlParameter("p_POTGENFPCONFAC",		Types.NUMERIC),
					new SqlParameter("p_POTGENFPPREUNI",		Types.NUMERIC),
					new SqlParameter("p_POTGENFPTOTAL",			Types.NUMERIC),
					new SqlParameter("p_ALUMBRADOPUBLICO",		Types.NUMERIC),
					new SqlParameter("p_SUBTOTALMES",			Types.NUMERIC),
					new SqlParameter("p_IGV",					Types.NUMERIC),
					new SqlParameter("p_TOTALMESACT",			Types.NUMERIC),
					new SqlParameter("p_APORTELEY",				Types.NUMERIC),
					new SqlParameter("p_DEUDAANTERIOR",			Types.NUMERIC),
					new SqlParameter("p_REDONMESANT",			Types.NUMERIC),
					new SqlParameter("p_REDONMESACT",			Types.NUMERIC),
					new SqlParameter("p_ALUMBRADOPUBLICOORIGINAL",	Types.NUMERIC),
					new SqlParameter("p_RECARGOMORA",			Types.NUMERIC),
					
					new SqlOutParameter("vo_codigo_recibo", 		Types.INTEGER),
					new SqlOutParameter("vo_indicador", 			Types.VARCHAR),
					new SqlOutParameter("vo_mensaje", 				Types.VARCHAR));	
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();

			/*SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
			String strFecha = "2007-12-25";
			Date fechaPeriodo = null;
			fechaPeriodo = formatoDelTexto.parse(luzoriginal.getPeriodo());*/
			
			parametros.addValue("p_FEC_PERIODO", 				luzoriginal.getPeriodo());
			parametros.addValue("p_FECVENCIMIENTO",				luzoriginal.getFecVencimiento());
			parametros.addValue("p_FECEMISION",					luzoriginal.getFecEmision());
			parametros.addValue("p_NUM_COSTO_WATS",				luzoriginal.getCostoWats());
			parametros.addValue("p_NUM_ESTADO",					luzoriginal.getEstado());
			parametros.addValue("p_REPOMANCNX",					luzoriginal.getRepoManCnx());
			parametros.addValue("p_CARGOFIJO",					luzoriginal.getCargoFijo());
			parametros.addValue("p_ENERGACTFRAPTAACTUAL",		luzoriginal.getEnergActFraPtaActual());
			parametros.addValue("p_ENERGACTFRAPTAANTERI",		luzoriginal.getEnergActFraPtaAnteri());
			parametros.addValue("p_ENERGACTFRAPTADIFER",		luzoriginal.getEnergActFraPtaDifer());
			parametros.addValue("p_ENERGACTFRAPTAFACTOR",		luzoriginal.getEnergActFraPtaFactor());
			parametros.addValue("p_ENERGACTFRAPTACONSU",		luzoriginal.getEnergActFraPtaConsu());
			parametros.addValue("p_ENERGACTFRAPTACONFA",		luzoriginal.getEnergActFraPtaConfa());
			parametros.addValue("p_ENERGACTFRAPTAPREUNI",		luzoriginal.getEnergActFraPtaPreuni());
			parametros.addValue("p_ENERGACTFRAPTATOTAL",		luzoriginal.getEnergActFraPtaTotal());
			parametros.addValue("p_ENERGACTHORPTAACTU",			luzoriginal.getEnergActHorPtaActu());
			parametros.addValue("p_ENERGACTHORPTAANT",			luzoriginal.getEnergActHorPtaAnt());
			parametros.addValue("p_ENERGACTHORPTADIF",			luzoriginal.getEnergActHorPtaDif());
			parametros.addValue("p_ENERGACTHORPTAFAC",			luzoriginal.getEnergActHorPtaFac());
			parametros.addValue("p_ENERGACTHORPTACONS",			luzoriginal.getEnergActHorPtaCons());
			parametros.addValue("p_ENERGACTHORPTACONFAC",		luzoriginal.getEnergActHorPtaConfac());
			parametros.addValue("p_ENERGACTHORPTAPREUNI",		luzoriginal.getEnergActHorPtaPreuni());
			parametros.addValue("p_ENERGACTHORPTATOTAL",		luzoriginal.getEnergActHorPtaTotal());
			parametros.addValue("p_ENERGREACINICIAL",			luzoriginal.getEnergReacInicial());
			parametros.addValue("p_ENERGREACANTERI",			luzoriginal.getEnergReacAnteri());
			parametros.addValue("p_ENERGREACDIFERE",			luzoriginal.getEnergReacDifere());
			parametros.addValue("p_ENERGREACFACTOR",			luzoriginal.getEnergReacFactor());
			parametros.addValue("p_ENERGREACCONSU",				luzoriginal.getEnergReacConsu());
			parametros.addValue("p_ENERGREACFACCONS",   		luzoriginal.getEnergReacFaccons());
			parametros.addValue("p_ENERGREACPREUNI",			luzoriginal.getEnergReacPreuni());
			parametros.addValue("p_ENERGREACTOTAL",				luzoriginal.getEnergReacTotal());
			parametros.addValue("p_INTERESCOMPENSATORIO",		luzoriginal.getInteresCompensatorio());
			parametros.addValue("p_POTENCIAFPINI",				luzoriginal.getPotenciaFpIni());
			parametros.addValue("p_POTENCIAFPANTE",				luzoriginal.getPotenciaFpAnte());
			parametros.addValue("p_POTENCIAFPDIF",				luzoriginal.getPotenciaFpDif());
			parametros.addValue("p_POTENCIAFPFAC",				luzoriginal.getPotenciaFpFac());
			parametros.addValue("p_POTENCIAFPCONS",				luzoriginal.getPotenciaFpCons());
			parametros.addValue("p_POTENCIAHPACT",				luzoriginal.getPotenciaHpAct());
			parametros.addValue("p_POTENCIAHPANT",				luzoriginal.getPotenciaHpAnt());
			parametros.addValue("p_POTENCIAHPDIF",				luzoriginal.getPotenciaHpDif());
			parametros.addValue("p_POTENCIAHPFAC",				luzoriginal.getPotenciaHpFac());
			parametros.addValue("p_POTENCIAHPCONS",				luzoriginal.getPotenciaHpCons());
			parametros.addValue("p_POTUSOREDDISTCONFAC",		luzoriginal.getPotUsoRedDistConfac());
			parametros.addValue("p_POTUSOREDDISTPREUNI",		luzoriginal.getPotUsoRedDistPreuni());
			parametros.addValue("p_POTUSOREDDISTTOTAL",			luzoriginal.getPotUsoRedDistTotal());
			parametros.addValue("p_POTGENFPCONFAC",				luzoriginal.getPotGenFpConfac());
			parametros.addValue("p_POTGENFPPREUNI",				luzoriginal.getPotGenFpPreuni());
			parametros.addValue("p_POTGENFPTOTAL",				luzoriginal.getPotGenFpTotal());
			parametros.addValue("p_ALUMBRADOPUBLICO",			luzoriginal.getAlumbradoPublico());
			parametros.addValue("p_SUBTOTALMES",				luzoriginal.getSubTotalMes());
			parametros.addValue("p_IGV",						luzoriginal.getIgv());
			parametros.addValue("p_TOTALMESACT",				luzoriginal.getTotalMesAct());
			parametros.addValue("p_APORTELEY",					luzoriginal.getAporteLey());
			parametros.addValue("p_DEUDAANTERIOR",				luzoriginal.getDeudaAnterior());
			parametros.addValue("p_REDONMESANT",				luzoriginal.getRedonMesAnt());
			parametros.addValue("p_REDONMESACT",				luzoriginal.getRedonMesAct());
			parametros.addValue("p_ALUMBRADOPUBLICOORIGINAL",	luzoriginal.getAlumbradoPublicoOriginal());
			parametros.addValue("p_RECARGOMORA",				luzoriginal.getRecargoMora());
			
			Map<String,Object> result = jdbcCall.execute(parametros); 
			
			int codigoRecibo = (Integer) result.get("vo_codigo_recibo");
			String indicador = (String) result.get("vo_indicador");
			String mensaje = (String) result.get("vo_mensaje");
			
			retorno.setCodigo(codigoRecibo);
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
	public ReporteReciboLuzOriginal reporteReciboLuzOriginal(int pagina,int registros, String codigoReciboLuzOriginal) {

		ReporteReciboLuzOriginal reporte = new ReporteReciboLuzOriginal();
		try{
			jdbcCall = new SimpleJdbcCall(jdbcTemplate.getDataSource());
			jdbcCall.withCatalogName("PKG_RECIBO_LUZ_ORIG");
			
			jdbcCall.withProcedureName("SP_REPORTE_LUZ_ORIG").declareParameters(
					new SqlParameter("vi_pagina", 					Types.INTEGER),
					new SqlParameter("vi_registros", 				Types.INTEGER),
					new SqlParameter("vi_codigo_recibo_luz_orig", 	Types.VARCHAR),
					
					new SqlOutParameter("vo_total_registros", 		Types.INTEGER),
					new SqlOutParameter("vo_result", 				OracleTypes.CURSOR,new BeanPropertyRowMapper(LuzOriginal.class)));
			
			MapSqlParameterSource parametros = new MapSqlParameterSource();
			parametros.addValue("vi_pagina", 	pagina);
			parametros.addValue("vi_registros", registros);
			parametros.addValue("vi_codigo_recibo_luz_orig", codigoReciboLuzOriginal);
			
			Map<String,Object> results = jdbcCall.execute(parametros);
			int totalRegistros = (Integer) results.get("vo_total_registros");
			List<LuzOriginal> lista = (List<LuzOriginal>) results.get("vo_result");
			
			reporte.setTotalRegistros(totalRegistros);
			reporte.setListaReciboLuzOriginal(lista);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return  reporte;

	}

}
