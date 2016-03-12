package pe.com.sigamm.util;

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
	public static final String LEYENDA_RECIBO = "RECIBO PROVISIONAL N°: ";
	
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
	
	public static String getDatePDF(){
		Date fechaActual = new Date();
        String fechaActualStr = new SimpleDateFormat("ddMMyyyyhhmmss").format(fechaActual);
        return fechaActualStr;
	}
	
}
