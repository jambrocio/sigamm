package pe.com.sigamm.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BarcodeQRCode;

public class UtilPDF {

	public static final String TITULO_RECIBO = "ASOCIACIÓN DE COMERCIANTES DEL MERCADO MODELO DE HUARAL";
	public static final String RUC = "R.U.C 20530606334";
	public static final String LEYENDA_RECIBO = "RECIBO DE AGUA N°: ";
	public static final String RUTA_PDF = "/usr/share/jboss-eap-6.1/reportes/";

	public static void addEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}

	public static Document getAutorPDF(Document doc) {
		doc.addAuthor("Sistema Sigamm");
		doc.addCreationDate();
		doc.addProducer();
		doc.addCreator("Sistema Sigamm");
		doc.addTitle("Recibo");
		doc.setPageSize(PageSize.LETTER);
		return doc;
	}

	public static Image getQRCode(String value) {
		Image qrcodeImage = null;
		try {
			BarcodeQRCode qrcode = new BarcodeQRCode(value.trim(), 1, 1, null);
			qrcodeImage = qrcode.getImage();
			qrcodeImage.scalePercent(200);
		} catch (BadElementException ex) {
			System.out.println("Ocurrio un error al generar codigo QR");
		}
		return qrcodeImage;
	}

	public static Paragraph writeLegend(String value, Integer fontSize) {
		Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, fontSize,
				Font.BOLD);
		Paragraph preface = new Paragraph();
		addEmptyLine(preface, 1);
		preface.add(new Paragraph(value, catFont));
		preface.setAlignment(Element.ALIGN_CENTER);
		addEmptyLine(preface, 0);
		return preface;
	}

	public static String getDatePDF() {
		Date fechaActual = new Date();
		String fechaActualStr = new SimpleDateFormat("ddMMyyyyhhmmss")
				.format(fechaActual);
		return fechaActualStr;
	}

	public static String round(double value, int places) {
		DecimalFormat df = new DecimalFormat("#0.00");
		return df.format(value);
	}

	
	public static String getID(String periodo, Integer correlativo) {

		String[] id = periodo.split(" ");
		correlativo = correlativo + 1;
		String numero = "";
		
		if (id[0].contains("ENERO")) {
			numero = id[1] + id[0].replace("ENERO", "01") + String.format("%09d", correlativo);
		} else if (id[0].contains("FEBRERO")) {
			numero = id[1] + id[0].replace("FEBRERO", "02") + String.format("%09d", correlativo);
		} else if (id[0].contains("MARZO")) {
			numero = id[1] + id[0].replace("MARZO", "03") + String.format("%09d", correlativo);
		} else if (id[0].contains("ABRIL")) {
			numero = id[1] + id[0].replace("ABRIL", "04") + String.format("%09d", correlativo);
		} else if (id[0].contains("MAYO")) {
			numero = id[1] + id[0].replace("MAYO", "05") + String.format("%09d", correlativo);
		} else if (id[0].contains("JUNIO")) {
			numero = id[1] + id[0].replace("JUNIO", "06") + String.format("%09d", correlativo);
		} else if (id[0].contains("JULIO")) {
			numero = id[1] + id[0].replace("JULIO", "07") + String.format("%09d", correlativo);
		} else if (id[0].contains("AGOSTO")) {
			numero = id[1] + id[0].replace("AGOSTO", "08") + String.format("%09d", correlativo);
		} else if (id[0].contains("SEPTIEMBRE")) {
			numero = id[1] + id[0].replace("SEPTIEMBRE", "09") + String.format("%09d", correlativo);
		} else if (id[0].contains("OCTUBRE")) {
			numero = id[1] + id[0].replace("OCTUBRE", "10") + String.format("%09d", correlativo);
		} else if (id[0].contains("NOVIEMBRE")) {
			numero = id[1] + id[0].replace("NOVIEMBRE", "11") + String.format("%09d", correlativo);
		} else if (id[0].contains("DICIEMBRE")) {
			numero = id[1] + id[0].replace("DICIEMBRE", "12") + String.format("%09d", correlativo);
		}
		return numero;

	}

}
