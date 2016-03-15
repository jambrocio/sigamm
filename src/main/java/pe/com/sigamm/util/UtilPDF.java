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

	public static final String TITULO_RECIBO = "ASOCIACI�N DE COMERCIANTES DEL MERCADO MODELO DE HUARAL";
	public static final String RUC = "R.U.C 20530606334";
<<<<<<< HEAD
	public static final String LEYENDA_RECIBO = "RECIBO DE AGUA N�: ";
=======
	public static final String LEYENDA_RECIBO = "RECIBO PROVISIONAL N�: ";
>>>>>>> 3333fc3496d1dbcaddd19416107807e1ba6ac165
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

		String id = periodo;
		correlativo = correlativo + 1;

		if (id.contains("ENERO")) {
			id = id.replace("ENERO ", "01") + correlativo;
		} else if (id.contains("FEBRERO")) {
			id = id.replace("FEBRERO ", "02") + correlativo;
		} else if (id.contains("MARZO")) {
			id = id.replace("MARZO ", "03") + correlativo;
		} else if (id.contains("ABRIL")) {
			id = id.replace("ABRIL ", "04") + correlativo;
		} else if (id.contains("MAYO")) {
			id = id.replace("MAYO ", "05") + correlativo;
		} else if (id.contains("JUNIO")) {
			id = id.replace("JUNIO ", "06") + correlativo;
		} else if (id.contains("JULIO")) {
			id = id.replace("JULIO ", "07") + correlativo;
		} else if (id.contains("AGOSTO")) {
			id = id.replace("AGOSTO ", "08") + correlativo;
		} else if (id.contains("SEPTIEMBRE")) {
			id = id.replace("SEPTIEMBRE ", "09") + correlativo;
		} else if (id.contains("OCTUBRE")) {
			id = id.replace("OCTUBRE ", "10") + correlativo;
		} else if (id.contains("NOVIEMBRE")) {
			id = id.replace("NOVIEMBRE ", "11") + correlativo;
		} else if (id.contains("DICIEMBRE")) {
			id = id.replace("DICIEMBRE ", "12") + correlativo;
		}
		return id;

	}

}
