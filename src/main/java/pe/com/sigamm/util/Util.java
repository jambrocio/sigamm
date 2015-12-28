package pe.com.sigamm.util;

import pe.com.sigamm.bean.CamposObligatorios;

public class Util {

	public static CamposObligatorios retornarObjeto(String nombreCampo, String descripcion){
        CamposObligatorios campos = new CamposObligatorios();
        campos.setNombreCampo(nombreCampo);
        campos.setDescripcion(descripcion);
        return campos;
    }
	
	
}
