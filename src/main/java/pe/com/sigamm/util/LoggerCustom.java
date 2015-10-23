package pe.com.sigamm.util;

import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;

public class LoggerCustom
{
	private static final Logger log = Logger.getLogger(LoggerCustom.class);
	
	private final static SimpleDateFormat sdfF = new SimpleDateFormat("dd/MM/yyyy");
	private final static SimpleDateFormat sdfH = new SimpleDateFormat("hh:mm:ss");

	public static final String APP = "SIGAMM";
	
	public static void error(String aplicacion, Object o, String m, Exception e)
	{
		String msg = "";
		
		if(aplicacion != null && !aplicacion.equals(""))
		msg += "Aplicacion        : " + aplicacion + "\n";
		msg += "Fecha             : " + sdfF.format(new java.util.Date()) + "\n";
		msg += "Hora              : " + sdfH.format(new java.util.Date()) + "\n";
		if(o != null)
		msg += "Clase             : " + o.getClass().getName() + "\n";
		if(m != null && !m.equals(""))
		msg += "Metodo            : " + m + "\n";
		msg += "Tipo de error     : " + e.getClass().getSimpleName() + "\n";
		msg += "Causa del error   : " + e.getMessage() + "\n";
		
		StackTraceElement[] stackTrace = e.getStackTrace();
		
		if(stackTrace != null) 
		{
		msg += "Detalle del error : \n\n";
			StackTraceElement stackTraceElement = null;
			
			msg += e.getClass().getName() + ": " + e.getLocalizedMessage() + "\n";
			
			for (int i = 0; i < stackTrace.length; i++) {
				stackTraceElement = stackTrace[i];
				
				msg +=  "\t" + stackTraceElement.toString() + "\n";
			}
		}
		
		log.error(msg);
	}
	
	public static void errorApp(Object o, String m, Exception e)
	{
		error(APP, o, m, e);
	}
}
