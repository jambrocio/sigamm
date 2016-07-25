package pe.com.sigamm.busImpl;

import java.awt.GridLayout;
import java.io.File;
import java.io.FileOutputStream;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

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
	public Retorno eliminarReciboAguaxSocio(ReciboAguaSocio reciboAguaSocio) {

		return reciboAguaSocioDao.eliminarReciboAguaxSocio(reciboAguaSocio);

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
				
				Font fuente = new Font();
				fuente.setStyle(Font.NORMAL);
				fuente.setSize(18);
				
				Font fuente0 = new Font();
				fuente0.setStyle(Font.BOLD);
				fuente0.setSize(18);
				
				Font fuente1 = new Font();
				fuente1.setStyle(Font.BOLD);
				fuente1.setSize(20);
				
				Image logo = Image.getInstance(getClass().getClassLoader().getResource("imagenes/logo.png"));
				doc.add(logo);
				
				Paragraph title = new Paragraph(UtilPDF.TITULO_RECIBO, fuente);
				title.setAlignment(Element.ALIGN_CENTER);
				doc.add(title);
				
				Paragraph ruc = new Paragraph(UtilPDF.RUC, fuente);
				ruc.setAlignment(Element.ALIGN_CENTER);
				doc.add(ruc);

				Paragraph recibo = new Paragraph(UtilPDF.LEYENDA_RECIBO_AGUA + UtilPDF.getID(reporte.getListaReciboAguaSocio().get(aw).getPeriodoSocio(), aw), fuente);
				recibo.setAlignment(Element.ALIGN_CENTER);
				doc.add(recibo);				
								
				PdfPTable table0 = new PdfPTable(2);
				table0.setWidthPercentage(100);
				Paragraph p0 = new Paragraph("PERIODO", fuente);
				PdfPCell celda0 = new PdfPCell(p0);
				table0.addCell(celda0);
				Paragraph p1 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getPeriodoSocio() + "", fuente0);
				PdfPCell celda1 = new PdfPCell(p1);
				celda1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table0.addCell(celda1);
								
				PdfPTable table1 = new PdfPTable(2);
				table1.setWidthPercentage(100);
				table1.setWidths(new int[] {60,120});
				Paragraph p2 = new Paragraph("ASOCIADO (A)", fuente);
				PdfPCell celda2 = new PdfPCell(p2);
				table1.addCell(celda2);
				Paragraph p3 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreFull() + "", fuente);
				PdfPCell celda3 = new PdfPCell(p3);
				celda3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(celda3);
				
				table1.setSpacingBefore(15);
				
				PdfPTable table2 = new PdfPTable(2);
				table2.setWidthPercentage(100);
				table2.setWidths(new int[] {60,120});
				Paragraph p4 = new Paragraph("N° DE PUESTO", fuente);
				PdfPCell celda4 = new PdfPCell(p4);
				table2.addCell(celda4);
				Paragraph p5 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNroPuesto() + "", fuente);
				PdfPCell celda5 = new PdfPCell(p5);
				celda5.setHorizontalAlignment(Element.ALIGN_LEFT);
				table2.addCell(celda5);

				PdfPTable table3 = new PdfPTable(2);
				table3.setWidthPercentage(100);
				table3.setWidths(new int[] {60,120});
				Paragraph p6 = new Paragraph("SECTOR", fuente);
				PdfPCell celda6 = new PdfPCell(p6);
				table3.addCell(celda6);
				Paragraph p7 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreSector() + "", fuente);
				PdfPCell celda7 = new PdfPCell(p7);
				celda7.setHorizontalAlignment(Element.ALIGN_LEFT);
				table3.addCell(celda7);
										
				PdfPTable table4 = new PdfPTable(2);
				table4.setWidthPercentage(100);
				table4.setWidths(new int[] {60,120});
				Paragraph p8 = new Paragraph("GIRO", fuente);
				PdfPCell celda8 = new PdfPCell(p8);
				table4.addCell(celda8);
				Paragraph p9 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreGiro() + "", fuente);
				PdfPCell celda9 = new PdfPCell(p9);
				celda9.setHorizontalAlignment(Element.ALIGN_LEFT);
				table4.addCell(celda9);
				
				table4.setSpacingAfter(15);

				PdfPTable table5 = new PdfPTable(2);
				table5.setWidthPercentage(100);
				Paragraph p10 = new Paragraph("LECTURA ANTERIOR", fuente);
				PdfPCell celda10 = new PdfPCell(p10);
				table5.addCell(celda10);
				Paragraph p11 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getLecturaInicial() + "", fuente);
				PdfPCell celda11 = new PdfPCell(p11);
				celda11.setHorizontalAlignment(Element.ALIGN_CENTER);
				table5.addCell(celda11);
				
				PdfPTable table6 = new PdfPTable(2);
				table6.setWidthPercentage(100);
				Paragraph p12 = new Paragraph("LECTURA ACTUAL", fuente);
				PdfPCell celda12 = new PdfPCell(p12);
				table6.addCell(celda12);
				Paragraph p13 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getLecturaFinal() + "", fuente);
				PdfPCell celda13 = new PdfPCell(p13);
				celda13.setHorizontalAlignment(Element.ALIGN_CENTER);
				table6.addCell(celda13);
				
				table6.setSpacingAfter(15);
				
				PdfPTable table7 = new PdfPTable(2);
				table7.setWidthPercentage(100);
				Paragraph p14 = new Paragraph("CONSUMO DE AGUA", fuente);
				PdfPCell celda14 = new PdfPCell(p14);
				table7.addCell(celda14);
				String valor1 = UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getConsumoMes(), 2) + "";
				Paragraph p15 = new Paragraph(valor1.replace(",", "."), fuente);
				PdfPCell celda15 = new PdfPCell(p15);
				celda15.setHorizontalAlignment(Element.ALIGN_CENTER);
				table7.addCell(celda15);

				PdfPTable table8 = new PdfPTable(2);
				table8.setWidthPercentage(100);
				Paragraph p16 = new Paragraph("ALCANTARILLADO", fuente);
				PdfPCell celda16 = new PdfPCell(p16);
				table8.addCell(celda16);
				String valor2 = UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getAlcantarillado(), 2) + "";
				Paragraph p17 = new Paragraph(valor2.replace(",", "."), fuente);
				PdfPCell celda17 = new PdfPCell(p17);
				celda17.setHorizontalAlignment(Element.ALIGN_CENTER);
				table8.addCell(celda17);
				
				PdfPTable table9 = new PdfPTable(2);
				table9.setWidthPercentage(100);
				Paragraph p18 = new Paragraph("MANTENIMIENTO", fuente);
				PdfPCell celda18 = new PdfPCell(p18);
				table9.addCell(celda18);
				String valor3 = UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getServicioMantenimiento(), 2) + "";
				Paragraph p19 = new Paragraph(valor3.replace(",", "."), fuente);
				PdfPCell celda19 = new PdfPCell(p19);
				celda19.setHorizontalAlignment(Element.ALIGN_CENTER);
				table9.addCell(celda19);
							
				PdfPTable table10 = new PdfPTable(2);
				table10.setWidthPercentage(100);
				Paragraph p20 = new Paragraph("DEUDA ANTERIOR", fuente);
				PdfPCell celda20 = new PdfPCell(p20);
				table10.addCell(celda20);
				String valor4 = UtilPDF.round(reporte.getListaReciboAguaSocio().get(aw).getDeudaAnterior(), 2) + "";
				Paragraph p21 = new Paragraph(valor4.replace(",", "."), fuente);
				PdfPCell celda21 = new PdfPCell(p21);
				celda21.setHorizontalAlignment(Element.ALIGN_CENTER);
				table10.addCell(celda21);
				//----------------------------------------------
				PdfPTable table11 = new PdfPTable(2);
				table11.setWidthPercentage(100);
				Paragraph p22 = new Paragraph("TOTAL DE AGUA       (S/.)", fuente1);
				PdfPCell celda22 = new PdfPCell(p22);
				celda22.setFixedHeight(50f);
				celda22.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda22.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table11.addCell(celda22);
				table11.setSpacingBefore(15);
				
				Double total = 	reporte.getListaReciboAguaSocio().get(aw).getConsumoMes() + 
								reporte.getListaReciboAguaSocio().get(aw).getAlcantarillado() +
								reporte.getListaReciboAguaSocio().get(aw).getServicioMantenimiento() +
								reporte.getListaReciboAguaSocio().get(aw).getDeudaAnterior();
				String valor5 = UtilPDF.round(total, 2) + "";
				Paragraph p23 = new Paragraph(valor5.replace(",", "."), fuente1);
				PdfPCell celda23 = new PdfPCell(p23);
				celda23.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda23.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table11.addCell(celda23);
				//----------------------------------------------
				PdfPTable table12 = new PdfPTable(2);
				table12.setWidthPercentage(100);
				Paragraph p24 = new Paragraph("FECHA DE VENCIMIENTO", fuente1);
				PdfPCell celda24 = new PdfPCell(p24);
				celda16.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda16.setVerticalAlignment(Element.ALIGN_BOTTOM);
				celda16.setFixedHeight(50f);
				Paragraph p25 = new Paragraph("FECHA DE CORTE", fuente1);
				PdfPCell celda25 = new PdfPCell(p25);
				celda25.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda25.setVerticalAlignment(Element.ALIGN_BOTTOM);
				table12.addCell(celda24);
				table12.addCell(celda25);
				
				//----------------------------------------------
				PdfPTable table13 = new PdfPTable(2);
				table13.setWidthPercentage(100);
				
				Paragraph p26 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getFechaVencimiento() + "", fuente1);
				PdfPCell celda26 = new PdfPCell(p26);
				celda26.setFixedHeight(50f);
				celda26.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda26.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda26);
				
				Paragraph p27 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getFechaCorte() + "", fuente1);
				PdfPCell celda27 = new PdfPCell(p27);
				celda27.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda27.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda27);
				//----------------------------------------------
				
				Image qrcodeImage = UtilPDF.getQRCode("PUESTO: " + reporte.getListaReciboAguaSocio().get(aw).getNroPuesto() + "- NOMBRE: " + reporte.getListaReciboAguaSocio().get(aw).getNombreFull() + "- TOTAL A PAGAR: S/. [" + valor5 + "]");
				qrcodeImage.setAbsolutePosition(500, 690);
				doc.add(qrcodeImage);
				
				doc.add(table1);
				doc.add(table2);
				doc.add(table3);
				doc.add(table4);
				doc.add(table0);
				doc.add(table5);
				doc.add(table6);
				doc.add(table7);
				doc.add(table8);
				doc.add(table9);				
				doc.add(table10);
				doc.add(table11);
				doc.add(table12);
				doc.add(table13);
				
				Paragraph observaciones = new Paragraph("OBSERVACIONES:");
				Paragraph observacionesDetalle = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getObservaciones() + "");
				
				observaciones.setSpacingBefore(15);
				
				doc.add(observaciones);
				doc.add(observacionesDetalle);
				
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
	
	
	@Override
	public File generarFacturacionVigilanciaPDF(String periodo) {
		
		Document doc = new Document();
		PdfWriter docWriter = null;
		String path = UtilPDF.RUTA_PDF + UtilPDF.getDatePDF() + ".pdf";
		
		try {
			
			ReporteReciboAguaSocio reporte = reciboAguaSocioDao.generacionPdfVigilancia(periodo);
			
			docWriter = PdfWriter.getInstance(doc, new FileOutputStream(path));

			doc = UtilPDF.getAutorPDF(doc);
			doc.open();

			PdfContentByte cb = docWriter.getDirectContent();
			
			for (int aw = 0; aw < reporte.getListaReciboAguaSocio().size(); aw++) {
				
				Font fuente = new Font();
				fuente.setStyle(Font.NORMAL);
				fuente.setSize(18);
				
				Font fuente0 = new Font();
				fuente0.setStyle(Font.BOLD);
				fuente0.setSize(18);
				
				Font fuente1 = new Font();
				fuente1.setStyle(Font.BOLD);
				fuente1.setSize(20);
				
				Image logo = Image.getInstance(getClass().getClassLoader().getResource("imagenes/logo.png"));
				doc.add(logo);
				
				Paragraph title = new Paragraph(UtilPDF.TITULO_RECIBO, fuente);
				title.setAlignment(Element.ALIGN_CENTER);
				doc.add(title);
				
				Paragraph ruc = new Paragraph(UtilPDF.RUC, fuente);
				ruc.setAlignment(Element.ALIGN_CENTER);
				doc.add(ruc);

				Paragraph recibo = new Paragraph(UtilPDF.LEYENDA_RECIBO_VIGILANCIA + UtilPDF.getID(reporte.getListaReciboAguaSocio().get(aw).getPeriodoSocio(), aw), fuente);
				recibo.setAlignment(Element.ALIGN_CENTER);
				doc.add(recibo);
								
				PdfPTable table0 = new PdfPTable(2);
				table0.setWidthPercentage(100);
				Paragraph p0 = new Paragraph("PERIODO", fuente);
				PdfPCell celda0 = new PdfPCell(p0);
				table0.addCell(celda0);
				Paragraph p1 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getPeriodoSocio() + "", fuente0);
				PdfPCell celda1 = new PdfPCell(p1);
				celda1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table0.addCell(celda1);
								
				PdfPTable table1 = new PdfPTable(2);
				table1.setWidthPercentage(100);
				table1.setWidths(new int[] {60,120});
				Paragraph p2 = new Paragraph("ASOCIADO (A)", fuente);
				PdfPCell celda2 = new PdfPCell(p2);
				table1.addCell(celda2);
				Paragraph p3 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreFull() + "", fuente);
				PdfPCell celda3 = new PdfPCell(p3);
				celda3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(celda3);
				
				table1.setSpacingBefore(15);
				
				PdfPTable table2 = new PdfPTable(2);
				table2.setWidthPercentage(100);
				table2.setWidths(new int[] {60,120});
				Paragraph p4 = new Paragraph("N° DE PUESTO", fuente);
				PdfPCell celda4 = new PdfPCell(p4);
				table2.addCell(celda4);
				Paragraph p5 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNroPuesto() + "", fuente);
				PdfPCell celda5 = new PdfPCell(p5);
				celda5.setHorizontalAlignment(Element.ALIGN_LEFT);
				table2.addCell(celda5);

				PdfPTable table3 = new PdfPTable(2);
				table3.setWidthPercentage(100);
				table3.setWidths(new int[] {60,120});
				Paragraph p6 = new Paragraph("SECTOR", fuente);
				PdfPCell celda6 = new PdfPCell(p6);
				table3.addCell(celda6);
				Paragraph p7 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreSector() + "", fuente);
				PdfPCell celda7 = new PdfPCell(p7);
				celda7.setHorizontalAlignment(Element.ALIGN_LEFT);
				table3.addCell(celda7);
										
				PdfPTable table4 = new PdfPTable(2);
				table4.setWidthPercentage(100);
				table4.setWidths(new int[] {60,120});
				Paragraph p8 = new Paragraph("GIRO", fuente);
				PdfPCell celda8 = new PdfPCell(p8);
				table4.addCell(celda8);
				Paragraph p9 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getNombreGiro() + "", fuente);
				PdfPCell celda9 = new PdfPCell(p9);
				celda9.setHorizontalAlignment(Element.ALIGN_LEFT);
				table4.addCell(celda9);
				
				table4.setSpacingAfter(15);

				PdfPTable table5 = new PdfPTable(2);
				table5.setWidthPercentage(100);
				Paragraph p10 = new Paragraph("VIGILANCIA DEL MES", fuente);
				PdfPCell celda10 = new PdfPCell(p10);
				table5.addCell(celda10);
				Paragraph p11 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getConsumoMes() + "", fuente);
				PdfPCell celda11 = new PdfPCell(p11);
				celda11.setHorizontalAlignment(Element.ALIGN_CENTER);
				table5.addCell(celda11);
				
				PdfPTable table6 = new PdfPTable(2);
				table6.setWidthPercentage(100);
				Paragraph p12 = new Paragraph("DEUDA ANTERIOR VIGILANCIA", fuente);
				PdfPCell celda12 = new PdfPCell(p12);
				table6.addCell(celda12);
				Paragraph p13 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getDeudaAnteriorVigilancia() + "", fuente);
				PdfPCell celda13 = new PdfPCell(p13);
				celda13.setHorizontalAlignment(Element.ALIGN_CENTER);
				table6.addCell(celda13);
				
				PdfPTable table7 = new PdfPTable(2);
				table7.setWidthPercentage(100);
				Paragraph p14 = new Paragraph("CUOTA ADMINISTRATIVA DEL MES", fuente);
				PdfPCell celda14 = new PdfPCell(p14);
				table7.addCell(celda14);
				Paragraph p15 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getCuotaAdministrativa() + "", fuente);
				PdfPCell celda15 = new PdfPCell(p15);
				celda15.setHorizontalAlignment(Element.ALIGN_CENTER);
				table7.addCell(celda15);
				
				PdfPTable table8 = new PdfPTable(2);
				table8.setWidthPercentage(100);
				Paragraph p16 = new Paragraph("DEUDA ANTERIOR CUOTA ADMINISTRATIVA", fuente);
				PdfPCell celda16 = new PdfPCell(p16);
				table8.addCell(celda16);
				Paragraph p17 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getDeudaAnteriorCtaAdm() + "", fuente);
				PdfPCell celda17 = new PdfPCell(p17);
				celda17.setHorizontalAlignment(Element.ALIGN_CENTER);
				table8.addCell(celda17);
				
				table8.setSpacingAfter(15);
								
				//----------------------------------------------
				PdfPTable table11 = new PdfPTable(2);
				table11.setWidthPercentage(100);
				Paragraph p22 = new Paragraph("TOTAL (S/.)", fuente1);
				PdfPCell celda22 = new PdfPCell(p22);
				celda22.setFixedHeight(50f);
				celda22.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda22.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table11.addCell(celda22);
				table11.setSpacingBefore(15);
				
				Double total = 	reporte.getListaReciboAguaSocio().get(aw).getTotal();
				String valor5 = UtilPDF.round(total, 2) + "";
				Paragraph p23 = new Paragraph(valor5.replace(",", "."), fuente1);
				PdfPCell celda23 = new PdfPCell(p23);
				celda23.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda23.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table11.addCell(celda23);
				//----------------------------------------------
				
				PdfPTable table12 = new PdfPTable(2);
				table12.setWidthPercentage(100);
				
				Paragraph p24 = new Paragraph("FECHA DE VENCIMIENTO", fuente1);
				PdfPCell celda24 = new PdfPCell(p24);
				celda12.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda12.setVerticalAlignment(Element.ALIGN_BOTTOM);
				celda12.setFixedHeight(50f);
				
				Paragraph p25 = new Paragraph(" ", fuente1);
				PdfPCell celda25 = new PdfPCell(p25);
				celda25.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda25.setVerticalAlignment(Element.ALIGN_BOTTOM);
				table12.addCell(celda24);
				table12.addCell(celda25);
				
				//----------------------------------------------
				
				PdfPTable table13 = new PdfPTable(2);
				table13.setWidthPercentage(100);
				
				Paragraph p26 = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getFechaVencimiento() + "", fuente1);
				PdfPCell celda26 = new PdfPCell(p26);
				celda26.setFixedHeight(50f);
				celda26.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda26.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda26);
				
				Paragraph p27 = new Paragraph("", fuente1);
				PdfPCell celda27 = new PdfPCell(p27);
				celda27.setHorizontalAlignment(Element.ALIGN_CENTER);
				celda27.setVerticalAlignment(Element.ALIGN_MIDDLE);
				table13.addCell(celda27);
				
				//----------------------------------------------				
				Image qrcodeImage = UtilPDF.getQRCode("PUESTO: " + reporte.getListaReciboAguaSocio().get(aw).getNroPuesto() + "- NOMBRE: " + reporte.getListaReciboAguaSocio().get(aw).getNombreFull() + "- TOTAL A PAGAR S/. [" + valor5 + "]");
				qrcodeImage.setAbsolutePosition(500, 690);
				doc.add(qrcodeImage);
				
				doc.add(table1);
				doc.add(table2);
				doc.add(table3);
				doc.add(table4);
				doc.add(table0);
				doc.add(table5);
				doc.add(table6);
				doc.add(table7);
				doc.add(table8);
				doc.add(table11);
				doc.add(table12);
				doc.add(table13);
				
				/*
				Paragraph observaciones = new Paragraph("OBSERVACIONES:");
				Paragraph observacionesDetalle = new Paragraph(reporte.getListaReciboAguaSocio().get(aw).getObservaciones() + "");
				
				observaciones.setSpacingBefore(15);
				
				doc.add(observaciones);
				doc.add(observacionesDetalle);
				*/
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
	
	@Override
	public void imprimirFactura(){
		
		 try {
             //javax.swing.JPanel panel = new javax.swing.JPanel(new java.awt.BorderLayout());
			 javax.swing.JPanel panel = new javax.swing.JPanel(new GridLayout(15,100,2,2));
             panel.setSize(588, 600);
             javax.swing.JTextArea area = new javax.swing.JTextArea(15,100);
             area.setBounds(0, 0, 600, 500);
             panel.add(area);
             java.awt.Font font = new java.awt.Font("Arial",java.awt.Font.PLAIN,8);
             area.setFont(font);
             area.setLineWrap(true);
             area.append("     ASOCIACION DE COMERCIANTES DEL MERCADO      |     ASOCIACION DE COMERCIANTES DEL MERCADO\n");
             area.append("                               MODELO DE HUARAL                           |                     MODELO DE HUARAL           \n");
             area.append("                       Fundado el 13 de Noviembre de 1996                    |             Fundado el 13 de Noviembre de 1996   \n");
             area.append("                                 R.U.C. 20530606334                             |                    R.U.C. 20530606334             \n");
             area.append("\n");
             /*area.append("\u0020\u0020\u0020\u0020RECIBO Nº 202\u0020\u0020\u0020\u0020|\u0020\u0020\u0020\u0020RECIBO Nº 202\u0020\u0020\u0020\u0020\n");
             area.append("\n");
             area.append("\tFECHA:   02/04/2016                      |\tFECHA:   02/04/2016                      \n");
             area.append("\tASOCIADO:AMBROCIO SERNAQUE, CHRISTIAN    |\tASOCIADO:AMBROCIO SERNAQUE, CHRISTIAN    \n");
             area.append("\tSECTOR:  01                              |\tSECTOR:  01                              \n");
             area.append("\tPUESTO:  9999                            |\tPUESTO:  9999                            \n");
             area.append("\tGIRO:    BAZAR-ZAPATERIA                 |\tGIRO:    BAZAR-ZAPATERIA                 \n");
             area.append("=============================================================================================\n");*/

                      
           //  System.out.println("Row Count is :" + tm.getRowCount());
             //for (int i = 0; i < tm.getRowCount(); i++) {
                 //area.append("\t" + tblRecord.getValueAt(i, 0) + "\t\t" + tblRecord.getValueAt(i, 1) + "\t" + tblRecord.getValueAt(i, 3) + "\t" + tblRecord.getValueAt(i, 5) );
                 //area.append("\n--------------------------------------------------------------------------------------------------------------------------------------------------------------\n");
                 area.append("\t  OneOneOne \t\tTwoTwoTwo\tThreeThreeThree\tFourFour" );
                 area.append("\n--------------------------------------------------------------------------------------------------------------------------------------------------------------\n");


            // }

         //    area.append("\n\tTotal :\t"+lblTotal.getText()+"\tDiscounte :\t"+tfDisc.getText());
          //    area.append("\n\tRecieve :\t"+tfRecieve.getText()+"\tFinal Total :\t"+lblFinal.getText());
           //   area.append("\n\tBalance :\t"+lblBal.getText());

             PrintUtilities pu = new PrintUtilities(area);
             panel.setVisible(true);
             pu.print();
             
             /*JFrame winMain = new JFrame("Mostrar / Ocultar Jpanel");
             winMain.setLayout(new BorderLayout(4, 4));  
        
      
             winMain.add(panel, BorderLayout.NORTH); 
      
             winMain.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
             winMain.setSize(360, 300);
             winMain.setResizable(false);
             winMain.setVisible(true);*/
             
         } catch (Exception e) {
             System.out.println("Error in Print Button :" + e);
         }

	}
}
