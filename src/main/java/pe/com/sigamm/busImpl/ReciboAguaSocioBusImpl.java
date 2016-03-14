package pe.com.sigamm.busImpl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.lowagie.text.Cell;

import pe.com.sigamm.bean.ReporteReciboAguaSocio;
import pe.com.sigamm.bus.ReciboAguaSocioBus;
import pe.com.sigamm.dao.ReciboAguaSocioDao;
import pe.com.sigamm.modelo.ReciboAguaSocio;
import pe.com.sigamm.modelo.Retorno;
import pe.com.sigamm.util.UtilPDF;

@Service
public class ReciboAguaSocioBusImpl implements ReciboAguaSocioBus {

	Gson gson = new Gson();
	private static final Logger log = Logger
			.getLogger(ReciboLuzSocioBusImpl.class);

	@Resource
	private ReciboAguaSocioDao reciboAguaSocioDao;

	@Override
	public ReporteReciboAguaSocio reportePuestoAguaSocio(int pagina,
			int registros, String numeroPuesto, int codigoRecibo) {

		return reciboAguaSocioDao.reporteReciboAguaSocio(pagina, registros,
				numeroPuesto, codigoRecibo);

	}

	@Override
	public ReporteReciboAguaSocio editarReciboAguaxSocio(int pagina,
			int registros, String puestoSocio, int codigoRecibo) {

		return reciboAguaSocioDao.editarReciboAguaxSocio(pagina, registros,
				puestoSocio, codigoRecibo);
	}

	@Override
	public ReporteReciboAguaSocio reportePuestoxAgua(int pagina, int registros,
			int codigoSector, String nroPuesto, int codigoReciboOriginal) {

		return reciboAguaSocioDao.reportePuestoxAgua(pagina, registros,
				codigoSector, nroPuesto, codigoReciboOriginal);
	}

