package pe.com.sigamm.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class OperadoresUtil {
	public static Integer obtenerCociente(Integer dividendo, Integer divisor) {
		if ((dividendo % divisor) == 0) {
			return dividendo / divisor;
		} else {
			return dividendo / divisor + 1;
		}

	}

	public static Date StringToDate(String fecha) {

		DateFormat formatter;
		Date date = null;
		formatter = new SimpleDateFormat("dd/MM/yyyy");
		try {
			date = formatter.parse(fecha);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date;

	}

	public static Double StringToDouble(String valor) {
		if (valor.equals("")) {
			return 0.0;
		} else {
			return Double.parseDouble(valor);
		}
	}

	public static Integer StringToInteger(String valor) {

		if (valor.equals("")) {
			return 0;
		} else {
			return Integer.parseInt(valor);
		}
	}
}