	@Override
	public Retorno grabarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		return reciboAguaSocioDao.grabarReciboAguaxSocio(reciboAguaSocio);

	}

	@Override
	public ReporteReciboAguaSocio buscarReciboAguaSocio(
			int codigoReciboAguaSocio) {

		return reciboAguaSocioDao.buscarReciboAguaSocio(codigoReciboAguaSocio);

	}

	@Override
	public ReporteReciboAguaSocio reporteAguaSocioExcel(int pagina,
			int registros, int exportar, int codigoAguaOriginal) {

		return reciboAguaSocioDao.reporteAguaSocioExcel(pagina, registros,
				exportar, codigoAguaOriginal);
	}

	@Override
	public Retorno pagarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		return reciboAguaSocioDao.pagarReciboAguaxSocio(reciboAguaSocio);

	}

	@Override
	public File generarFacturacionAguaPDF(Integer codigoRecibo, String periodo) {
		
		Document doc = new Document();
		PdfWriter docWriter = null;
		String path = UtilPDF.RUTA_PDF + UtilPDF.getDatePDF() + ".pdf";
		ReporteReciboAguaSocio reporte = reciboAguaSocioDao.reporteReciboAguaSocio(codigoRecibo, periodo);
		
		try {
			
			docWriter = PdfWriter.getInstance(doc, new FileOutputStream(path));

			doc = UtilPDF.getAutorPDF(doc);
			doc.open();

			PdfContentByte cb = docWriter.getDirectContent();
			
			for (int aw = 0; aw < reporte.getListaReciboAguaSocio().size(); aw++) {
				
				Image logo = Image.getInstance(getClass().getClassLoader().getResource("imagenes/logo.png"));
				doc.add(logo);
				
				Paragraph title = new Paragraph(UtilPDF.TITULO_RECIBO);
				title.setAlignment(Element.ALIGN_CENTER);
				doc.add(title);
				
				Paragraph ruc = new Paragraph(UtilPDF.RUC);
				ruc.setAlignment(Element.ALIGN_CENTER);
				doc.add(ruc);

				Paragraph recibo = new Paragraph(UtilPDF.LEYENDA_RECIBO + reporte.getListaReciboAguaSocio().get(aw).getIdRecibo());
				recibo.setAlignment(Element.ALIGN_CENTER);
				doc.add(recibo);
				
				Image qrcodeImage = UtilPDF.getQRCode(reporte.getListaReciboAguaSocio().get(aw).getIdRecibo() + "");
				qrcodeImage.setAlignment(Element.ALIGN_CENTER);
				doc.add(qrcodeImage);
				
				PdfPTable table0 = new PdfPTable(2);
				table0.setWidthPercentage(100);
				table0.addCell("PERIODO");
				table0.addCell(reporte.getListaReciboAguaSocio().get(aw).getPeriodoSocio() + "");
				
				PdfPTable table1 = new PdfPTable(2);
				table1.setWidthPercentage(100);
				table1.addCell("ASOCIADO (A)");
				table1.addCell(reporte.getListaReciboAguaSocio().get(aw).getNombreFull() + "");
				
				PdfPTable table2 = new PdfPTable(2);
				table2.setWidthPercentage(100);
				table2.addCell("N° DE PUESTO");
				table2.addCell(reporte.getListaReciboAguaSocio().get(aw).getNroPuesto() + "");
				
				PdfPTable table3 = new PdfPTable(2);
				table3.setWidthPercentage(100);				
				table3.addCell("SECTOR");
				table3.addCell(reporte.getListaReciboAguaSocio().get(aw).getNombreSector() + "");
								
				PdfPTable table4 = new PdfPTable(2);
				table4.setWidthPercentage(100);						
				table4.addCell("GIRO");		
				table4.addCell(reporte.getListaReciboAguaSocio().get(aw).getNombreGiro() + "");
				
				table4.setSpacingAfter(20);
				
				PdfPTable table10 = new PdfPTable(2);
				table10.setWidthPercentage(100);						
				table10.addCell("LECTURA ANTERIOR");		
				Paragraph p10 = new Paragraph((reporte.getListaReciboAguaSocio().get(aw).getLecturaInicial() + ""));
				PdfPCell celda10 = new PdfPCell(p10);
				celda10.setHorizontalAlignment(Element.ALIGN_CENTER);
				table10.addCell(celda10);
				
				PdfPTable table11 = new PdfPTable(2);
				table11.setWidthPercentage(100);						
				table11.addCell("LECTURA ACTUAL");		
				Paragraph p11 = new Paragraph((reporte.getListaReciboAguaSocio().get(aw).getLecturaFinal() + ""));
				PdfPCell celda11 = new PdfPCell(p11);
				celda11.setHorizontalAlignment(Element.ALIGN_CENTER);
				table11.addCell(celda11);
				
				table11.setSpacingAfter(20);
				
				doc.add(table1);
				doc.add(table2);
				doc.add(table3);
				doc.add(table4);
				doc.add(table0);
				doc.add(table10);
				doc.add(table11);
				
				PdfPTable table5 = new PdfPTable(2);
				table5.setWidthPercentage(100);
				table5.addCell("CONSUMO DE AGUA");
				Paragraph p5 = new Paragraph(UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getConsumoMes(), 2) + "");
				PdfPCell celda5 = new PdfPCell(p5);
				celda5.setHorizontalAlignment(Element.ALIGN_CENTER);
				table5.addCell(celda5);
				
				PdfPTable table6 = new PdfPTable(2);
				table6.setWidthPercentage(100);
				table6.addCell("ALCANTARILLADO");
				Paragraph p6 = new Paragraph(UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getAlcantarillado(), 2) + "");
				PdfPCell celda6 = new PdfPCell(p6);
				celda6.setHorizontalAlignment(Element.ALIGN_CENTER);
				table6.addCell(celda6);
				
				PdfPTable table7 = new PdfPTable(2);
				table7.setWidthPercentage(100);
				table7.addCell("MANTENIMIENTO");
				Paragraph p7 = new Paragraph(UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getServicioMantenimiento(), 2) + "");
				PdfPCell celda7 = new PdfPCell(p7);
				celda7.setHorizontalAlignment(Element.ALIGN_CENTER);
				table7.addCell(celda7);
				
				PdfPTable table8 = new PdfPTable(2);
				table8.setWidthPercentage(100);
				table8.addCell("DEUDA ANTERIOR");
				Paragraph p8 = new Paragraph(UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getDeudaAnterior(), 2) + "");
				PdfPCell celda8 = new PdfPCell(p8);
				celda8.setHorizontalAlignment(Element.ALIGN_CENTER);
				table8.addCell(celda8);
				
				PdfPTable table9 = new PdfPTable(2);
				table9.setWidthPercentage(100);
				table9.addCell("TOTAL DE AGUA");
				table9.setSpacingBefore(10);
				Double total = 	reporte.getListaReciboAguaSocio().get(aw).getConsumoMes() + 
								reporte.getListaReciboAguaSocio().get(aw).getAlcantarillado() +
								reporte.getListaReciboAguaSocio().get(aw).getServicioMantenimiento() +
								reporte.getListaReciboAguaSocio().get(aw).getDeudaAnterior();
				Paragraph p9 = new Paragraph(UtilPDF.round(total, 2) + "");
				PdfPCell celda9 = new PdfPCell(p9);
				celda9.setHorizontalAlignment(Element.ALIGN_CENTER);
				table9.addCell(celda9);
				
				PdfPTable table12 = new PdfPTable(2);
				table12.setWidthPercentage(100);
				table12.addCell("FECHA DE VENCIMIENTO");
				Paragraph p12 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getFechaVencimiento() + "");
				PdfPCell celda12 = new PdfPCell(p12);
				celda12.setHorizontalAlignment(Element.ALIGN_CENTER);
				table12.addCell(celda12);
				
				PdfPTable table13 = new PdfPTable(2);
				table13.setWidthPercentage(100);
				table13.addCell("FECHA DE CORTE");
				Paragraph p13 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getFechaCorte() + "");
				PdfPCell celda13 = new PdfPCell(p13);
				celda13.setHorizontalAlignment(Element.ALIGN_CENTER);
				table13.addCell(celda13);
				
				PdfPTable table14 = new PdfPTable(2);
				table14.setWidthPercentage(100);
				table14.addCell("OBSERVACIONES");
				Paragraph p14 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getObservaciones() + "");
				PdfPCell celda14 = new PdfPCell(p14);
				celda14.setHorizontalAlignment(Element.ALIGN_CENTER);
				table14.addCell(celda14);
				
				doc.add(table5);
				doc.add(table6);
				doc.add(table7);
				doc.add(table8);
				doc.add(table9);				
				doc.add(table12);
				doc.add(table13);
				doc.add(table14);
				
				doc.newPage();
				
			}

			
			
			
		} catch (Exception e) {
			log.error("Ocurrio un error al generar PDF");
		} finally {
			if (doc != null) {
				doc.close();
			}
			if (docWriter != null) {
				docWriter.close();
			}
		}

		File file = new File(path);
		return file;
	}
}
